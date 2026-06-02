module sp_gpio (
	// Input
	input logic        i_clk,
	input logic        i_reset_n,
	input logic [31:0] i_data,
	input logic        i_port_r,
	input logic        i_port_w,
	input logic        i_dir_r,
	input logic        i_dir_w,
	input logic [1:0]  i_wSize,
	input logic [1:0]  i_wOffset,

	// Output
	output logic [31:0] o_data,

	// GPIO only wires
	inout wire [31:0] io_gpio
);

	// 1 = software-configurable GPIO
	// 0 = forced output-only
	localparam logic [31:0] IO_ENABLE = 32'b1111_1111_1000_0000_1111_1111_1000_0000;

	// Internal Signals
	logic [31:0] r_direction; // 0 for input, 1 for output
	logic [31:0] r_out_reg;
	logic [31:0] r_pin_reg;

	logic [31:0] w_sig_in;
	logic [31:0] w_sig_db;

	genvar i;
	generate
		for (i = 0; i < 32; i++) begin : gen_bits
			pin_io u_pin_io (
				.i_clk     (i_clk),
				.i_dir     (r_direction[i]),
				.i_dataSend(r_out_reg[i]),
				.o_dataRecv(w_sig_in[i]),
				.io_pin    (io_gpio[i])
			);

			debounce u_db (
				.i_clk    (i_clk),
				.i_reset_n(i_reset_n),
				.i_pin    (w_sig_in[i]),
				.o_pin    (w_sig_db[i])
			);
		end
	endgenerate

	always_ff @(posedge i_clk) begin
		if (~i_reset_n) begin
			r_direction <= 32'hFFFF_FFFF;
			r_out_reg   <= 32'hFFFF_FFFF;
			r_pin_reg   <= 32'h0000_0000;
		end else begin
			r_pin_reg <= w_sig_db;

			if (i_dir_w) begin
				unique case (i_wSize)
					// Disabled bits are forced to output.
					2'b00: begin
						unique case (i_wOffset[1:0])
							2'b00: r_direction[7:0]   <= i_data[7:0] | ~IO_ENABLE[7:0];
							2'b01: r_direction[15:8]  <= i_data[7:0] | ~IO_ENABLE[15:8];
							2'b10: r_direction[23:16] <= i_data[7:0] | ~IO_ENABLE[23:16];
							2'b11: r_direction[31:24] <= i_data[7:0] | ~IO_ENABLE[31:24];
						endcase
					end
					2'b01: begin
						unique case (i_wOffset[1])
							1'b0: r_direction[15:0]  <= i_data[15:0] | ~IO_ENABLE[15:0];
							1'b1: r_direction[31:16] <= i_data[15:0] | ~IO_ENABLE[31:16];
						endcase
					end
					2'b10: begin
						r_direction <= i_data | ~IO_ENABLE;
					end
					default: begin
						// nothing
					end
				endcase
			end

			if (i_port_w) begin
				unique case (i_wSize)
                    2'b00: begin
                        unique case (i_wOffset[1:0]) // Byte-aligned access
                            2'b00: r_out_reg[7:0] <= i_data[7:0];
                            2'b01: r_out_reg[15:8] <= i_data[7:0];
                            2'b10: r_out_reg[23:16] <= i_data[7:0];
                            2'b11: r_out_reg[31:24] <= i_data[7:0];
                        endcase
                    end
                    2'b01: begin
                        unique case (i_wOffset[1]) // Halfword-aligned access
                            1'b0: r_out_reg[15:0] <= i_data[15:0];
                            1'b1: r_out_reg[31:16] <= i_data[15:0];
                        endcase
                    end
                    2'b10: r_out_reg <= i_data; // Word-aligned access
                    default: begin
                        //nothing
                    end
                endcase
			end
		end
	end

	always_comb begin
		o_data = 32'b0;

		if (i_dir_r) begin
			o_data = r_direction;
		end else if (i_port_r) begin
			// Output pins read as output latch.
			// Input pins read as debounced physical pin state.
			o_data = (r_direction & r_out_reg) | (~r_direction & r_pin_reg);
		end
	end

endmodule : sp_gpio
