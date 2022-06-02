`timescale 1ns/1ps
`include "iob_lib.vh"
`include "iob_timer_swreg_def.vh"

module timer_core
  #(
    parameter DATA_W = 32
    )
   (
    `IOB_INPUT(TIMER_ENABLE, 1),
    `IOB_INPUT(TIMER_SAMPLE, 1),
    `IOB_OUTPUT(TIMER_VALUE, `TIMER_DATA_LOW_W+`TIMER_DATA_HIGH_W),
    `IOB_INPUT(clk, 1),
    `IOB_INPUT(rst, 1)
    );


   `IOB_VAR(time_counter, 2*DATA_W)
   `IOB_COUNTER_ARE(clk, rst, TIMER_ENABLE, time_counter)

   //time counter register
   `IOB_VAR(counter_reg, 2*DATA_W)

   `IOB_REG_E(clk, TIMER_SAMPLE, counter_reg, time_counter)

   `IOB_VAR2WIRE(counter_reg, TIMER_VALUE)

endmodule
