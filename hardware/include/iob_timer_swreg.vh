//START_TABLE sw_reg
`IOB_SWREG_W(TIMER_RESET,          1, 0) //Timer soft reset
`IOB_SWREG_W(TIMER_ENABLE,         1, 0) //Timer enable
`IOB_SWREG_W(TIMER_SAMPLE,         1, 0) //Sample time counter value into a readable register
`IOB_SWREG_R(TIMER_DATA_HIGH, DATA_W, 0) //High part of the timer value, which has twice the width of the data word width
`IOB_SWREG_R(TIMER_DATA_LOW,  DATA_W, 0) //Low part of the timer value, which has twice the width of the data word width

