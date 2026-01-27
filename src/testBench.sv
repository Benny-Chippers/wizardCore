module testBench
    (
        output logic [31:0] mem_addr,
        output logic [31:0] mem_data
    );

    reg clk;
    reg reset_n;
    reg hit_reset;

    initial
     begin
        clk = 0;
        reset_n = 0;
        hit_reset = 0;
     end

    always
     begin
        #5 clk <= ~clk;
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
     end

    initial
     begin
         #36000 $dumpflush;
         $finish;
     end

    top top_instance
        (
            .clk        (clk),
            .reset_n    (reset_n),
            .mem_addr   (mem_addr),
            .mem_data   (mem_data)
        );


endmodule
