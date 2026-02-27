module mem_memory #(
    parameter string INIT_FILENAME = "test_rv32i.bin"
) (
    i_clk, i_reset_n,
    i_memAddr, i_instrAddr, i_writeData, i_ctrlMEM,
    o_readData, o_instr
);
    // I/O
    input logic i_clk;
    input logic i_reset_n;
    input logic [31:0] i_memAddr;
    input logic [31:0] i_instrAddr;
    input logic [31:0] i_writeData;
    input mem_ctrl_t i_ctrlMEM;
    output logic [31:0] o_readData;
    output logic [31:0] o_instr;

    // Memory Array
    (* ram_style = "block" *)
    logic [31:0] mem_array [8192];
    `ifdef SIMULATION
    initial begin
        int fd;
        string path = {"../scripts/", INIT_FILENAME};
        $display("Loading rom.");
        fd = $fopen(path, "rb");
        if(fd == 0) begin
            $display("Failed to open test.bin");
            $finish;
        end
        $display("Opened %s", INIT_FILENAME);

        $fread(mem_array, fd);
        $fclose(fd);

        // Swap bytes because $fread loads Little Endian file
        // into Big Endian word positions
        foreach (mem_array[i]) begin
            mem_array[i] = {<<8{mem_array[i]}};
        end

        $display("%h",mem_array[0]);
    end
    `endif


    // Instruction Fetch
    always_ff @(posedge i_clk) begin
        if (!i_reset_n) begin
            o_instr <= 32'b0;
        end else begin
            o_instr <= mem_array[i_instrAddr[14:2]]; // Word-aligned access for instruction fetch
        end
    end


    // Memory Read
    always_ff @(posedge i_clk) begin
        if (!i_reset_n) begin
            o_readData <= 32'b0;
        end else if (i_ctrlMEM.memRead) begin
            unique case (i_ctrlMEM.size)
                2'b00: begin
                    unique case (i_memAddr[1:0]) // Byte-aligned access, LB/LBU
                        2'b00: begin
                            o_readData <= {
                                    (!i_ctrlMEM.sign)?{24{mem_array[i_memAddr[14:2]][7]}}:{24'b0},
                                    mem_array[i_memAddr[14:2]][7:0]
                                    };
                        end
                        2'b01: begin
                            o_readData <= {
                                    (!i_ctrlMEM.sign)?{24{mem_array[i_memAddr[14:2]][15]}}:{24'b0},
                                    mem_array[i_memAddr[14:2]][15:8]
                                    };
                        end
                        2'b10: begin
                            o_readData <= {
                                    (!i_ctrlMEM.sign)?{24{mem_array[i_memAddr[14:2]][23]}}:{24'b0},
                                    mem_array[i_memAddr[14:2]][23:16]
                                    };
                        end
                        2'b11: begin
                            o_readData <= {
                                    (!i_ctrlMEM.sign)?{24{mem_array[i_memAddr[14:2]][31]}}:{24'b0},
                                    mem_array[i_memAddr[14:2]][31:24]
                                    };
                        end
                    endcase
                end
                2'b01: begin
                    unique case (i_memAddr[1]) // Halfword-aligned access, LH/LHU
                        1'b0: begin
                            o_readData <= {
                                    (!i_ctrlMEM.sign)?{16{mem_array[i_memAddr[14:2]][15]}}:{16'b0},
                                    mem_array[i_memAddr[14:2]][15:0]
                                    };
                        end
                        1'b1: begin
                            o_readData <= {
                                    (!i_ctrlMEM.sign)?{16{mem_array[i_memAddr[14:2]][31]}}:{16'b0},
                                    mem_array[i_memAddr[14:2]][31:16]
                                    };
                        end
                    endcase
                end
                2'b10: begin
                    o_readData <= mem_array[i_memAddr[14:2]]; // Word-aligned access
                end
                default: begin
                    o_readData <= 32'b0;
                end
            endcase
        end
    end

    // Memory Write
    always_ff @(posedge i_clk) begin
        if (!i_reset_n) begin
            // Nothing
        end else if (i_ctrlMEM.memWrite) begin
            unique case (i_ctrlMEM.size)
                2'b00: begin
                    unique case (i_memAddr[1:0]) // Byte-aligned access
                        2'b00: begin
                            mem_array[i_memAddr[14:2]][7:0] <= i_writeData[7:0];
                        end
                        2'b01: begin
                            mem_array[i_memAddr[14:2]][15:8] <= i_writeData[7:0];
                        end
                        2'b10: begin
                            mem_array[i_memAddr[14:2]][23:16] <= i_writeData[7:0];
                        end
                        2'b11: begin
                            mem_array[i_memAddr[14:2]][31:24] <= i_writeData[7:0];
                        end
                    endcase
                end
                2'b01: begin
                    unique case (i_memAddr[1]) // Halfword-aligned access
                        1'b0: begin
                            mem_array[i_memAddr[14:2]][15:0] <= i_writeData[15:0];
                        end
                        1'b1: begin
                            mem_array[i_memAddr[14:2]][31:16] <= i_writeData[15:0];
                        end
                    endcase
                end
                2'b10: begin
                    mem_array[i_memAddr[14:2]] <= i_writeData; // Word-aligned access
                end
                default: begin
                    //nothing
                end
            endcase
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
