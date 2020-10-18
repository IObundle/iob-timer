`timescale 1ns/1ps
`include "iob_lib.vh"
`include "interconnect.vh"

module timer_tb;

   localparam PER=10;
   
   `CLOCK(clk, PER)
   `RESET(rst, 7, 10)

   `SIGNAL(TIMER_ENABLE, 1)
   `SIGNAL(TIMER_SAMPLE, 1)
   `SIGNAL_OUT(TIMER_VALUE, 2*`DATA_W)
   
   initial begin
`ifdef VCD
      $dumpfile("timer.vcd");
      $dumpvars();
`endif
      TIMER_ENABLE = 0;
      TIMER_SAMPLE = 0;

      @(posedge rst);
      @(negedge rst);
      @(posedge clk) #1 TIMER_ENABLE = 1;
      @(posedge clk) #1 TIMER_SAMPLE = 1;
      @(posedge clk) #1 TIMER_SAMPLE = 0;

      //uncomment to fail the test 
      //@(posedge clk) #1;
      
      $write("Current time: %d; Timer value %d\n", $time, TIMER_VALUE);
      #(1000*PER) @(posedge clk) #1 TIMER_SAMPLE = 1;
      @(posedge clk) #1 TIMER_SAMPLE = 0;
      $write("Current time: %d; Timer value %d\n", $time, TIMER_VALUE);

      if( TIMER_VALUE == 1003) 
        $display("Test passed");
      else
        $display("Test failed: expecting timer value 1003 but got %d", TIMER_VALUE);
      
      $finish;
   end
   
   //instantiate timer core
   timer_core timer0
     (
      .TIMER_ENABLE(TIMER_ENABLE),
      .TIMER_SAMPLE(TIMER_SAMPLE),
      .TIMER_VALUE(TIMER_VALUE),
      .clk(clk),
      .rst(rst)
      );   

endmodule
