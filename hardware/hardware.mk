ifeq ($(filter TIMER, $(HW_MODULES)),)

include $(TIMER_DIR)/config.mk

#add itself to MODULES list
HW_MODULES+=TIMER

#define

#include
INCLUDE+=$(incdir)$(TIMER_INC_DIR) $(incdir)$(LIB_DIR)/hardware/include

#headers
VHDR+=$(wildcard $(TIMER_INC_DIR)/*.vh)
VHDR+=TIMERsw_reg_gen.vh TIMERsw_reg.vh

#sources
VSRC+=$(wildcard $(TIMER_SRC_DIR)/*.v)

TIMERsw_reg_gen.vh TIMERsw_reg.vh: $(TIMER_INC_DIR)/TIMERsw_reg.vh
	$(LIB_DIR)/software/python/mkregs.py $< HW

timer_clean_hw:
	@rm -rf TIMERsw_reg_gen.vh TIMERsw_reg.vh tmp

.PHONY: timer_clean_hw
endif
