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
    `IOB_OUTPUT(TIMER_VALUE, `IOB_TIMER_DATA_LOW_W+`IOB_TIMER_DATA_HIGH_W),
    `IOB_INPUT(clk_i, 1),
    `IOB_INPUT(cke_i, 1),
    `IOB_INPUT(arst_i, 1)
    );


   `IOB_WIRE(time_counter, 2*DATA_W)
    iob_counter #(2*DATA_W,0) time_counter_cnt (clk_i, arst_i, cke_i, 1'b0, TIMER_ENABLE, time_counter);

   //time counter register
    iob_reg_e #(2*DATA_W,0) time_counter_reg (clk_i, arst_i, cke_i, TIMER_SAMPLE, time_counter, TIMER_VALUE);

endmodule
