include $(TIMER_DIR)/core.mk

#submodules
ifneq (INTERCON,$(filter INTERCON, $(SUBMODULES)))
SUBMODULES+=INTERCON
include $(INTERCON_DIR)/hardware/hardware.mk
endif

#lib
ifneq (LIB,$(filter LIB, $(SUBMODULES)))
SUBMODULES+=LIB
INCLUDE+=$(incdir) $(LIB_DIR)/hardware/include
VHDR+=$(wildcard $(LIB_DIR)/hardware/include/*.vh)
endif

#define

#include
INCLUDE+=$(incdir) $(TIMER_INC_DIR)

#headers
VHDR+=$(wildcard $(TIMER_INC_DIR)/*.vh)
VHDR+=TIMERsw_reg_gen.v TIMERsw_reg.vh

#sources
VSRC+=$(wildcard $(TIMER_SRC_DIR)/*.v)

TIMERsw_reg_gen.v TIMERsw_reg.vh: $(TIMER_INC_DIR)/TIMERsw_reg.v
	$(LIB_DIR)/software/mkregs.py $< HW

timer_clean_hw:
	@rm -rf TIMERsw_reg_gen.v TIMERsw_reg.vh tmp

.PHONY: timer_clean_hw
