CORE_NAME:=TIMER

#PATHS
TIMER_HW_DIR:=$(TIMER_DIR)/hardware
TIMER_INC_DIR:=$(TIMER_HW_DIR)/include
LIB_DIR:=$(TIMER_DIR)/submodules/LIB
INTERCON_DIR:=$(TIMER_DIR)/submodules/INTERCON
TIMER_SW_DIR:=$(TIMER_DIR)/software

#DOCUMENT
DOC_TYPE:=pb
#DOC_TYPE:=ug

#FPGA
COMPILE_DIR ?= sandbox/iob-timer/hardware/fpga/$(FPGA_FAMILY)
COMPILE_USER ?= jousa
COMPILE_SERVER ?=pudim-flan.iobundle.com
#COMPILE_SERVER ?=localhost
FPGA_FAMILY ?=XCKU

FPGA_DIR ?=$(TIMER_DIR)/hardware/fpga/$(FPGA_FAMILY)

ifeq ($(FPGA_FAMILY),CYCLONEV-GT)
	COMPILE_OBJ ?=timer_0.qxp
else
	COMPILE_OBJ ?=timer_0.edif
endif
