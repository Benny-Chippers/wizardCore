module xmem_top (
	// Input
	input logic i_clk_cpu,    // CPU clock
	input logic i_clk_spi,    // SPI clock
	input logic i_reset_n,  // Asynchronous reset active low
	input [31:0] i_address,
	input [31:0] i_dataWrite,
	input macro_pkg::mem_ctrl_t i_mem_ctrl,

	// Enable
	input logic en_SPI,

	// Output
	output logic o_stall,
	output [31:0] o_dataRead,

	output logic o_clk_QSPI,
	output logic o_select_QSPI,
	inout wire [3:0] io_QSPI
);

	// Internal Signals
	macro_pkg::spi_req_t w_packet_CPU_CDC;		// CPU -> QSPI
	macro_pkg::spi_req_t w_packet_QSPI_CDC;
	logic [31:0] w_data_CPU_CDC;				// QSPI -> CPU
	logic [31:0] w_data_QSPI_CDC;

	macro_pkg::xmem_ctrl_t spi_ctrl;
	logic w_stall_buf;

	logic [31:0] w_sendData;
	logic [31:0] w_recvData;
	logic w_saveData;
	logic [7:0] w_compareByte;
	logic w_compareHit;


	// Handsake CPU -> QSPI
	logic w_src_send_CPU;
	logic w_src_rcv_CPU;
	logic w_dest_req_QSPI;

	// Handsake QSPI -> CPU
	logic w_src_send_QSPI;
	logic w_src_rcv_QSPI;
	logic w_dest_req_CPU;


	// ONLY CPU SIDE SIGNALS
	always_comb begin
		if (en_SPI == 0) begin
			o_stall = 0;
			w_packet_CPU_CDC = 0;
		end else begin
			// assemble packet
			w_packet_CPU_CDC.read = i_mem_ctrl.memRead;
			w_packet_CPU_CDC.write = i_mem_ctrl.memWrite;
			w_packet_CPU_CDC.addr = i_address;
			w_packet_CPU_CDC.wdata = i_dataWrite;
			// stall = (mem.write | mem.read) & ~done (~dest_req)
			o_stall = (i_mem_ctrl.memWrite | i_mem_ctrl.memRead) & ~w_dest_req_CPU;
		end
	end

	always_ff @(posedge i_clk_cpu) begin
		if(~i_reset_n) begin
			w_stall_buf <= 0;
			w_src_send_CPU <= 0;
		end else begin
			// goes high when stall 0 -> 1 (stall & ~stall_delay)
			// resets when src_rcv_CPU asserted
			w_stall_buf <= o_stall;
			if(w_src_rcv_CPU) begin
				w_src_send_CPU <= 0;
			end else if (o_stall & ~w_stall_buf) begin
				w_src_send_CPU <= 1;
			end
		end
	end

	// Send Data Selction
	localparam logic [1:0] NOTHING 	= 2'b00;
	localparam logic [1:0] ADDRESS 	= 2'b01;
	localparam logic [1:0] DATA 	= 2'b10;
	localparam logic [1:0] COMPLETE = 2'b11;

	// ONLY QSPI SIDE SIGNALS
	always_comb begin
		o_clk_QSPI = i_clk_spi & ~spi_ctrl.select;
		o_select_QSPI = spi_ctrl.select;
		unique case (spi_ctrl.sendSelect)
			NOTHING : w_sendData = 32'b0;
			ADDRESS : w_sendData = w_packet_QSPI_CDC.addr;
			DATA 	: w_sendData = w_packet_QSPI_CDC.wdata;
			COMPLETE: w_sendData = 32'h0000_00A0;
			default : w_sendData = 32'b0;
		endcase
	end

	always_ff @(posedge i_clk_spi) begin
		if(~i_reset_n) begin
			w_data_QSPI_CDC <= 0;
		end else begin
			if(w_saveData) begin
				w_data_QSPI_CDC <= w_recvData;
			end
		end
	end

	`ifdef SIMULATION
	// Emulation
	// CDC Handshakes
	`else
	// Vivado IP
	xpm_cdc_handshake #(
	   .DEST_EXT_HSK(0),   // DECIMAL; 0=internal handshake, 1=external handshake
	   .DEST_SYNC_FF(3),   // DECIMAL; range: 2-10
	   .INIT_SYNC_FF(0),   // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
	   .SIM_ASSERT_CHK(1), // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
	   .SRC_SYNC_FF(3),    // DECIMAL; range: 2-10
	   .WIDTH(66)          // DECIMAL; range: 1-1024
	)
	HANDSHAKE_CPU_QSPI (
	   .src_clk(i_clk_cpu),   		// 1-bit input: Source clock.
	   .src_in(w_packet_CPU_CDC),	// WIDTH-bit input: Input bus that will be synchronized to the destination clock domain.
	   .src_send(w_src_send_CPU), 	// 1-bit input: Assertion of this signal allows the src_in bus to be synchronized to the destination clock domain. This
	                        		// signal should only be asserted when src_rcv is deasserted, indicating that the previous data transfer is complete. This
	                        		// signal should only be deasserted once src_rcv is asserted, acknowledging that the src_in has been received by the
	                        		// destination logic.
	   .src_rcv(w_src_rcv_CPU),   	// 1-bit output: Acknowledgement from destination logic that src_in has been received. This signal will be deasserted once
	                        		// destination handshake has fully completed, thus completing a full data transfer. This output is registered.

	   .dest_clk(i_clk_spi), 			// 1-bit input: Destination clock.
	   .dest_out(w_packet_QSPI_CDC), 	// WIDTH-bit output: Input bus (src_in) synchronized to destination clock domain. This output is registered.
	   .dest_req(w_dest_req_QSPI), 		// 1-bit output: Assertion of this signal indicates that new dest_out data has been received and is ready to be used or
	                        			// captured by the destination logic. When DEST_EXT_HSK = 1, this signal will deassert once the source handshake
	                        			// acknowledges that the destination clock domain has received the transferred data. When DEST_EXT_HSK = 0, this signal
	                        			// asserts for one clock period when dest_out bus is valid. This output is registered.
	   .dest_ack(1'b0)					// 1-bit input: optional; required when DEST_EXT_HSK = 1
	);

	xpm_cdc_handshake #(
	   .DEST_EXT_HSK(0),   // DECIMAL; 0=internal handshake, 1=external handshake
	   .DEST_SYNC_FF(3),   // DECIMAL; range: 2-10
	   .INIT_SYNC_FF(0),   // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
	   .SIM_ASSERT_CHK(1), // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
	   .SRC_SYNC_FF(3),    // DECIMAL; range: 2-10
	   .WIDTH(32)          // DECIMAL; range: 1-1024
	)
	HANDSHAKE_QSPI_CPU (
	   .src_clk(i_clk_spi),
	   .src_in(w_data_QSPI_CDC),
	   .src_send(w_src_send_QSPI),
	   .src_rcv(w_src_rcv_QSPI),

	   .dest_clk(i_clk_cpu),
	   .dest_out(w_data_CPU_CDC),
	   .dest_req(w_dest_req_CPU),
	   .dest_ack(1'b0)
	);
	`endif


	xmem_fsm FSM (
		.i_clk        (i_clk_spi),
		.i_reset_n    (i_reset_n),
		.i_memRead    (w_packet_QSPI_CDC.read),
		.i_memWrite   (w_packet_QSPI_CDC.write),
		.i_compareHit (w_compareHit),
		.i_req_CtQ    (w_dest_req_QSPI),
		.i_recv_QtC   (w_src_rcv_QSPI),
		.o_spi_ctrl   (spi_ctrl),
		.o_compareByte(w_compareByte),
		.o_saveData   (w_saveData),
		.o_send_QtC   (w_src_send_QSPI)
	);


	xmem_spi QSPI (
		.i_clk        (i_clk_spi),
		.i_reset_n    (i_reset_n),
		.i_dataIn     (w_sendData),
		.i_compareByte(w_compareByte),
		.i_spi_en     (spi_ctrl.enable),
		.i_spi_rw     (spi_ctrl.readWrite),
		.o_dataOut    (w_recvData),
		.o_compareHit (w_compareHit),
		.io_QSPI      (io_QSPI)
	);

endmodule : xmem_top
