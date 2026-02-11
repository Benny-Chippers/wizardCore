// Implemetation

// id_reglog mm (
//         .i_clk      (i_clk),
//         .i_reset_n  (i_reset_n),
//         .i_memAddr  (i_memAddr),
//         .i_writeData(i_writeData),
//         .i_ctrlMEM  (i_ctrlMEM),
//         .i_readData (o_readData)
//     );

module id_reglog #(
    parameter string LOG_FILENAME = "reg.log"
) (
    input   logic           i_clk,
    input   logic           i_reset_n,
    input   logic [4:0]     rdReg1,
    input   logic [4:0]     rdReg2,
    input   logic [31:0]    i_writeData,
    input   logic           i_wrSig,
    input   logic [4:0]     i_wrReg,
    input   logic [31:0]    i_wrData
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

