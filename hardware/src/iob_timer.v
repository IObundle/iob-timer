`timescale 1ns/1ps
`include "iob_timer.vh"
`include "iob_lib.vh"

module iob_timer 
  #(
    parameter ADDR_W = `TIMER_ADDR_W, //Data word width
    parameter DATA_W = `DATA_W, //Data word width
    parameter WDATA_W = `TIMER_WDATA_W //Data word width
    )
   (
`include "cpu_nat_s_if.v"
    `INPUT(clk, 1),
    `INPUT(rst, 1)
    );

//BLOCK Register File & Configuration, control and status registers accessible by the sofware
`include "sw_reg.v"
`include "sw_reg_gen.v"

    //combined hard/soft reset 
   `SIGNAL(rst_int, 1)
   `COMB rst_int = rst | TIMER_RESET;

   //write signal
   `SIGNAL(write, 1) 
   `COMB write = | wstrb;

   //time counter
   `SIGNAL(time_counter, 2*DATA_W)
   `COUNTER_ARE(clk, rst_int, TIMER_ENABLE, time_counter)

   //time counter register
   `SIGNAL(counter_reg, 2*DATA_W)
   `REG_E(clk, TIMER_SAMPLE, counter_reg, time_counter)

   //ready signal   
   `SIGNAL(ready_int, 1)
   `REG_AR(clk, rst, 0, ready_int, valid)

   `SIGNAL2OUT(ready, ready_int)

   //rdata signal
   `COMB begin
      TIMER_DATA_LOW = counter_reg[DATA_W-1:0];
      TIMER_DATA_HIGH = counter_reg[2*DATA_W-1:DATA_W];      
   end
      
endmodule

