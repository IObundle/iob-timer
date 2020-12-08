include $(TIMER_DIR)/core.mk

#path
TIMER_SW_DIR:=$(TIMER_DIR)/software

#include
INCLUDE+=-I$(TIMER_SW_DIR)

#headers
HDR+=$(TIMER_SW_DIR)/*.h $(TIMER_SW_DIR)/TIMERsw_reg.h

$(TIMER_SW_DIR)/TIMERsw_reg.h: $(TIMER_HW_INC_DIR)/TIMERsw_reg.v
	$(LIB_DIR)/software/mkregs.py $< SW
	mv TIMERsw_reg.h $@
