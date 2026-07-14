module pin_io (
	// Input
	input logic i_clk,
	input logic i_reset_n,
	input logic i_dir,
	input logic i_dataSend,

	// Output
	output logic o_dataRecv,

	// InOut
	inout wire io_pin	// make sure to explicitly delcare everything this touches externally a wire.
);

	// Internal
	logic sendBuf;
	logic recvBuf;

	assign io_pin = i_dir ? sendBuf : 1'bz;		// 1 is output(writing), 0 is input(reading)
	assign o_dataRecv = recvBuf;

	always_ff @(posedge i_clk) begin
		if (!i_reset_n) begin
			recvBuf <= 1'b0;
		end else begin
			recvBuf <= io_pin;
		end
		// sendBuf <= i_dataSend;
	end

	always_ff @(negedge i_clk) begin
		if (!i_reset_n) begin
			sendBuf <= 1'b0;
		end else begin
			sendBuf <= i_dataSend;
		end
	end


endmodule : pin_io
