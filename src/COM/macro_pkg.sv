package macro_pkg;

/////////////////////
// Control Signals //
/////////////////////

typedef struct packed {
	logic [1:0] aluOp;
	logic [1:0] aluSrc;
	logic [2:0] func3;
	logic [6:0] func7;
} ex_ctrl_t;

typedef struct packed {
	logic [1:0] aluOp;
	logic [2:0] func3;
	logic [6:0] func7;
} alu_ctrl_t;

typedef struct packed {
	logic sign;			// Signed (0), Unsigned (1)
	logic [1:0] size;   // Byte (00), Half (01), Word (10)
	logic Jump;
	logic Branch;
	logic memRead;
	logic memWrite;
} mem_ctrl_t;

typedef struct packed {
	logic readWrite;
	logic [1:0]sendSelect;
	logic enable;
	logic select;
	logic dbl;
	logic cmdRdy;
} xmem_ctrl_t;

typedef struct packed {
	logic regWrite;
	logic memToReg;
	logic [4:0] writeReg;
} wb_ctrl_t;


/////////////////
// VGA Signals //
/////////////////

typedef struct packed {
	logic vSync;
	logic hSync;
	logic [3:0] red;
	logic [3:0] green;
	logic [3:0] blue;
} vga_out_t;

typedef struct packed {
	logic [3:0] red;
	logic [3:0] green;
	logic [3:0] blue;
} vga_color_t;


/////////////////
// SPI Signals //
/////////////////

typedef struct packed {
    logic read;
    logic write;
    logic [31:0] addr;
    logic [31:0] wdata;
} spi_req_t;

endpackage : macro_pkg
