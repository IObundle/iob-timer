`timescale 1ns/1ps
`include "iob_lib.vh"
`include "iob_intercon.vh"
`include "iob_timer.vh"

module iob_timer
  #(
    parameter ADDR_W = `TIMER_ADDR_W, //NODOC Address width
    parameter DATA_W = 32, //NODOC Data word width
    parameter WDATA_W = `TIMER_WDATA_W //NODOC Data word width on writes
    )
   (
`include "iob_s_if.vh"
`include "gen_if.vh"
    );

//BLOCK Register File & Configuration, control and status registers accessible by the sofware
`include "iob_timer_swreg.vh"
`include "iob_timer_swreg_gen.vh"

    //combined hard/soft reset
   `IOB_VAR(rst_int, 1)
   `IOB_COMB rst_int = rst | TIMER_RESET;

   //write signal
   `IOB_VAR(write, 1)
   `IOB_COMB write = | wstrb;

   //
   //BLOCK 64-bit time counter & Free-running 64-bit counter with enable and soft reset capabilities
   //
   `IOB_WIRE(TIMER_VALUE, 2*DATA_W)
   timer_core timer0
     (
      .TIMER_ENABLE(TIMER_ENABLE),
      .TIMER_SAMPLE(TIMER_SAMPLE),
      .TIMER_VALUE(TIMER_VALUE),
      .clk(clk),
      .rst(rst_int)
      );

    assign  TIMER_DATA_LOW = TIMER_VALUE[DATA_W-1:0];
    assign  TIMER_DATA_HIGH = TIMER_VALUE[2*DATA_W-1:DATA_W];      

endmodule
