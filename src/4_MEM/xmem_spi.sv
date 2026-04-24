module xmem_spi (
	// Input
	input logic i_clk,
	input logic i_reset_n,
	input logic [31:0] i_dataIn,
	input logic [7:0] i_compByte,

	// Control Sigs
	input logic i_spi_en,
	input logic i_spi_rw, 		// 0 for reads, 1 for writes

	// Output
	output logic [31:0] o_dataOut,
	output logic o_compMatch,

	// Inout
	inout wire [3:0] io_QSPI
);

	// Internals
	logic [31:0] w_dataBuf;
	logic w_select;

	logic [3:0] w_inBuf;
	logic [3:0] w_outBuf;


	// IO Pins
	genvar i;
    generate
        for (i = 0; i < 4; i++) begin : gen_bits
            pin_io u_pin_io (
                .i_clk     (i_clk),
                .i_dir     (i_spi_rw),
                .i_dataSend(w_outBuf[i]),
                .o_dataRecv(w_inBuf[i]),
                .io_pin    (io_QSPI[i])
            );
        end
    endgenerate


	always_ff @(posedge i_clk) begin
		if(~i_reset_n) begin
			w_dataBuf <= 0;
		end else begin
			if (i_spi_en == 0) begin
				// Word Buffering
				if (i_spi_rw == 0) begin
					o_dataOut <= w_dataBuf;
				end else if (i_spi_rw == 1) begin
					w_dataBuf <= i_dataIn;
				end
			end else if (i_spi_en == 1) begin
				// Shifting In/Out
				if (i_spi_rw == 0) begin
					w_dataBuf <= {w_inBuf, w_dataBuf[31:4]};
				end else if (i_spi_rw == 1) begin
					w_outBuf <= w_dataBuf[3:0];
					w_dataBuf <= {{4{1'b0}}, w_dataBuf[31:4]};
				end
			end
		end
	end

	// Shifter Reading for finding signals
	assign o_compMatch = (w_dataBuf[31:24] == i_compByte);



endmodule : xmem_spi
