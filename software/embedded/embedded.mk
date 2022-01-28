ifeq ($(filter TIMER, $(SW_MODULES)),)

#add itself to MODULES list
SW_MODULES+=TIMER

include $(TIMER_DIR)/software/software.mk

#embeded sources
SRC+=$(TIMER_SW_DIR)/embedded/iob_timer.c

endif
