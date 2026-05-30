module sp_gpio (
	// Input
	input logic i_clk,
	input logic i_reset_n,
	input logic [31:0] i_data,
	input logic i_port_r,
	input logic i_port_w,
	input logic i_dir_r,
	input logic i_dir_w,

	// Output
	output logic [31:0] o_data,

	// GPIO only wires
	inout wire [31:0] io_gpio
);
	// Config IO Enable
	localparam IO_ENABLE = 32'b1111_1111_1000_0000_1111_1111_1000_0000;

	// Internal Signals
	logic [31:0] w_direction;	// 0 for input, 1 for output
	logic [31:0] w_port_reg;
	logic [31:0] w_sig_in;
	logic [31:0] w_sig_db;


	genvar i;
    generate
        for (i = 0; i < 32; i++) begin : gen_bits
            pin_io u_pin_io (
            	.i_clk     (i_clk),
            	.i_dir     (w_direction[i]),
            	.i_dataSend(w_port_reg[i]),
            	.o_dataRecv(w_sig_in[i]),
            	.io_pin    (io_gpio[i])
            );

            debounce u_db (
            	.i_clk    (i_clk),
            	.i_reset_n(i_reset_n),
            	.i_pin    (w_sig_in[i]),
            	.o_pin    (w_sig_db[i])
            );

            always_ff @(posedge i_clk) begin
            	if(~i_reset_n) begin
            		w_port_reg[i] <= 1'b1;
            	end else begin
            		if(~w_direction[i]) begin
            			w_port_reg[i] <= w_sig_db[i];
            		end else begin
            			if (i_port_w) begin
            				w_port_reg[i] <=i_data[i];
            			end
            		end
            	end
            end
        end
    endgenerate

    always_ff @(posedge i_clk) begin
		if(~i_reset_n) begin
			w_direction[i] <= 1'b1;
		end else begin
			if(i_dir_w) begin
				// Force disabled bits to be output only
				w_direction <= i_data | ~IO_ENABLE;
			end
		end
	end

	always_comb begin
		o_data = 32'b0;
		if (i_dir_r) begin
			o_data = w_direction;
		end else if (i_port_r) begin
			o_data = w_port_reg;
		end
	end

endmodule : sp_gpio
