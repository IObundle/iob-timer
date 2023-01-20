#!/usr/bin/env python3

import os, sys
sys.path.insert(0, os.getcwd()+'/submodules/LIB/scripts')
import setup

meta = \
{
'name':'iob_timer',
'version':'V0.10',
'flows':'sim',
'setup_dir':os.path.dirname(__file__)}
meta['build_dir']=f"../{meta['name']+'_'+meta['version']}"
meta['submodules'] = {
    'hw_setup': {
        'headers' : [ 'iob_s_port', 'iob_s_portmap' ],
        'modules': [ 'iob_reg.v', 'iob_reg_e.v' ]
    },
}

confs = \
[
    # Macros

    # Parameters
    {'name':'DATA_W',  'type':'P', 'val':'32', 'min':'NA', 'max':'NA', 'descr':"Data bus width"},
    {'name':'ADDR_W',  'type':'P', 'val':'`IOB_TIMER_SWREG_ADDR_W', 'min':'NA', 'max':'NA', 'descr':"Address bus width"},
    {'name':'WDATA_W', 'type':'P', 'val':'1', 'min':'NA', 'max':'8', 'descr':""}
]

ios = \
[
    {'name': 'iob_s_port', 'descr':'CPU native interface', 'ports': [
    ]},
    {'name': 'general', 'descr':'General interface signals', 'ports': [
        {'name':"clk_i" , 'type':"I", 'n_bits':'1', 'descr':"System clock input"},
        {'name':"arst_i", 'type':"I", 'n_bits':'1', 'descr':"System reset, asynchronous and active high"},
        {'name':"cke_i" , 'type':"I", 'n_bits':'1', 'descr':"System reset, asynchronous and active high"}
    ]},
]

regs = \
[
    {'name': 'timer', 'descr':'TIMER software accessible registers.', 'regs': [
        {'name':"RESET", 'type':"W", 'n_bits':1, 'rst_val':0, 'addr':-1, 'log2n_items':0, 'autologic':True, 'descr':"Timer soft reset"},
        {'name':"ENABLE", 'type':"W", 'n_bits':1, 'rst_val':0, 'addr':-1, 'log2n_items':0, 'autologic':True, 'descr':"Timer enable"},
        {'name':"SAMPLE", 'type':"W", 'n_bits':1, 'rst_val':0, 'addr':-1, 'log2n_items':0, 'autologic':True, 'descr':"Sample time counter value into a readable register"},
        {'name':"DATA_HIGH", 'type':"R", 'n_bits':32, 'rst_val':0, 'addr':-1, 'log2n_items':0, 'autologic':True, 'descr':"High part of the timer value, which has twice the width of the data word width"},
        {'name':"DATA_LOW", 'type':"R", 'n_bits':32, 'rst_val':0, 'addr':-1, 'log2n_items':0, 'autologic':True, 'descr':"Low part of the timer value, which has twice the width of the data word width"},
    ]}
]

blocks = []

# Main function to setup this core and its components
def main():
    setup.setup(sys.modules[__name__])

if __name__ == "__main__":
    main()
