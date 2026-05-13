module sync_bus #( parameter int wide = 32 ) (
    i_clkA, i_clkB, i_reset_n,
    i_sigIn, o_sigOut
);

    // Inputs/Outputs
    input logic i_clkA, i_clkB;
    input logic i_reset_n;
    input logic [wide-1:0] i_sigIn;
    output logic [wide-1:0] o_sigOut;

    genvar i;
    generate
        for (i = 0; i < wide; i++) begin : gen_bits
            sig_sync u_sig_sync (
                .i_clkA   (i_clkA),
                .i_clkB   (i_clkB),
                .i_reset_n(i_reset_n),
                .i_sigIn  (i_sigIn[i]),
                .o_sigOut (o_sigOut[i])
            );
        end
    endgenerate

endmodule
