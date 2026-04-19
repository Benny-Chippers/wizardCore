`ifdef SIMULATION
timeunit 1ns;
timeprecision 1ns;
`else
`timescale 1ns/1ns;
`endif

module testBench(
    `ifdef SIMULATION
    output [13:0] vgaData
    `else
    input osc_clk,
    output macro_pkg::vga_out_t vgaData
    `endif
);
    reg osc_clk;
    reg clk;      // System/CPU Clock
    reg vga_clk;  // Clock for vga circuit

    reg hit_reset;
    reg reset_n;

    initial
     begin
        `ifdef SIMULATION
        clk = 0;
        vga_clk = 0;
        `endif
        osc_clk = 0;
        reset_n = 0;
        hit_reset = 1;
        #2us hit_reset = 0;
     end

    // Simulation clocking for Verilator
    `ifdef SIMULATION
    always begin
        #20ns clk <= ~clk;
     end
    
     always begin
         #20ns vga_clk <= ~vga_clk;
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
            .vgaData    (vgaData)
        );


endmodule
