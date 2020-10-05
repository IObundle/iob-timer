TIMER_INC_DIR:=$(TIMER_DIR)/hardware/include
LIB_DIR:=$(TIMER_DIR)/submodules/LIB
TIMER_SW_DIR:=$(TIMER_DIR)/software

#include
INCLUDE+=-I$(TIMER_SW_DIR)

#headers
HDR+=$(TIMER_SW_DIR)/*.h $(TIMER_SW_DIR)/timer_sw_reg.h

$(TIMER_SW_DIR)/timer_sw_reg.h: $(TIMER_INC_DIR)/sw_reg.v
	$(LIB_DIR)/software/mkregs.py $< SW
	mv sw_reg.h $@
