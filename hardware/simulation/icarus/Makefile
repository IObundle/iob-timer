TIMER_DIR:=../../..
incdir:=-I
defmacro:=-D
include ../simulation.mk

#icarus verilog simulator
VLOG:=iverilog -W all -g2005-sv

run: a.out
	./$<
ifeq ($(VCD),1)
	gtkwave -a ../waves.gtkw *.vcd &
endif

a.out: $(VSRC) $(VHDR)
	$(VLOG) $(INCLUDE) $(DEFINE) $(VSRC)

clean: timer_clean_hw
	@rm -f a.out *~ *.vcd

.PHONY: all clean

