TIMER_DIR:=../../..

CLKBUF_WRAPPER:=xilinx

include ../fpga.mk

clean:
	@rm -rf .Xil/ *.map *. *~ synth_*.mmi synth_*.bit synth_system*.v *.vcd *_tb table.txt tab_*/ *webtalk* *.jou xelab.* xsim[._]* xvlog.* uart_loader *.ltx fsm_encoding.os $(COMPILE_OBJ) *.hex *.backup.log *_stub.v *.edif *_backup.log

clean-log:
	@rm -f *.log

.PHONY: clean clean-log
