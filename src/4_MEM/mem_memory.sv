module mem_memory (
    i_clk, i_reset_n,
    i_memAddr, i_writeData, i_ctrlMEM,
    o_readData,
    mem_addr, mem_data
);
    // I/O
    input logic i_clk;
    input logic i_reset_n;
    input logic [31:0] i_memAddr;
    input logic [31:0] i_writeData;
    input logic [1:0] i_ctrlMEM;      // Mem-Read, Mem-Write
    output logic [31:0] o_readData;
    output logic [31:0] mem_addr;
    output logic [31:0] mem_data;

    // Memory Array
    logic [31:0] mem_array [256];



    // Memory Read
    always_ff @(negedge i_clk or negedge i_reset_n) begin
        if (!i_reset_n) begin
            o_readData <= 32'b0;
        end else if (i_ctrlMEM[1]) begin
            o_readData <= mem_array[i_memAddr[9:2]]; // Word-aligned access
        end
    end

    // Memory Write
    always_ff @(posedge i_clk or negedge i_reset_n) begin
        if (!i_reset_n) begin
            for (int i = 0; i < 256; i++) begin
                mem_array[i] <= 32'b0;
            end
        end else if (i_ctrlMEM[0]) begin
            mem_array[i_memAddr[9:2]] <= i_writeData; // Word-aligned access
        end
    end

    // Memory spying outputs
    assign mem_addr = i_memAddr;
    always_comb begin
        if (i_ctrlMEM[0]) begin
            mem_data = i_writeData;
        end else if (i_ctrlMEM[1]) begin
            mem_data = o_readData;
        end else begin
            mem_data = 32'b0;
        end
    end



endmodule : mem_memory
