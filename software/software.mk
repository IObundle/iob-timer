include $(TIMER_DIR)/config.mk

#include
INCLUDE+=-I$(TIMER_SW_DIR)

#headers
HDR+=$(TIMER_SW_DIR)/*.h $(TOP_MODULE)_swreg.h

#sources
SRC+=$(TIMER_SW_DIR)/iob-timer.c

$(TOP_MODULE)_swreg.h: $(TIMER_INC_DIR)/$(TOP_MODULE)_swreg.vh
	$(LIB_DIR)/software/python/mkregs.py $< SW

