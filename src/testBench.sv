//timeunit 1ns;
//timeprecision 1ns;
`timescale 1ns/1ns;

module testBench(
    `ifdef SIMULATION
    input clk,      // System/CPU Clock
    input vga_clk,  // Clock for vga circuit
    `else
    input osc_clk,
    `endif
    output vga_out_t vgaData
);

    reg hit_reset;
    reg reset_n;

    initial
     begin
        `ifdef SIMULATION
        clk = 0;
        vga_clk = 0;
        `endif
        reset_n = 0;
        hit_reset = 0;
     end

    always begin
        `ifdef SIMULATION
        #20ns clk <= ~clk;
        `endif
     end

     always begin
        `ifdef SIMULATION
         #20ns vga_clk <= ~vga_clk;
        `endif
     end

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
         #900ms $dumpflush;
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
            .reset_n_out    (reset_n),
            .vgaData    (vgaData)
        );


endmodule
