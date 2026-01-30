

TESTBENCH 	= src/testBench.sv
TOP       	:= VtestBench

PROJ_DIR 	:= $(CURDIR)
SRC_DIR  	:= $(PROJ_DIR)/src
OUT_DIR  	:= $(PROJ_DIR)/output
SRC_DIRS 	:= $(wildcard $(SRC_DIR)/*/)
INC_FLAGS 	:= $(addprefix -I, $(SRC_DIRS))
DEF_FLAGS 	:= +define+SIMULATION

VER_FLAGS 	:= $(INC_FLAGS) -Isrc --binary --trace  $(DEF_FLAGS)



.PHONY: all build sim view simview clean

all: build

build:
	verilator $(VER_FLAGS) $(TESTBENCH) $(SRC_DIR)/COM/macro.sv

sim: build
	cd $(OUT_DIR) && ../obj_dir/$(TOP)

view:
	cd $(OUT_DIR) && gtkwave dump.vcd

simview: build
	cd $(OUT_DIR) && ../obj_dir/$(TOP) && gtkwave dump.vcd

clean:
	rm -rf obj_dir output/*.vcd