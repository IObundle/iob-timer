ifeq ($(filter TIMER, $(SW_MODULES)),)

#add itself to MODULES list
SW_MODULES+=TIMER

include $(TIMER_DIR)/software/software.mk

# add embedded sources
SRC+=iob_timer_swreg_emb.c

iob_timer_swreg_emb.c: iob_timer_swreg.h
	
endif
