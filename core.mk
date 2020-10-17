CORE_NAME:=TIMER
IS_CORE:=1
USE_NETLIST ?=0

#PATHS
TIMER_HW_DIR:=$(TIMER_DIR)/hardware
TIMER_INC_DIR:=$(TIMER_HW_DIR)/include
TIMER_DOC_DIR:=$(TIMER_DIR)/document
TIMER_SUBMODULES_DIR:=$(TIMER_DIR)/submodules
INTERCON_DIR:=$(TIMER_DIR)/submodules/INTERCON
LIB_DIR:=$(TIMER_DIR)/submodules/LIB
TEX_DIR:=$(TIMER_DIR)/submodules/TEX
REMOTE_ROOT_DIR ?= sandbox/iob-soc/submodules/TIMER

#DOCUMENT
DOC_TYPE:=pb
#DOC_TYPE:=ug
INTEL ?=1
XILINX ?=1

#FPGA
#FPGA_FAMILY ?=CYCLONEV-GT
FPGA_FAMILY ?=XCKU
#FPGA_SERVER ?=localhost
FPGA_SERVER ?=pudim-flan.iobundle.com
FPGA_USER ?= $(USER)

ifeq ($(FPGA_FAMILY),XCKU)
	FPGA_COMP:=vivado
	FPGA_PART:=xcku040-fbva676-1-c
else
	FPGA_COMP:=quartus
	FPGA_PART:=5CGTFD9E5F35C7
endif
FPGA_DIR ?=$(TIMER_DIR)/hardware/fpga/$(FPGA_COMP)

ifeq ($(FPGA_COMP),vivado)
FPGA_LOG:=vivado.log
else ifeq ($(FPGA_COMP),quartus)
FPGA_LOG:=quartus.log
endif

VLINE:="V$(VERSION)"
version.txt:
ifeq ($(VERSION),)
	$(error "variable VERSION is not set")
endif
	echo $(VLINE) > $@

.PHONY: version.txt
