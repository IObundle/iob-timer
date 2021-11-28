include $(TIMER_DIR)/config.mk

#add itself to MODULES list
MODULES+=$(shell make -C $(TIMER_DIR) corename | grep -v make)

#include
INCLUDE+=-I$(TIMER_SW_DIR)

#headers
HDR+=$(TIMER_SW_DIR)/*.h TIMERsw_reg.h

TIMERsw_reg.h: $(TIMER_INC_DIR)/TIMERsw_reg.v
	$(LIB_DIR)/software/mkregs.py $< SW
