#
# This file is included in BUILD_DIR/sim/Makefile
#
# Variables and targets specific to core simulation.
#

# include core basic info
include ../../info.mk

#tests
TEST_LIST+=test1
test1:
	make run SIMULATOR=icarus 
