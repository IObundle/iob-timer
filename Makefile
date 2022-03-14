TIMER_DIR:=.
include config.mk

#
# SIMULATE
#

sim:
	make -C $(SIM_DIR) run

sim-clean:
	make -C $(SIM_DIR) clean

#
# TESTER
#
tester-sim:
	make -C $(TESTER_DIR) sim

tester-fpga-build:
	make -C $(TESTER_DIR) fpga-build

#
# CLEAN ALL
# 

clean: sim-clean
	make -C $(TESTER_DIR) clean

.PHONY: corename sim sim-clean tester-sim tester-fpga-build clean
