module xmem_spi (
	// Input
	input logic i_clk,
	input logic i_reset_n,
	input logic [31:0] i_dataIn,
	input logic [31:0] i_dataIn_dbl,
	input logic [7:0] i_compareByte,

	// Control Sigs
	input logic i_spi_en,
	input logic i_spi_rw, 		// 0 for reads, 1 for writes
	input logic i_spi_dbl,

	// Output
	output logic [31:0] o_dataOut,
	output logic o_compareHit,

	// Data Lines
	// inout wire [3:0] io_QSPI
	output logic o_MOSI,
	input wire i_MISO
);

	// Internals
	logic [31:0] w_dataBuf;
	logic [31:0] w_dataBuf_ext;
	logic w_select;

	// logic [3:0] w_inBuf;
	logic w_outBuf;


	// // IO Pins
	// genvar i;
    // generate
    //     for (i = 0; i < 4; i++) begin : gen_bits
    //         pin_io u_pin_io (
    //             .i_clk     (i_clk),
    //             .i_dir     (i_spi_rw),
    //             .i_dataSend(w_outBuf[i]),
    //             .o_dataRecv(w_inBuf[i]),
    //             .io_pin    (io_QSPI[i])
    //         );
    //     end
    // endgenerate

    always_ff @(negedge i_clk) begin
    	if(~i_reset_n) begin
    		o_MOSI <= 1;
    	end else begin
    		o_MOSI <= w_outBuf;
    	end
    end


	always_ff @(posedge i_clk) begin
		if(~i_reset_n) begin
			w_dataBuf <= 32'h0;
			w_dataBuf_ext <= 32'h0;
			w_outBuf <= 1;
		end else begin
			if (i_spi_en == 0) begin
				// Word Buffering
				if (i_spi_rw == 0) begin
					o_dataOut <= w_dataBuf;
				end else if (i_spi_rw == 1) begin
					w_dataBuf <= i_dataIn;
					w_dataBuf_ext <= i_dataIn_dbl;
				end
			end else if (i_spi_en == 1) begin
				// Shifting In/Out
				if (i_spi_rw == 0) begin
					// Receiving
					w_dataBuf <= {w_dataBuf[30:0], i_MISO};
				end else if (i_spi_rw == 1) begin
					// Sending
					w_outBuf <= w_dataBuf[31];
					// need to add double word send option
					if(i_spi_dbl == 0) begin
						w_dataBuf <= {w_dataBuf[30:0], 1'b0};
					end else begin
						w_dataBuf <= {w_dataBuf[30:0], w_dataBuf_ext[31]};
						w_dataBuf_ext <= {w_dataBuf_ext[30:0], 1'b0};
					end
				end
			end
		end
	end

	// Shifter Reading for finding signals
	assign o_compareHit = (w_dataBuf[31:24] == i_compareByte);



endmodule : xmem_spi
