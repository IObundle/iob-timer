#
# This file is included in BUILD_DIR/sim/Makefile
#

# include core basic info
include ../../info.mk

VFLAGS+=-DDATA_W=32

#tests
TEST_LIST+=test1
test1:
	make run SIMULATOR=icarus 
