module xmem_top (
	// Input
	input logic i_clk,    // Clock
	input logic i_reset_n,  // Asynchronous reset active low
	input [31:0] i_address,
	input [31:0] i_dataWrite,
	input macro_pkg::mem_ctrl_t i_mem_ctrl,

	// Enable
	input logic en_SPI,

	// Output
	output logic o_stall,
	output [31:0] o_dataRead
);

	// Internal Signals
	macro_pkg::spi_req_t w_packet_CPU_CDC;
	macro_pkg::spi_req_t w_packet_QSPI_CDC;

	always_comb begin
		if (en_SPI == 0) begin
			o_stall = 0;
			w_packet_CPU_CDC = 0;
		end else begin
			// stall = (mem.write | mem.read) & ~done (~dest_req)
			//
			// src_send_CPU
			// goes high when stall 0 -> 1 (stall & ~stall_delay)
			// resets when src_rcv_CPU asserted
			//
			// QSPI signals get piped to FSM and handled there
		end
	end


endmodule : xmem_top
