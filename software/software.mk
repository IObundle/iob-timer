include $(TIMER_DIR)/config.mk

#include
INCLUDE+=-I$(TIMER_SW_DIR)

#headers
HDR+=$(TIMER_SW_DIR)/*.h iob_timer_swreg.h

#sources
SRC+=$(TIMER_SW_DIR)/iob-timer.c

iob_timer_swreg.h: $(TIMER_INC_DIR)/iob_timer_swreg.vh
	$(LIB_DIR)/software/python/mkregs.py $< SW TIMER $(TIMER_INC_DIR)/iob_timer.vh

