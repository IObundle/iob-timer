#
# CORE DEFINITIONS FILE
#

CORE_NAME=TIMER
TOP_MODULE=iob_timer

DATA_W=32

#PATHS
TIMER_HW_DIR:=$(TIMER_DIR)/hardware
TIMER_HW_INC_DIR:=$(TIMER_HW_DIR)/include
TIMER_SRC_DIR:=$(TIMER_DIR)/hardware/src
TIMER_SW_DIR:=$(TIMER_DIR)/software
TIMER_DOC_DIR:=$(TIMER_DIR)/document
TIMER_SUBMODULES_DIR:=$(TIMER_DIR)/submodules

#submodules
TIMER_SUBMODULES:=INTERCON LIB TEX
$(foreach p, $(TIMER_SUBMODULES), $(eval $p_DIR ?=$(TIMER_DIR)/submodules/$p))

REMOTE_ROOT_DIR ?= sandbox/iob-soc/submodules/TIMER

#
# SIMULATION
#
SIMULATOR ?=icarus
SIM_DIR ?=$(TIMER_HW_DIR)/simulation/$(SIMULATOR)

#
# FPGA
#
FPGA_DIR ?=$(shell find $(TIMER_DIR)/hardware -name $(FPGA_FAMILY))

FPGA_FAMILY ?=CYCLONEV-GT
#FPGA_FAMILY ?=XCKU

FPGA_FAMILY_LIST = CYCLONEV-GT XCKU

REMOTE_ROOT_DIR ?= sandbox/iob-soc/submodules/TIMER

#
# DOCUMENTS
#
TEX_DIR ?=$(TIMER_SUBMODULES_DIR)/TEX

DOC:=pb
#DOC:=ug

DOC_LIST:=pb ug

DOC_DIR:=document/$(DOC)

INTEL ?=1
INT_FAMILY ?=CYCLONEV-GT
XILINX ?=1
XIL_FAMILY ?=XCKU



#
# VERSION
#
VERSION= 0.1
VLINE:="V$(VERSION)"
$(CORE_NAME)_version.txt:
ifeq ($(VERSION),)
	$(error "variable VERSION is not set")
endif
	echo $(VLINE) > version.txt

#RULES
corename:
	@echo $(CORE_NAME)

.PHONY: corename
