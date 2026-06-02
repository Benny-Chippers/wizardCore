`ifdef SIMULATION
timeunit 1ns;
timeprecision 1ns;
`else
`timescale 1ns/1ns
`endif

module testBench;
    logic osc_clk;
    logic hit_reset;
    logic reset_n;

    `ifdef SIMULATION
    logic clk;      // System/CPU clock
    logic vga_clk;  // VGA clock
    logic spi_clk;  // SPI clock
    `endif

    macro_pkg::vga_out_t vgaData;

    wire [5:0] spi;
    wire [31:0] gpio_bus;

    logic MISO;
    logic D_RDY;
    logic [31:0] gpio_drive;
    logic [31:0] gpio_drive_en;

    assign spi[1] = MISO;
    assign spi[3] = D_RDY;

    initial begin
        `ifdef SIMULATION
        clk = 1'b0;
        vga_clk = 1'b0;
        spi_clk = 1'b0;
        `endif

        osc_clk = 1'b0;
        MISO = 1'b0;
        D_RDY = 1'b0;
        reset_n = 1'b0;
        hit_reset = 1'b1;

        // test_special_regs.mem expects external GPIO pin 8 to be driven high.
        gpio_drive = 32'h0000_0100;
        gpio_drive_en = 32'h0000_0100;

        #50ns hit_reset = 1'b0;
    end

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
        reset_n <= ~hit_reset;
    end

    initial begin
        $display("[%0t] Tracing to dump.vcd...\n", $time);
        $dumpfile("dump.vcd");
        $dumpvars();
        $display("[%0t] Model running...\n", $time);
        `ifdef SIMULATION
        $display("[%0t] Simulation mode enabled.\n", $time);
        `endif
    end

    initial begin
        #100us $dumpflush;
        $finish;
    end

    genvar gi;
    generate
        for (gi = 0; gi < 32; gi = gi + 1) begin : g_gpio_tb_drive
            assign gpio_bus[gi] =
                (gpio_drive_en[gi] && !top_instance.SPECIAL.GPIO.r_direction[gi]) ?
                gpio_drive[gi] : 1'bz;
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
