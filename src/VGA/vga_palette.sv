module vga_palette (
	// Inputs
    input logic i_clk,
    input logic i_vga_clk,
    input logic [31:0] i_palAddr,
    input logic [31:0] i_palData,
    input macro_pkg::mem_ctrl_t i_ctrlVGA,
    input logic [7:0] i_palIdx,
    input logic i_validRD,

    // Enables
    input logic en_MEM,

    // Output
	output macro_pkg::vga_color_t o_color
);


	// ==========================================================
    // Framebuffer Parameters
    // ==========================================================
    localparam COLORS  = 256;
    localparam WORDS = COLORS * 3 / 4;

    localparam PALETTE_BASE = 32'h1000_8000;

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

    logic [31:0] w_palAddrRel;
    logic [7:0] w_WrWord;
    logic [1:0] w_WrByte;
    logic w_validWR;

    //bounds checking
    always_comb begin
    	w_palAddrRel = i_palAddr - PALETTE_BASE;
        w_validWR = (w_palAddrRel < 768);

        w_WrWord = w_palAddrRel[9:2];
        w_WrByte = w_palAddrRel[1:0];
    end

    always_ff @(posedge i_clk) begin
        if (i_ctrlVGA.memWrite & w_validWR & en_MEM) begin
           unique case (i_ctrlVGA.size)
               2'b00: begin
                    if(w_WrByte == 0) m_BRAM[w_WrWord][7:0] <= i_palData[7:0];
                    if(w_WrByte == 1) m_BRAM[w_WrWord][15:8] <= i_palData[7:0];
                    if(w_WrByte == 2) m_BRAM[w_WrWord][23:16] <= i_palData[7:0];
                    if(w_WrByte == 3) m_BRAM[w_WrWord][31:24] <= i_palData[7:0];
               end
               2'b01: begin
                    if(w_WrByte[1] == 0) m_BRAM[w_WrWord][15:0] <= i_palData[15:0];
                    if(w_WrByte[1] == 1) m_BRAM[w_WrWord][31:16] <= i_palData[15:0];
               end
               2'b10: begin
                    m_BRAM[w_WrWord] <= i_palData;
               end
               default: begin
                   //nothing
               end
           endcase
       end
    end


    // Color Read
    logic [31:0] w_tempRD_R;
    logic [31:0] w_tempRD_G;
    logic [31:0] w_tempRD_B;
    logic [1:0] w_RdPxlBuf;

    always_ff @(posedge i_vga_clk) begin
        if (i_validRD) begin
            w_tempRD_R <= m_BRAM[{2'h0,i_palIdx[7:2]}];
            w_tempRD_G <= m_BRAM[{2'h1,i_palIdx[7:2]}];
            w_tempRD_B <= m_BRAM[{2'h2,i_palIdx[7:2]}];
            w_RdPxlBuf <= i_palIdx[1:0];
        end else begin
            w_tempRD_R <= 0;
			w_tempRD_G <= 0;
			w_tempRD_B <= 0;
            w_RdPxlBuf <= 0 ;
        end
    end

    always_comb begin
        case (w_RdPxlBuf)
            0: o_color = {w_tempRD_R[3:0], w_tempRD_G[3:0], w_tempRD_B[3:0]};
            1: o_color = {w_tempRD_R[11:8], w_tempRD_G[11:8], w_tempRD_B[11:8]};
            2: o_color = {w_tempRD_R[19:16], w_tempRD_G[19:16], w_tempRD_B[19:16]};
            3: o_color = {w_tempRD_R[27:24], w_tempRD_G[27:24], w_tempRD_B[27:24]};
            default : o_color = 0;
        endcase
    end

endmodule : vga_palette
