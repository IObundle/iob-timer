FPGA_OBJ?=$(FPGA_FAMILY)/timer.edif
CONSTRAINTS:=$(wildcard *.xdc)

include ../fpga.mk
run: $(FPGA_OBJ)

clean: clean_hw
	rm -rf $(FPGA_FAMILY) *.v *.vh

.PHONY: run clean
