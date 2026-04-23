module vga_color (
    // Inputs
    input logic i_clk,
    input logic i_vga_clk,
    input logic [31:0] i_pxlAddr,
    input logic [31:0] i_pxlData,
    input macro_pkg::mem_ctrl_t i_ctrlVGA,
    input logic [7:0] i_pxlX,
    input logic [7:0] i_pxlY,

    // Enables
    input logic en_MEM,

    // Output
    output logic [3:0] o_value
);

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

    // Wiping for start
    initial begin
        integer i;
        for (i = 0; i < WORDS; i++) begin
            m_BRAM[i] = 32'h00000000;
        end
    end

    // Write word index matches SW layout: row y at stride 256 B => y*20 + (xb/4) words/row.
    // Read nibble-linear index must use same row pitch: 160 nibbles/row = y*160 + pixel_x.
    logic [11:0] w_WrPxl;
    logic [1:0] w_WrByte;
    logic [15:0] w_RdPxl;
    logic w_validRD, w_validWR;

    //bounds checking
    always_comb begin
        w_validWR = (i_pxlAddr[14:8] < 120) & (i_pxlAddr[7:0] < 80);
        w_validRD = (i_pxlY < 120) & (i_pxlX < 160);
    end

    always_comb begin
        w_WrPxl = {i_pxlAddr[14:8],4'b0} + {2'b0,i_pxlAddr[14:8],2'b0} + {6'b0,i_pxlAddr[7:2]};
        w_WrByte = i_pxlAddr[1:0];
        // y*160 + x = y*128 + y*32 + x
        w_RdPxl = {i_pxlY, 7'b0} + {2'b0, i_pxlY, 5'b0} + {8'b0, i_pxlX[7:0]};
    end

    always_ff @(posedge i_clk) begin
        if (i_ctrlVGA.memWrite & w_validWR & en_MEM) begin
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
    logic [2:0] w_RdPxlBuf;

    always_ff @(posedge i_vga_clk) begin
        if (w_validRD) begin
            w_tempRD <= m_BRAM[w_RdPxl[14:3]];
            w_RdPxlBuf <= w_RdPxl[2:0];
        end else begin
            w_tempRD <= 0;
            w_RdPxlBuf <= 0 ;
        end
    end

    always_comb begin
        case (w_RdPxlBuf)
            0: o_value = w_tempRD[3:0];
            1: o_value = w_tempRD[7:4];
            2: o_value = w_tempRD[11:8];
            3: o_value = w_tempRD[15:12];
            4: o_value = w_tempRD[19:16];
            5: o_value = w_tempRD[23:20];
            6: o_value = w_tempRD[27:24];
            7: o_value = w_tempRD[31:28];
            default : o_value = 0;
        endcase
    end


endmodule
