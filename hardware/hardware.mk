include $(TIMER_DIR)/core.mk

#define
DEFINE+=$(defmacro) DATA_W=32

#include
INCLUDE+=$(incdir) $(TIMER_HW_INC_DIR)
INCLUDE+=$(incdir) $(LIB_DIR)/hardware/include
INCLUDE+=$(incdir) $(INTERCON_DIR)/hardware/include 

#headers
VHDR+=$(wildcard $(TIMER_HW_INC_DIR)/*.vh)
VHDR+=$(wildcard $(LIB_DIR)/hardware/include/*.vh)
VHDR+=$(wildcard $(INTERCON_DIR)/hardware/include/*.vh $(INTERCON_DIR)/hardware/include/*.v)
VHDR+=$(TIMER_HW_INC_DIR)/sw_reg_gen.v

#sources
TIMER_SRC_DIR:=$(TIMER_DIR)/hardware/src
VSRC+=$(wildcard $(TIMER_HW_DIR)/src/*.v)

$(TIMER_HW_INC_DIR)/sw_reg_gen.v: $(TIMER_HW_INC_DIR)/sw_reg.v
	$(LIB_DIR)/software/mkregs.py $< HW
	mv sw_reg_gen.v $(TIMER_HW_INC_DIR)
	mv sw_reg_w.vh $(TIMER_HW_INC_DIR)

clean_hw:
	@rm -rf $(TIMER_HW_INC_DIR)/sw_reg_gen.v $(TIMER_HW_INC_DIR)/sw_reg_w.vh tmp $(TIMER_HW_DIR)/fpga/vivado/XCKU $(TIMER_HW_DIR)/fpga/quartus/CYCLONEV-GT

.PHONY: clean_hw
