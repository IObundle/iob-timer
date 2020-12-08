TIMER_DIR:=../..
include $(TIMER_DIR)/core.mk

IS_TAB:=gen_is_tab.tex cpu_nat_s_is_tab.tex 

REG_TAB:=sw_reg_tab.tex

BD_TAB:=bd_tab.tex

SRC:=ug.tex $(wildcard ./*.tex) $(wildcard ../*.tex)  $(IS_TAB) $(REG_TAB) $(BD_TAB)

include $(TIMER_DIR)/submodules/TEX/document/document.mk

gen_is_tab.tex: $(INTERCON_DIR)/hardware/include/gen_if.v
	$(TEX_SW_DIR)/io2tex.py $< $@

cpu_nat_s_is_tab.tex: $(INTERCON_DIR)/hardware/include/cpu_nat_s_if.v
	$(TEX_SW_DIR)/io2tex.py $< $@

sw_reg_tab.tex: $(TIMER_HW_DIR)/include/TIMERsw_reg.v
	$(TEX_SW_DIR)/swreg2tex.py $<

bd_tab.tex: $(TIMER_HW_DIR)/src/iob_timer.v
	$(TEX_SW_DIR)/block2tex.py $@ $(TIMER_HW_DIR)/src/iob_timer.v

clean: texclean
	@rm -f $(IS_TAB) $(REG_TAB) $(BD_TAB)

.PHONY: clean
