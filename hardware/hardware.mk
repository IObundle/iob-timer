include $(TIMER_DIR)/config.mk

#add itself to MODULES list
MODULES+=$(shell make -C $(TIMER_DIR) corename | grep -v make)

#include submodule's hardware
$(foreach p, $(SUBMODULES), $(if $(filter $p, $(MODULES)),,$(eval include $($p_DIR)/hardware/hardware.mk)))

#define

#include
INCLUDE+=$(incdir)$(TIMER_INC_DIR)

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
