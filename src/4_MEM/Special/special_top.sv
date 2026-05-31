module special_top (
	// Input
	input logic i_clk,    		// CPU clock
	input logic i_reset_n,    	// Synchronous reset active low
	input logic [31:0] i_address,
	input logic [31:0] i_dataWrite,
	input macro_pkg::mem_ctrl_t i_ctrlMEM,

	// Enable
	input logic en_SPC,

	// Output
	output logic [31:0] o_dataRead,

	// GPIO Lines
	inout wire [31:0] io_gpio
);

	// Interal Signals
	logic [31:0] w_outBuf;
	logic [31:0] w_outRaw;

	logic [31:0] w_gData_i;
	logic [31:0] w_gData_o;
	logic w_gPort_r;
	logic w_gPort_w;
	logic w_gDir_r;
	logic w_gDir_w;

	logic [31:0] w_count;
	logic w_countReset;

	always_comb begin
		w_outRaw = 32'b0;
		w_gData_i = 32'b0;
		{w_gPort_r, w_gPort_w, w_gDir_r, w_gDir_w} = 4'b0;
		w_countReset = 0;

		// Addressing Mux
		if (i_address[31:16] == 16'h3000) begin
			// GPIO
			w_gData_i = i_dataWrite;
			if (i_address[15:0] == 16'h0000) begin
				w_gPort_r = i_ctrlMEM.memRead;
				w_gPort_w = i_ctrlMEM.memWrite;
			end else if (i_address[15:0] == 16'h0004) begin
				w_gDir_r = i_ctrlMEM.memRead;
				w_gDir_w = i_ctrlMEM.memWrite;
			end
			w_outRaw = w_gData_o;

		end else if (i_address[31:16] == 16'h3001) begin
			// Counter
			w_outRaw = w_count;
			if (i_address[15:0] == 16'h1000 && i_ctrlMEM.memWrite) begin
				w_countReset = 1'b1;
			end

		end

		// Output Size Processing
        unique case (i_ctrlMEM.size)
            2'b00: begin
                unique case (i_address[1:0]) // Byte-aligned access, LB/LBU
                    2'b00: begin
                        w_outBuf = {
                                (!i_ctrlMEM.sign)?{24{w_outRaw[7]}}:{24'b0},
                                w_outRaw[7:0]
                                };
                    end
                    2'b01: begin
                        w_outBuf = {
                                (!i_ctrlMEM.sign)?{24{w_outRaw[15]}}:{24'b0},
                                w_outRaw[15:8]
                                };
                    end
                    2'b10: begin
                        w_outBuf = {
                                (!i_ctrlMEM.sign)?{24{w_outRaw[23]}}:{24'b0},
                                w_outRaw[23:16]
                                };
                    end
                    2'b11: begin
                        w_outBuf = {
                                (!i_ctrlMEM.sign)?{24{w_outRaw[31]}}:{24'b0},
                                w_outRaw[31:24]
                                };
                    end
                endcase
            end
            2'b01: begin
                unique case (i_address[1]) // Halfword-aligned access, LH/LHU
                    1'b0: begin
                        w_outBuf = {
                                (!i_ctrlMEM.sign)?{16{w_outRaw[15]}}:{16'b0},
                                w_outRaw[15:0]
                                };
                    end
                    1'b1: begin
                        w_outBuf = {
                                (!i_ctrlMEM.sign)?{16{w_outRaw[31]}}:{16'b0},
                                w_outRaw[31:16]
                                };
                    end
                endcase
            end
            2'b10: begin
                w_outBuf = w_outRaw; // Word-aligned access
            end
            default: begin
                w_outBuf = 32'b0;
            end
        endcase
    end

    always_ff @(posedge i_clk) begin
    	if(~i_reset_n) begin
    		o_dataRead <= 0;
    	end else begin
    		if (en_SPC) begin
    			o_dataRead <= w_outBuf;
    		end
    	end
    end

    sp_gpio GPIO (
    	.i_clk    (i_clk),
    	.i_reset_n(i_reset_n),
    	.i_data   (w_gData_i),
    	.i_port_r (w_gPort_r),
    	.i_port_w (w_gPort_w),
    	.i_dir_r  (w_gDir_r),
    	.i_dir_w  (w_gDir_w),
    	.i_wSize  (i_ctrlMEM.size),
    	.i_wOffset(i_address[1:0]),
    	.o_data   (w_gData_o),
    	.io_gpio  (io_gpio)
    );

    sp_counter COUNT (
    	.i_clk    (i_clk),
    	.i_reset_n(i_reset_n),
    	.i_clear  (w_countReset),
    	.o_count  (w_count)
    );



endmodule : special_top
