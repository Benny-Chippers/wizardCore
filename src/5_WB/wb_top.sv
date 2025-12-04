module wb_top (
    i_ctrlWB, i_readData, i_resultALU,
    o_wrData
);
    // I/O
    input logic i_ctrlWB;
    input logic [31:0] i_readData;
    input logic [31:0] i_resultALU;
    output logic [31:0] o_wrData;

    // Combinational Logic
    always_comb begin
        // Write Back Data Select
        if(i_ctrlWB == 0) begin
            o_wrData = i_resultALU;
        end else begin
            o_wrData = i_readData;
        end
    end

endmodule : wb_top
