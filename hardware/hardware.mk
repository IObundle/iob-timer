TIMER_HW_DIR:=$(TIMER_DIR)/hardware

#include
TIMER_INC_DIR:=$(TIMER_HW_DIR)/include
INCLUDE+=$(incdir) $(TIMER_INC_DIR)

#headers
VHDR+=$(wildcard $(TIMER_INC_DIR)/*.vh)

#sources
TIMER_SRC_DIR:=$(TIMER_DIR)/hardware/src
VSRC+=$(wildcard $(TIMER_HW_DIR)/src/*.v)
