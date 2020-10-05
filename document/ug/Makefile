TIMER_DIR:=../..
CORE_DIR:=$(TIMER_DIR)

include $(TIMER_DIR)/submodules/TEX/document/document.mk
include $(HW_DIR)/hardware.mk

INTERCON_DIR:=$(SUBMODULES_DIR)/INTERCON/hardware/include

#interface signals tables
IS_TAB:=gen_is_tab.tex cpu_nat_s_is_tab.tex 

#software accessible registers tables
REG_TAB:=sw_reg_tab.tex

#main blocks table
BD_TAB:=bd_tab.tex

#synthesis parameters
PARAM_TAB:=sp_tab.tex

#tex sources
SRC:=$(wildcard ./*.tex) $(wildcard ../*.tex)  $(IS_TAB) $(REG_TAB) $(BD_TAB) $(PARAM_TAB)


gen_is_tab.tex: $(HW_DIR)/include/gen_if.v
	$(TEX_SW_DIR)/io2tex.py $< $@
cpu_nat_s_is_tab.tex: $(INTERCON_DIR)/cpu_nat_s_if.v
	$(TEX_SW_DIR)/io2tex.py $< $@
sw_reg_tab.tex: $(HW_DIR)/include/sw_reg.v
	$(TEX_SW_DIR)/swreg2tex.py $<
bd_tab.tex: $(HW_DIR)/src/iob_timer.v $(HW_DIR)/src/hardcore.v
	$(TEX_SW_DIR)/block2tex.py $@ $(HW_DIR)/src/iob_timer.v $(HW_DIR)/src/hardcore.v
sp_tab.tex: $(HW_DIR)/src/iob_timer.v $(HW_DIR)/include/export.vh
	$(TEX_SW_DIR)/param2tex.py $(HW_DIR)/src/iob_timer.v $@ $(HW_DIR)/include/export.vh

clean: texclean
	@rm -f $(IS_TAB) $(REG_TAB) $(BD_TAB) $(PARAM_TAB)

.PHONY: clean
