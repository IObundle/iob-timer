include $(TIMER_DIR)/config.mk

#include
INCLUDE+=-I$(TIMER_SW_DIR)

#headers
HDR+=$(TIMER_SW_DIR)/*.h TIMERsw_reg.h

#sources
SRC+=$(TIMER_SW_DIR)/iob_timer.c

TIMERsw_reg.h: $(TIMER_INC_DIR)/TIMERsw_reg.vh
	$(LIB_DIR)/software/python/mkregs.py $< SW

