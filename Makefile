TIMER_DIR:=.
include config.mk

corename:
	@echo "TIMER"

#
# SIMULATE
#

sim:
	make -C $(SIM_DIR) run

sim-clean:
	make -C $(SIM_DIR) clean

#
# CLEAN ALL
# 

clean: sim-clean

.PHONY: corename sim sim-clean clean
