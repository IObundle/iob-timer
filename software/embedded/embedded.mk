ifeq ($(filter TIMER, $(SW_MODULES)),)

#add itself to MODULES list
SW_MODULES+=TIMER

include $(TIMER_DIR)/software/software.mk

#embedded headers
HDR+=$(TIMER_DIR)/software/embedded/iob-timer-platform.h
INCLUDE+=$(incdir)$(TIMER_DIR)/software/embedded

endif
