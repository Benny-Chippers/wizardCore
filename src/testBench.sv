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
    
    reg MISO;
    reg D_RDY;
    
    assign spi[1] = MISO;
    assign spi[3] = D_RDY;

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
        #15us hit_reset = 0;
        // #50ns hit_reset = 0;
     end

    // Simulation clocking for Verilator
    `ifdef SIMULATION
    always begin
        #10ns clk <= ~clk;
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
          // #50us $dumpflush;
        #50ms $dumpflush;
         $finish;
     end
     
     initial begin 
        #0us
        MISO = 1;
        D_RDY = 1;
        #16.8us // CMD 1
        D_RDY = 0;
        #0.2us
        D_RDY = 1;
        #2.2us  // ADDR/DATA 1
        D_RDY = 0;
        #0.2us
        D_RDY = 1;
        #1us    // CMD 2
        D_RDY = 0;
        #0.2us
        D_RDY = 1;
        #2.2us  // ADDR 2
        D_RDY = 0;
        #0.2us
        D_RDY = 1;
     end

    top top_instance (
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

    logic i_pin, o_pin;


    debounce DB (
        .i_clk    (clk),
        .i_reset_n(reset_n),
        .i_pin    (i_pin),
        .o_pin    (o_pin)
    );



endmodule
