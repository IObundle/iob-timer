TIMER_SW_DIR:=$(TIMER_DIR)/software

#include
INCLUDE+=-I$(TIMER_SW_DIR)

#headers
HDR+=$(TIMER_SW_DIR)/*.h

