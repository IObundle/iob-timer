`timescale 1ns / 1ps
`include "iob_lib.vh"
`include "iob_timer_swreg_def.vh"

module timer_core #(
   parameter DATA_W = 32
) (
   input                                                     clk_i,
   input                                                     cke_i,
   input                                                     arst_i,
   input                                                     TIMER_ENABLE,
   input                                                     TIMER_SAMPLE,
   output [`IOB_TIMER_DATA_LOW_W+`IOB_TIMER_DATA_HIGH_W-1:0] TIMER_VALUE
);


   `IOB_WIRE(time_counter, 2 * DATA_W)
   iob_counter #(
      .DATA_W (2 * DATA_W),
      .RST_VAL(0)
   ) time_counter_cnt (
      .clk_i (clk_i),
      .arst_i(arst_i),
      .cke_i (cke_i),
      .rst_i (1'b0),
      .en_i  (TIMER_ENABLE),
      .data_o(time_counter)
   );

   //time counter register
   iob_reg_e #(
      .DATA_W (2 * DATA_W),
      .RST_VAL(0)
   ) time_counter_reg (
      .clk_i (clk_i),
      .arst_i(arst_i),
      .cke_i (cke_i),
      .en_i  (TIMER_SAMPLE),
      .data_i(time_counter),
      .data_o(TIMER_VALUE)
   );

endmodule
