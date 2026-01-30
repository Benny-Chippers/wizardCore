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
    input mem_ctrl_t i_ctrlMEM;
    output logic [31:0] o_readData;
    output logic [31:0] mem_addr;
    output logic [31:0] mem_data;

    // Memory Array
    logic [31:0] mem_array [2048];


    // Memory Read
    always_ff @(negedge i_clk or negedge i_reset_n) begin
        if (!i_reset_n) begin
            o_readData <= 32'b0;
        end else if (i_ctrlMEM.memRead) begin
            unique case (i_ctrlMEM.size)
                2'b00: begin
                    unique case (i_memAddr[1:0]) // Byte-aligned access, LB/LBU
                        2'b00: begin
                            o_readData <= {
                                    (!i_ctrlMEM.sign)?{24{mem_array[i_memAddr[12:2]][7]}}:{24'b0},
                                    mem_array[i_memAddr[12:2]][7:0]
                                    };
                        end
                        2'b01: begin
                            o_readData <= {
                                    (!i_ctrlMEM.sign)?{24{mem_array[i_memAddr[12:2]][15]}}:{24'b0},
                                    mem_array[i_memAddr[12:2]][15:8]
                                    };
                        end
                        2'b10: begin
                            o_readData <= {
                                    (!i_ctrlMEM.sign)?{24{mem_array[i_memAddr[12:2]][23]}}:{24'b0},
                                    mem_array[i_memAddr[12:2]][23:16]
                                    };
                        end
                        2'b11: begin
                            o_readData <= {
                                    (!i_ctrlMEM.sign)?{24{mem_array[i_memAddr[12:2]][31]}}:{24'b0},
                                    mem_array[i_memAddr[12:2]][31:24]
                                    };
                        end
                    endcase
                end
                2'b01: begin
                    unique case (i_memAddr[1]) // Halfword-aligned access, LH/LHU
                        1'b0: begin
                            o_readData <= {
                                    (!i_ctrlMEM.sign)?{16{mem_array[i_memAddr[12:2]][15]}}:{16'b0},
                                    mem_array[i_memAddr[12:2]][15:0]
                                    };
                        end
                        1'b1: begin
                            o_readData <= {
                                    (!i_ctrlMEM.sign)?{16{mem_array[i_memAddr[12:2]][31]}}:{16'b0},
                                    mem_array[i_memAddr[12:2]][31:16]
                                    };
                        end
                    endcase
                end
                2'b10: begin
                    o_readData <= mem_array[i_memAddr[12:2]]; // Word-aligned access
                end
                default: begin
                    o_readData <= 32'b0;
                end
            endcase
        end
    end

    // Memory Write
    always_ff @(posedge i_clk or negedge i_reset_n) begin
        if (!i_reset_n) begin
            for (int i = 0; i < 2048; i++) begin
                mem_array[i] <= 32'b0;
            end
        end else if (i_ctrlMEM.memWrite) begin
            unique case (i_ctrlMEM.size)
                2'b00: begin
                    unique case (i_memAddr[1:0]) // Byte-aligned access
                        2'b00: begin
                            mem_array[i_memAddr[12:2]][7:0] <= i_writeData[7:0];
                        end
                        2'b01: begin
                            mem_array[i_memAddr[12:2]][15:8] <= i_writeData[7:0];
                        end
                        2'b10: begin
                            mem_array[i_memAddr[12:2]][23:16] <= i_writeData[7:0];
                        end
                        2'b11: begin
                            mem_array[i_memAddr[12:2]][31:24] <= i_writeData[7:0];
                        end
                    endcase
                end
                2'b01: begin
                    unique case (i_memAddr[1]) // Halfword-aligned access
                        1'b0: begin
                            mem_array[i_memAddr[12:2]][15:0] <= i_writeData[15:0];
                        end
                        1'b1: begin
                            mem_array[i_memAddr[12:2]][31:16] <= i_writeData[15:0];
                        end
                    endcase
                end
                2'b10: begin
                    mem_array[i_memAddr[12:2]] <= i_writeData; // Word-aligned access
                end
                default: begin
                    //nothing
                end
            endcase
        end
    end

    // Memory spying outputs (not needed??)
    assign mem_addr = i_memAddr;
    always_comb begin
        if (i_ctrlMEM.memWrite) begin
            mem_data = i_writeData;
        end else if (i_ctrlMEM.memRead) begin
            mem_data = o_readData;
        end else begin
            mem_data = 32'b0;
        end
    end

    `ifdef SIMULATION
    mem_memlog mm (
            .i_clk      (i_clk),
            .i_reset_n  (i_reset_n),
            .i_memAddr  (i_memAddr),
            .i_writeData(i_writeData),
            .i_ctrlMEM  (i_ctrlMEM),
            .i_readData (o_readData)
        );
    `endif



endmodule : mem_memory
