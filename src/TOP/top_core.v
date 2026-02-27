// Verilog Module for Core for Vivado Usage
module top_core (
    input clk,      // Clock
    input vga_clk,  // Clock for vga circuit
    input reset,  // Asynchronous reset active low
    output [13:0] vgaData
);

    wire [13:0] vgaData_int;

    top CORE (
        .clk(clk),
        .vga_clk(vga_clk),
        .reset_n(!reset),
        .vgaData(vgaData_int)
    );
    
    assign vgaData = vgaData_int;


endmodule : top_core
