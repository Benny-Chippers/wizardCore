// mem_memlog.sv
// Simple, non-synthesizable memory transaction logger.
//
// Instantiate this module alongside your mem block and wire it to:
// - clk/reset
// - memAddr/writeData/ctrlMEM
// - readData (the mem block's o_readData)
//
// It writes human-readable lines to a log file (default: mem.log).

// Implemetation

// mem_memlog # (
//          .LOG_FILENAME("mem.log")
//          ) mm (
//         .i_clk      (i_clk),
//         .i_reset_n  (i_reset_n),
//         .i_memAddr  (i_memAddr),
//         .i_writeData(i_writeData),
//         .i_ctrlMEM  (i_ctrlMEM),
//         .i_readData (o_readData)
//     );

module mem_memlog #(
    parameter string LOG_FILENAME = "mem.log"
) (
    input  logic        i_clk,
    input  logic        i_reset_n,
    input  logic [31:0] i_memAddr,
    input  logic [31:0] i_writeData,
    input  mem_ctrl_t  i_ctrlMEM,   // [1]=read, [0]=write
    input  logic [31:0] i_readData
);
    integer fd;

    initial begin
        fd = $fopen(LOG_FILENAME, "w");
        if (fd == 0) begin
            $fatal(1, "mem_memlog: failed to open log file '%s'", LOG_FILENAME);
        end
        $fdisplay(fd, "time,op,addr_hex,word_index,data_hex");
        $fflush(fd);
    end

    final begin
        if (fd != 0) begin
            $fflush(fd);
            $fclose(fd);
        end
    end

    // Log writes
    always @(posedge i_clk) begin
        if (i_reset_n && i_ctrlMEM[0]) begin
            $fdisplay(fd, "%0t,WRITE,0x%08h,%0d,0x%08h",
                      $time, i_memAddr, i_memAddr[12:2], i_writeData);
            $fflush(fd);
        end
    end

    // Log reads
    always @(posedge i_clk) begin
        if (i_reset_n && i_ctrlMEM[1]) begin
            $fdisplay(fd, "%0t,READ,0x%08h,%0d,0x%08h",
                      $time, i_memAddr, i_memAddr[12:2], i_readData);
            $fflush(fd);
        end
    end
endmodule

