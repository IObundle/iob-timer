ifeq ($(filter TIMER, $(SW_MODULES)),)

#add itself to MODULES list
SW_MODULES+=TIMER

#uart common parameters
include $(TIMER_DIR)/software/software.mk

# add pc-emul sources
SRC+=$(TIMER_SW_DIR)/pc-emul/iob_timer_swreg_pc_emul.c

endif
