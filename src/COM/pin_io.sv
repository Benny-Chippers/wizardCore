module pin_io (
	i_clk, i_dir, i_dataSend,
	o_dataRecv,
	io_pin
);

	// I/O
	input logic i_clk;
	input logic i_dir;
	input logic i_dataSend;

	output logic o_dataRecv;

	inout wire io_pin;	// make sure to explicitly delcare everything this touches externally a wire.

	// Internal
	logic sendBuf;
	logic recvBuf;

	assign io_pin = i_dir ? sendBuf : 1'bz;
	assign o_dataRecv = recvBuf;

	always_ff @(posedge i_clk) begin
		recvBuf <= io_pin;
		sendBuf <= i_dataSend;
	end


endmodule : pin_io