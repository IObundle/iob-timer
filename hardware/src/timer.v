`timescale 1ns/1ps
`include "iob_lib.vh"
`include "TIMERsw_reg.vh"

module timer_core
  #(
    parameter DATA_W = 32
    )
   (
    `INPUT(TIMER_ENABLE, `TIMER_ENABLE_W),
    `INPUT(TIMER_SAMPLE, `TIMER_SAMPLE_W),
    `OUTPUT(TIMER_VALUE, `TIMER_DATA_LOW_W+`TIMER_DATA_HIGH_W),
    `INPUT(clk, 1),
    `INPUT(rst, 1)
    );


   `SIGNAL(time_counter, 2*DATA_W)
   `COUNTER_ARE(clk, rst, TIMER_ENABLE, time_counter)

   //time counter register
   `SIGNAL(counter_reg, 2*DATA_W)

   `REG_E(clk, TIMER_SAMPLE, counter_reg, time_counter)
   //always @(negedge clk) if(TIMER_SAMPLE)  counter_reg <= time_counter;

   `SIGNAL2OUT(TIMER_VALUE, counter_reg)

endmodule
