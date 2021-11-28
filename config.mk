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
SUBMODULES=
SUBMODULE_DIRS=$(shell ls $(SUBMODULES_DIR))
$(foreach d, $(SUBMODULE_DIRS), $(eval TMP=$(shell make -C $(SUBMODULES_DIR)/$d corename | grep -v make)) $(eval SUBMODULES+=$(TMP)) $(eval $(TMP)_DIR ?=$(SUBMODULES_DIR)/$d))

# VERSION
VERSION ?=0.1
VLINE ?="V$(VERSION)"
TIMER_version.txt:
ifeq ($(VERSION),)
	$(error "variable VERSION is not set")
endif
	echo $(VLINE) > version.txt
