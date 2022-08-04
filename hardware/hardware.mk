# (c) 2022-Present IObundle, Lda, all rights reserved
#
# This makefile segment lists all hardware header and source files 
#
# It is always included in submodules/LIB/Makefile for populating the
# build directory
#
ifeq ($(filter TIMER, $(HW_MODULES)),)

#add itself to MODULES list
HW_MODULES+=TIMER

#define

#import lib hardware
include hardware/iob_reg/hardware.mk

TIMER_INC_DIR:=$(TIMER_DIR)/hardware/include
TIMER_SRC_DIR:=$(TIMER_DIR)/hardware/src

#HEADERS
VHDR+=$(subst $(TIMER_INC_DIR), $(BUILD_VSRC_DIR), $(wildcard $(TIMER_INC_DIR)/*.vh))
$(BUILD_VSRC_DIR)/%.vh: $(TIMER_INC_DIR)/%.vh
	cp $< $(BUILD_VSRC_DIR)

VHDR+=$(BUILD_VSRC_DIR)/iob_timer_swreg_gen.vh $(BUILD_VSRC_DIR)/iob_timer_swreg_def.vh
$(BUILD_VSRC_DIR)/iob_timer_swreg_gen.vh: iob_timer_swreg_gen.vh 
	cp $< $(BUILD_VSRC_DIR)

$(BUILD_VSRC_DIR)/iob_timer_swreg_def.vh: iob_timer_swreg_def.vh
	cp $< $(BUILD_VSRC_DIR)

iob_timer_swreg_def.vh iob_timer_swreg_gen.vh: $(TIMER_DIR)/mkregs.conf
	$(MKREGS) iob_timer $(TIMER_DIR) HW

VHDR+=$(BUILD_VSRC_DIR)/iob_lib.vh
VHDR+=$(BUILD_VSRC_DIR)/iob_s_if.vh
VHDR+=$(BUILD_VSRC_DIR)/iob_gen_if.vh
VHDR+=$(BUILD_VSRC_DIR)/iob_intercon.vh
$(BUILD_VSRC_DIR)/%.vh: hardware/include/%.vh
	cp $< $(BUILD_VSRC_DIR)

#SOURCES
VSRC+=$(subst $(TIMER_SRC_DIR), $(BUILD_VSRC_DIR), $(wildcard $(TIMER_SRC_DIR)/*.v))
$(BUILD_VSRC_DIR)/%.v: $(TIMER_SRC_DIR)/%.v
	cp $< $(BUILD_VSRC_DIR)

endif
