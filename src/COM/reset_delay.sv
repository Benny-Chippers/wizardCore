module reset_delay #(
    parameter int DELAY_CYCLES = 16
) (
    input  logic i_clk,
    input  logic i_locked,
    output logic o_reset_n
);

    logic [1:0] r_lock_sync;
    logic [$clog2(DELAY_CYCLES+1)-1:0] r_count;

    always_ff @(posedge i_clk or negedge i_locked) begin
        if (!i_locked) begin
            r_lock_sync <= 2'b00;
            r_count     <= '0;
            o_reset_n   <= 1'b0;
        end else begin
            r_lock_sync <= {r_lock_sync[0], 1'b1};

            if (!r_lock_sync[1]) begin
                r_count   <= '0;
                o_reset_n <= 1'b0;
            end else if (r_count < DELAY_CYCLES[$bits(r_count)-1:0]) begin
                r_count   <= r_count + 1'b1;
                o_reset_n <= 1'b0;
            end else begin
                o_reset_n <= 1'b1;
            end
        end
    end

endmodule

