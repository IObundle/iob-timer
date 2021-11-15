TIMER_DIR:=../..
incdir:=-I
defmacro:=-D
include $(TIMER_DIR)/hardware/hardware.mk

DEFINE+=$(defmacro)DATA_W=$(DATA_W)

DEFINE+=$(defmacro)VCD

VSRC+=$(TIMER_TB_DIR)/timer_tb.v


#icarus verilog simulator
VLOG:=iverilog -W all -g2005-sv

run: a.out
	./$<
ifeq ($(VCD),1)
	gtkwave -a waves.gtkw *.vcd &
endif


a.out: $(VSRC) $(VHDR)
	$(VLOG) $(INCLUDE) $(DEFINE) $(VSRC)

clean: timer_clean_hw
	@rm -f a.out *~ *.vcd *.v *.vh

.PHONY: all clean
