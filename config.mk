TOP_MODULE=iob_timer

DATA_W=32

#PATHS
TIMER_HW_DIR:=$(TIMER_DIR)/hardware
TIMER_INC_DIR:=$(TIMER_HW_DIR)/include
TIMER_SRC_DIR:=$(TIMER_HW_DIR)/src
TIMER_SIM_DIR:=$(TIMER_HW_DIR)/simulation
TIMER_TB_DIR:=$(TIMER_SIM_DIR)/testbench
TIMER_SW_DIR:=$(TIMER_DIR)/software
SIM_DIR ?=$(TIMER_SIM_DIR)
SUBMODULES_DIR:=$(TIMER_DIR)/submodules

# SUBMODULE PATHS
SUBMODULES_DIR_LIST=$(shell ls $(SUBMODULES_DIR))
$(foreach d, $(SUBMODULES_DIR_LIST), $(eval $d_DIR ?=$(SUBMODULES_DIR)/$d))

# VERSION
VERSION ?=V0.1
iob_timer_version.txt:
	echo $(VERSION) > version.txt
