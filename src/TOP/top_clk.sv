module top_clk (
    i_clk, i_reset_n,
    o_clk_if, o_clk_id, o_clk_mem
);
    // I/O
    input logic i_clk;
    input logic i_reset_n;
    output logic o_clk_if;
    output logic o_clk_id;
    output logic o_clk_mem;

    // Internal Signals
    logic [15:0] w_clkData_out;
    logic [15:0] w_clkData_in;


    d_ff16 clkDivider_if (
        .clk      (i_clk),
        .reset_n  (i_reset_n),
        .d        (w_clkData_in),
        .q        (w_clkData_out)
    );


    // Clock Dividers
    always_comb begin
        if(w_clkData_out == 4) begin
            w_clkData_in = 16'b0;
        end else begin
            w_clkData_in = w_clkData_out + 1;
        end

        if(w_clkData_out < 1) begin
            o_clk_if = 1'b1;
        end else begin
            o_clk_if = 1'b0;
        end

        if(w_clkData_out < 2) begin
            o_clk_id = 1'b1;
        end else begin
            o_clk_id = 1'b0;
        end

        if(w_clkData_out < 3) begin
            o_clk_mem = 1'b1;
        end else begin
            o_clk_mem = 1'b0;
        end

    end




endmodule : top_clk
