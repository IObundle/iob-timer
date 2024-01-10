CORE := iob_timer
LIB_DIR ?= ../IOBSOC/submodules/LIB

DISABLE_LINT:=1

PROJECT_ROOT := ..

TOP_MODULE_NAME := iob_timer

include $(LIB_DIR)/setup.mk

BUILD_DIR = ../$(CORE)_V*

$(BUILD_DIR):
	nix-shell --run 'make build-setup SETUP_ARGS="$(SETUP_ARGS)"'

setup: $(BUILD_DIR)

sim-test: clean setup
	nix-shell --run "make build-setup && make -C ../iob_timer_* sim-test"
