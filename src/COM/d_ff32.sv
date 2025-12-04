module d_ff32 (clk, reset_n, d, q);
    input logic clk;
    input logic reset_n;
    input logic [31:0] d;
    output logic [31:0] q;

    always_ff @(posedge clk or negedge reset_n) begin
        if(~reset_n) begin
            q <= 0;
        end else begin
            q <= d;
        end
    end

endmodule : d_ff32
