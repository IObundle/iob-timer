#
# CORE DEFINITIONS FILE
#

CORE_NAME=TIMER
TOP_MODULE=iob_timer

DATA_W=32

#PATHS
TIMER_HW_DIR:=$(TIMER_DIR)/hardware
TIMER_INC_DIR:=$(TIMER_HW_DIR)/include
TIMER_SRC_DIR:=$(TIMER_HW_DIR)/src
TIMER_TB_DIR:=$(TIMER_HW_DIR)/testbench
TIMER_SW_DIR:=$(TIMER_DIR)/software
TIMER_DOC_DIR:=$(TIMER_DIR)/document
TIMER_SUBMODULES_DIR:=$(TIMER_DIR)/submodules

#submodules
TIMER_SUBMODULES:=INTERCON LIB
$(foreach p, $(TIMER_SUBMODULES), $(eval $p_DIR ?=$(TIMER_DIR)/submodules/$p))

REMOTE_ROOT_DIR ?= sandbox/iob-soc/submodules/TIMER

#
# SIMULATION
#
SIM_DIR ?=$(TIMER_HW_DIR)/simulation

#RULES
corename:
	@echo $(CORE_NAME)

.PHONY: corename
