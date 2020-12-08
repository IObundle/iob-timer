#exports software embedded stuff to system; TIMER_DIR defined in system.mk

include $(TIMER_DIR)/software/software.mk

#embeded sources
SRC+=$(TIMER_SW_DIR)/embedded/iob_timer.c
