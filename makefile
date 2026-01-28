

TESTBENCH 	= src/testBench.sv
TOP       	:= VtestBench

PROJ_DIR 	:= $(CURDIR)
SRC_DIR  	:= $(PROJ_DIR)/src
OUT_DIR  	:= $(PROJ_DIR)/output
SRC_DIRS 	:= $(wildcard $(SRC_DIR)/*/)
INC_FLAGS 	:= $(addprefix -I, $(SRC_DIRS))

VER_FLAGS 	:= $(INC_FLAGS) -Isrc --binary --trace $(SRC_DIR)/COM/macro.sv



.PHONY: all build sim view simview clean

all: build

build:
	verilator $(VER_FLAGS) $(TESTBENCH)

sim: build
	cd $(OUT_DIR) && ../obj_dir/$(TOP)

view:
	cd $(OUT_DIR) && gtkwave dump.vcd

simview: build
	cd $(OUT_DIR) && ../obj_dir/$(TOP) && gtkwave dump.vcd

clean:
	rm -rf obj_dir output/*.vcd