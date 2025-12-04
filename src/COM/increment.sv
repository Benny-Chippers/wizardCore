module increment (clk, reset_n, d, q);

    input logic clk;
    input logic reset_n;
    input logic [15:0] d;
    output logic [15:0] q;

    always_ff @(posedge clk or negedge reset_n) begin
        if(~reset_n) begin
            q <= 0;
        end else begin
            q <= d + 1;
        end
    end

endmodule : increment


