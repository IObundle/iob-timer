include $(I2S_DIR)/core.mk
include $(I2S_DIR)/hardware/hardware.mk

run:compile

compile: $(COMPILE_OBJ)

$(COMPILE_OBJ): $(wildcard *.sdc) $(VSRC) $(VHDR)
	./build.sh "$(VSRC)" "$(INCLUDE)" "$(DEFINE)"

.PRECIOUS: $(COMPILE_OBJ)

.PHONY: load compile
