timeunit 1ns;
timeprecision 1ns;

module testBench();

    reg clk, vga_clk;
    reg reset_n;
    reg hit_reset;
    reg [13:0] vgaData;

    initial
     begin
        clk = 0;
        vga_clk = 0;
        reset_n = 0;
        hit_reset = 0;
     end

    always begin
        #250ns clk <= ~clk;
     end

     always begin
         #20ns vga_clk <= ~vga_clk;
     end

    always @(posedge clk)
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
         #9ms $dumpflush;
         $finish;
     end

    top top_instance
        (
            .clk        (clk),
            .vga_clk  (vga_clk),
            .reset_n_out    (reset_n),
            .vgaData    (vgaData)
        );


endmodule
