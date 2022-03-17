ifeq ($(filter TIMER, $(SW_MODULES)),)

#add itself to MODULES list
SW_MODULES+=TIMER

#uart common parameters
include $(TIMER_DIR)/software/software.mk

#pc-emul headers
HDR+=$(TIMER_SW_DIR)/pc-emul/iob-timer-platform.h
INCLUDE+=$(incdir)$(TIMER_SW_DIR)/pc-emul

endif
