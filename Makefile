TIMER_DIR:=.
include core.mk

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

.PHONY: sim sim-clean clean

