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
    // inout [31:0] gpio
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

     // initial begin

     // end

     reg [31:0] gpio;

    initial begin
        gpio = 32'h0000_0100;   /* bit 8 high for test_gpio_input_pin8() */
    end

    wire [31:0] gpio_bus;
    wire [31:0] gpio_dir = top_instance.SPECIAL.GPIO.r_direction;
    wire [31:0] gpio_out = top_instance.SPECIAL.GPIO.r_out_reg;

    genvar gi;
    generate
        for (gi = 0; gi < 32; gi = gi + 1) begin : g_gpio_pin_hookup
            assign gpio_bus[gi] = gpio_dir[gi] ? gpio_out[gi] : gpio[gi];
        end
    endgenerate

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
        .spi        (spi),
        .gpio       (gpio_bus)
    );



endmodule
