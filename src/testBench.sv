`ifdef SIMULATION
timeunit 1ns;
timeprecision 1ns;
`else
`timescale 1ns/1ns;
`endif


module testBench(
    `ifdef SIMULATION
    output [13:0] vgaData,
    `else
    input osc_clk,
    output macro_pkg::vga_out_t vgaData,
    `endif
    inout [5:0] spi
);
    reg osc_clk;
    reg clk;      // System/CPU Clock
    reg vga_clk;  // Clock for vga circuit
    reg spi_clk;

    reg hit_reset;
    reg reset_n;

    initial
     begin
        `ifdef SIMULATION
        clk = 0;
        vga_clk = 0;
        spi_clk = 0;
        `endif
        osc_clk = 0;
        reset_n = 0;
        hit_reset = 1;
        // #2us hit_reset = 0;
        #50ns hit_reset = 0;
     end

    // Simulation clocking for Verilator
    `ifdef SIMULATION
    always begin
        #20ns clk <= ~clk;
     end

     always begin
         #20ns vga_clk <= ~vga_clk;
     end

     always begin
         #500ns spi_clk <= ~spi_clk;
     end
     `else
     always begin
        #5ns osc_clk <= ~osc_clk;
     end
    `endif


    `ifdef SIMULATION
    always @(posedge clk)
    `else
    always @(posedge osc_clk)
    `endif
    begin
        if(hit_reset === 1'b1) begin
            reset_n <= 0;
        end
        else begin
            reset_n <= 1;
        end
    end


    initial
     begin
         $display("[%0t] Tracing to dump.vcd...\n",$time);
         $dumpfile("dump.vcd");
         $dumpvars();
         $display("[%0t] Model running...\n",$time);
         `ifdef SIMULATION
         $display("[%0t] Simulation mode enabled.\n",$time);
         `endif
     end

    initial
     begin
         // #2500us $dumpflush;
         #600ms $dumpflush;
         $finish;
     end

    top top_instance
        (
            `ifdef SIMULATION
            .clk        (clk),
            .vga_clk  (vga_clk),
            `else
            .osc_clk    (osc_clk),
            `endif
            .reset_n    (reset_n),
            .vgaData    (vgaData),
            .spi        (spi)
        );

    logic [31:0] dataIn;
    wire  [31:0] dataOut;
    logic [7:0] o_compareByte;
    tri   [3:0]  QSPI;

    logic spi_en, spi_sel, spi_rw;
    wire o_compMatch;
    wire macro_pkg::xmem_ctrl_t o_spi_ctrl;
    logic [3:0] qspi_drv;

    assign QSPI = ~spi_rw ? qspi_drv : 4'bz;
    assign spi[3:0] = QSPI;

    initial begin
        dataIn = 32'b0;
        qspi_drv = 4'b0;
        spi_en = 0;
        spi_sel = 1;
        spi_rw = 0;

        #80ns;

        spi_en = 1;
        spi_sel = 0;
        qspi_drv = 4'h1;

        #40ns;
        qspi_drv = 4'h3;

        #40ns;
        qspi_drv = 4'h5;

        #40ns;
        qspi_drv = 4'h7;

        #40ns;
        qspi_drv = 4'h9;

        #40ns;
        qspi_drv = 4'hb;

        #40ns;
        qspi_drv = 4'hd;

        #40ns;
        qspi_drv = 4'hf;

        #80ns
        spi_en = 0;
        spi_sel = 1;

        #120ns

        spi_en = 1;
        spi_sel = 0;
        qspi_drv = 4'h6;

        #40ns;
        qspi_drv = 4'h7;

        #40ns;
        qspi_drv = 4'h8;

        #40ns;
        qspi_drv = 4'h0;

        #40ns;
        qspi_drv = 4'h0;

        #40ns;
        qspi_drv = 4'h8;

        #40ns;
        qspi_drv = 4'h5;

        #40ns;
        qspi_drv = 4'hf;

        #80ns;
        spi_en = 0;

        #80ns;
        spi_rw = 1;
        dataIn = 32'h69420789;

        #40ns
        spi_en = 1;
        #320ns
        spi_en = 0;


        #40ns;
        #40ns;

        $finish;

    end


    // xmem_spi SPI
    //     (
    //         .i_clk    (clk),
    //         .i_reset_n(reset_n),
    //         .i_dataIn (dataIn),
    //         .i_compByte (o_compareByte),
    //         .i_spi_en (spi_en),
    //         .i_spi_rw (spi_rw),
    //         .o_compMatch(o_compMatch),
    //         .o_dataOut(dataOut),
    //         .io_QSPI  (QSPI)
    //     );

    xmem_fsm FSM 
        (
            .i_clk        (clk),
            .i_reset_n    (reset_n),
            .i_ctrlMEM    (7'b0),
            .o_spi_ctrl   (o_spi_ctrl),
            .i_compareHit (o_compMatch),
            .o_compareByte(o_compareByte),
            .i_memRead    (i_memRead),
            .i_memWrite   (i_memWrite),
            .i_req_CtQ    (i_req_CtQ),
            .i_recv_QtC   (i_recv_QtC),
            .o_saveData   (o_saveData),
            .o_send_QtC   (o_send_QtC)
        );


endmodule
