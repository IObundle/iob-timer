ifeq ($(filter TIMER, $(HW_MODULES)),)

include $(TIMER_DIR)/config.mk

#add itself to MODULES list
HW_MODULES+=TIMER

#define

#include
INCLUDE+=$(incdir)$(TIMER_INC_DIR) $(incdir)$(LIB_DIR)/hardware/include

#headers
VHDR+=$(wildcard $(TIMER_INC_DIR)/*.vh)
VHDR+=$(TOP_MODULE)_swreg_gen.vh $(TOP_MODULE)_swreg_def.vh

#sources
VSRC+=$(wildcard $(TIMER_SRC_DIR)/*.v)

$(TOP_MODULE)_swreg_gen.vh $(TOP_MODULE)_swreg_def.vh: $(TIMER_INC_DIR)/$(TOP_MODULE)_swreg.vh
	$(LIB_DIR)/software/python/mkregs.py $< HW

timer_clean_hw:
	@rm -rf $(TOP_MODULE)_swreg_gen.vh $(TOP_MODULE)_swreg_def.vh tmp

.PHONY: timer_clean_hw
endif
