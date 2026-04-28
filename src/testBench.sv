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
        spi_clk = 0;    // For SPI Testing
        reset_n = 0;
        hit_reset = 1;
        #2us hit_reset = 0;
        // #50ns hit_reset = 0;
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
        #10ns osc_clk <= ~osc_clk;
     end
     always begin
        #25ns spi_clk <= ~spi_clk;
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
            .vga_clk    (vga_clk),
            .spi_clk    (spi_clk),
            `else
            .osc_clk    (osc_clk),
            `endif
            .reset_n    (reset_n),
            .vgaData    (vgaData),
            .spi        (spi)
        );

    logic [31:0] dataIn;
    logic [31:0] dataAddr;
    wire  [31:0] dataOut;
    tri   [3:0]  QSPI;

    macro_pkg::mem_ctrl_t spi_ctrl;
    logic en_SPI, spi_rw;
    wire spi_stall, o_clk_QSPI, o_select_QSPI;
    logic [3:0] qspi_drv;

    assign QSPI = ~spi_rw ? qspi_drv : 4'bz;
    assign spi[3:0] = QSPI;
    
    always @(posedge osc_clk) begin
        if(spi_stall == 1'b0) begin
            en_SPI <= 0;
        end
    end

    initial begin
        dataIn = 32'h3820_DEAD;
        dataAddr = 32'h2001_FF00;
        qspi_drv = 4'hf;
        spi_rw = 1;
        spi_ctrl = 7'b0;
        spi_ctrl.memWrite = 1;
        spi_ctrl.memRead = 0;
        spi_ctrl.size = 2'b10;
        en_SPI = 0;

        

        #160ns

        en_SPI = 1;

        #1600ns
        #400ns
        
        spi_rw = 0;
        qspi_drv = 4'h0;
        #50ns
        qspi_drv = 4'h6;
        #50ns
        qspi_drv = 4'hf;
        spi_rw = 1;
        
        #800ns

        #3us

        $finish;

    end


    xmem_top XMEM (
        .i_reset_n    (reset_n),
        `ifdef SIMULATION
        .i_clk_cpu    (clk),
        `else
        .i_clk_cpu    (osc_clk),
        `endif
        .i_clk_spi    (spi_clk),
        .i_address    (dataAddr),
        .i_dataWrite  (dataIn),
        .i_mem_ctrl   (spi_ctrl),
        .en_SPI       (en_SPI),
        .o_stall      (spi_stall),
        .o_dataRead   (dataOut),
        .o_clk_QSPI   (o_clk_QSPI),
        .o_select_QSPI(o_select_QSPI),
        .io_QSPI      (QSPI)
    );


endmodule
