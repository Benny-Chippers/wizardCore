module id_reg (
    i_clk, i_reset_n, i_rdReg1, i_rdReg2, i_wrSig, i_wrReg, i_wrData,
    en_WB,
    o_rdData1, o_rdData2
);

    // I/O
    input logic i_clk;
    input logic i_reset_n;
    input logic [4:0] i_rdReg1;
    input logic [4:0] i_rdReg2;
    input logic i_wrSig;
    input logic [4:0] i_wrReg;
    input logic [31:0] i_wrData;

    input logic en_WB;

    output logic [31:0] o_rdData1;
    output logic [31:0] o_rdData2;

    // 32 registers of 32 bits each
    logic [31:0] regs [32];

    // ---------------------------------------------------------
    // WRITE: synchronous
    // ---------------------------------------------------------
    always_ff @(posedge i_clk) begin
        if (!i_reset_n) begin
            // reset all registers to 0
            for (int i = 0; i < 32; i++)
                regs[i] <= 32'd0;
        end else begin
            if(en_WB) begin
                // write-enable + avoid writing x0
                if (i_wrSig && (i_wrReg != 5'd0))
                    regs[i_wrReg] <= i_wrData;
            end
        end
    end

    // ---------------------------------------------------------
    // READ: asynchronous (combinational)
    // ---------------------------------------------------------
    always_comb begin
        // read register 0 always returns 0 even if array content changes
        o_rdData1 = (i_rdReg1 == 5'd0) ? 32'd0 : regs[i_rdReg1];
        o_rdData2 = (i_rdReg2 == 5'd0) ? 32'd0 : regs[i_rdReg2];
    end

endmodule : id_reg
