module mem_memory #(
    parameter INIT_FILENAME = "test_rv32i.mem"
) (
    i_clk, i_reset_n,
    i_memAddr, i_instrAddr, i_writeData, i_ctrlMEM,
    en_IF, en_MEM, en_WB,
    o_readData, o_instr
);
    // Params
    localparam MEMORY_SIZE = 8192;

    // I/O
    input logic i_clk;
    input logic i_reset_n;
    input logic [31:0] i_memAddr;
    input logic [31:0] i_instrAddr;
    input logic [31:0] i_writeData;
    input mem_ctrl_t i_ctrlMEM;

    input logic en_IF;
    input logic en_MEM;
    input logic en_WB; // for mem logging

    output logic [31:0] o_readData;
    output logic [31:0] o_instr;

    // Memory Array
    (* ram_style = "block" *)
    logic [31:0] mem_array [MEMORY_SIZE];
    initial begin : init_mem_from_hex
        integer i;
        
        // Optional: clear all memory first
        for (i = 0; i < MEMORY_SIZE; i++) begin
            mem_array[i] = 32'h00000000;
        end
        
        `ifdef SIMULATION
        string path = {"../scripts/", INIT_FILENAME};
        $display("Loading memory image: %s", path);
        $readmemh(path, mem_array);
        `else
        $display("Loading memory image: %s", INIT_FILENAME);
        $readmemh(INIT_FILENAME, mem_array);
        `endif

        

        // INIT_FILENAME should point to a Verilog-style hex/mem file
        // e.g. "test_rv32i.mem" generated via objcopy -O verilog

        $display("mem_array[0] = %08h", mem_array[0]);
    end


    // Instruction Fetch
    always_ff @(posedge i_clk) begin
        if (!i_reset_n) begin
            o_instr <= 32'b0;
        end else begin
            if(en_IF) begin
                o_instr <= mem_array[i_instrAddr[14:2]]; // Word-aligned access for instruction fetch
            end
        end
    end


    // Memory Read
    logic [31:0] w_tempRD;

    always_comb begin
        unique case (i_ctrlMEM.size)
            2'b00: begin
                unique case (i_memAddr[1:0]) // Byte-aligned access, LB/LBU
                    2'b00: begin
                        o_readData = {
                                (!i_ctrlMEM.sign)?{24{w_tempRD[7]}}:{24'b0},
                                w_tempRD[7:0]
                                };
                    end
                    2'b01: begin
                        o_readData = {
                                (!i_ctrlMEM.sign)?{24{w_tempRD[15]}}:{24'b0},
                                w_tempRD[15:8]
                                };
                    end
                    2'b10: begin
                        o_readData = {
                                (!i_ctrlMEM.sign)?{24{w_tempRD[23]}}:{24'b0},
                                w_tempRD[23:16]
                                };
                    end
                    2'b11: begin
                        o_readData = {
                                (!i_ctrlMEM.sign)?{24{w_tempRD[31]}}:{24'b0},
                                w_tempRD[31:24]
                                };
                    end
                endcase
            end
            2'b01: begin
                unique case (i_memAddr[1]) // Halfword-aligned access, LH/LHU
                    1'b0: begin
                        o_readData = {
                                (!i_ctrlMEM.sign)?{16{w_tempRD[15]}}:{16'b0},
                                w_tempRD[15:0]
                                };
                    end
                    1'b1: begin
                        o_readData = {
                                (!i_ctrlMEM.sign)?{16{w_tempRD[31]}}:{16'b0},
                                w_tempRD[31:16]
                                };
                    end
                endcase
            end
            2'b10: begin
                o_readData = w_tempRD; // Word-aligned access
            end
            default: begin
                o_readData = 32'b0;
            end
        endcase
    end

    // Memory Port Access
    always_ff @(posedge i_clk) begin
        if (!i_reset_n) begin
            w_tempRD <= 32'b0;
        end else if (en_MEM) begin
            // Write
            if (i_ctrlMEM.memWrite) begin
                unique case (i_ctrlMEM.size)
                    2'b00: begin
                        unique case (i_memAddr[1:0]) // Byte-aligned access
                            2'b00: mem_array[i_memAddr[14:2]][7:0] <= i_writeData[7:0];
                            2'b01: mem_array[i_memAddr[14:2]][15:8] <= i_writeData[7:0];
                            2'b10: mem_array[i_memAddr[14:2]][23:16] <= i_writeData[7:0];
                            2'b11: mem_array[i_memAddr[14:2]][31:24] <= i_writeData[7:0];
                        endcase
                    end
                    2'b01: begin
                        unique case (i_memAddr[1]) // Halfword-aligned access
                            1'b0: mem_array[i_memAddr[14:2]][15:0] <= i_writeData[15:0];
                            1'b1: mem_array[i_memAddr[14:2]][31:16] <= i_writeData[15:0];
                        endcase
                    end
                    2'b10: mem_array[i_memAddr[14:2]] <= i_writeData; // Word-aligned access
                    default: begin
                        //nothing
                    end
                endcase
            end
            // Read
            w_tempRD <= mem_array[i_memAddr[14:2]];
        end
    end

    `ifdef SIMULATION
    mem_memlog mm (
            .i_clk      (i_clk),
            .en_MEM     (en_MEM),
            .en_WB      (en_WB),
            .i_memAddr  (i_memAddr),
            .i_writeData(i_writeData),
            .i_ctrlMEM  (i_ctrlMEM),
            .i_readData (o_readData)
        );
    `endif


endmodule : mem_memory
