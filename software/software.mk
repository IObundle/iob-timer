include $(TIMER_DIR)/core.mk

#include
INCLUDE+=-I$(TIMER_SW_DIR)

#headers
HDR+=$(TIMER_SW_DIR)/*.h TIMERsw_reg.h

TIMERsw_reg.h: $(TIMER_HW_INC_DIR)/TIMERsw_reg.v
	$(LIB_DIR)/software/mkregs.py $< SW
