TESTBENCH   := src/testBench.sv
TOP         := VtestBench

PROJ_DIR    := $(CURDIR)
SRC_DIR     := $(PROJ_DIR)/src
OUT_DIR     := $(PROJ_DIR)/output
OBJ_DIR     := $(PROJ_DIR)/obj_dir

SRC_DIRS    := $(wildcard $(SRC_DIR)/*/)
INC_FLAGS   := $(addprefix -I, $(SRC_DIRS))
DEF_FLAGS   := +define+SIMULATION
VER_FLAGS   := $(INC_FLAGS) -Isrc --binary --trace --Mdir $(OBJ_DIR) $(DEF_FLAGS)

PKG_SRCS    := $(wildcard $(SRC_DIR)/COM/*)
VERILOG_SRCS := $(PKG_SRCS) $(TESTBENCH)

.PHONY: all build sim view simview clean

all: build

build:
	mkdir -p $(OBJ_DIR)
	verilator $(VER_FLAGS) $(VERILOG_SRCS)
	@if [ ! -f $(OBJ_DIR)/$(TOP) ]; then echo "ERROR: Verilator compilation failed - $(TOP) not found"; exit 1; fi

sim: build
	mkdir -p $(OUT_DIR)
	cd $(OUT_DIR) && $(OBJ_DIR)/$(TOP)

view:
	cd $(OUT_DIR) && gtkwave dump.vcd

simview: build
	mkdir -p $(OUT_DIR)
	cd $(OUT_DIR) && $(OBJ_DIR)/$(TOP) && gtkwave dump.vcd

clean:
	rm -rf $(OBJ_DIR) $(OUT_DIR)/*.vcd