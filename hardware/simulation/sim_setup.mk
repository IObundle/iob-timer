#
# This file segment is included in LIB_DIR/Makefile
#
# Adds files and targets to VSRC and VHDR used at setup.
#

# copy simulation wrapper
VSRC+=$(BUILD_VSRC_DIR)/timer_tb.v
$(BUILD_VSRC_DIR)/timer_tb.v: $(CORE_SIM_DIR)/timer_tb.v
	cp $< $(BUILD_VSRC_DIR)
