include $(TIMER_DIR)/config.mk

#include
INCLUDE+=-I$(TIMER_SW_DIR)

#headers
HDR+=$(TIMER_SW_DIR)/*.h iob_timer_swreg.h

#sources
SRC+=$(TIMER_SW_DIR)/iob-timer.c

iob_timer_swreg.h: $(TIMER_DIR)/mkregs.conf
	$(LIB_DIR)/software/python/mkregs.py iob_timer $(TIMER_DIR) SW $(TIMER_INC_DIR)/iob_timer.vh

