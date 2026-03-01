module vga_color (
    i_clk, i_vga_clk,
    i_pxlAddr, i_pxlData, i_ctrlVGA,
    i_pxlX, i_pxlY,
    o_value
);

    // Inputs
    input logic i_clk;
    input logic i_vga_clk;
    input logic [31:0] i_pxlAddr;
    input logic [31:0] i_pxlData;
    input mem_ctrl_t i_ctrlVGA;
    input logic [7:0] i_pxlX;
    input logic [7:0] i_pxlY;

    // Output
    output logic [3:0] o_value;

    // ==========================================================
    // Framebuffer Parameters
    // ==========================================================
    localparam WIDTH  = 160;
    localparam HEIGHT = 120;
    localparam PIXELS = WIDTH * HEIGHT;
    localparam WORDS = PIXELS / 8;

    // 32-bit True Dual-Port m_BRAM
    (* ram_style = "block" *)
    logic [31:0] m_BRAM [WORDS];

    // pixel index = y * 80 + x (since each x is two 4-bits for 160px wide)
    logic [11:0] w_WrPxl;
    logic [1:0] w_WrByte;
    logic [13:0] w_RdPxl;
    logic w_validRD, w_validWR;

    //bounds checking
    always_comb begin
        w_validWR = (i_pxlAddr[14:8] < 120) & (i_pxlAddr[6:0] < 80);
        w_validRD = (i_pxlY < 120) & (i_pxlX < 160);
    end

    always_comb begin
        w_WrPxl = {i_pxlAddr[14:8],4'b0} + {2'b0,i_pxlAddr[14:8],2'b0} + {6'b0,i_pxlAddr[6:2]};
        w_WrByte = i_pxlAddr[1:0];
        w_RdPxl = {i_pxlY,6'b0} + {2'b0,i_pxlY,4'b0} + {6'b0,i_pxlX[7:0]};
        // w_RdPxl = (i_pxlY << 6) + (i_pxlY << 4) + i_pxlX;
    end

    always_ff @(posedge i_clk) begin
        if (i_ctrlVGA.memWrite & w_validWR) begin
           unique case (i_ctrlVGA.size)
               2'b00: begin
                    if(w_WrByte == 0) m_BRAM[w_WrPxl][7:0] <= i_pxlData[7:0];
                    if(w_WrByte == 1) m_BRAM[w_WrPxl][15:8] <= i_pxlData[7:0];
                    if(w_WrByte == 2) m_BRAM[w_WrPxl][23:16] <= i_pxlData[7:0];
                    if(w_WrByte == 3) m_BRAM[w_WrPxl][31:24] <= i_pxlData[7:0];
               end
               2'b01: begin
                    if(w_WrByte[1] == 0) m_BRAM[w_WrPxl][15:0] <= i_pxlData[15:0];
                    if(w_WrByte[1] == 1) m_BRAM[w_WrPxl][31:16] <= i_pxlData[15:0];
               end
               2'b10: begin
                    m_BRAM[w_WrPxl] <= i_pxlData;
               end
               default: begin
                   //nothing
               end
           endcase
       end
    end


    // Color Read
    logic [31:0] w_tempRD;

    always_ff @(posedge i_vga_clk) begin
        if (w_validRD) begin
            w_tempRD <= m_BRAM[{1'b0,w_RdPxl[13:3]}];
            case (w_RdPxl[2:0])
                0: o_value <= w_tempRD[3:0];
                1: o_value <= w_tempRD[7:4];
                2: o_value <= w_tempRD[11:8];
                3: o_value <= w_tempRD[15:12];
                4: o_value <= w_tempRD[19:16];
                5: o_value <= w_tempRD[23:20];
                6: o_value <= w_tempRD[27:24];
                7: o_value <= w_tempRD[31:28];
                default : o_value <= 0;
            endcase
        end else begin
            o_value <= 0;
        end
    end


endmodule
