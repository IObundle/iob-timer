`timescale 1ns / 1ps
`include "iob_timer_conf.vh"
`include "iob_timer_swreg_def.vh"

module iob_timer #(
   `include "iob_timer_params.vs"
) (
   `include "iob_timer_io.vs"
);

   //Dummy iob_ready_nxt_o and iob_rvalid_nxt_o to be used in swreg (unused ports)
   wire iob_ready_nxt_o;
   wire iob_rvalid_nxt_o;

   //BLOCK Register File & Configuration, control and status registers accessible by the sofware
   `include "iob_timer_swreg_inst.vs"

   // SWRegs

   //combined hard/soft reset
   `IOB_VAR(arst_int, 1)
   `IOB_COMB arst_int = arst_i | RESET;

   //
   //BLOCK 64-bit time counter & Free-running 64-bit counter with enable and soft reset capabilities
   //
   `IOB_WIRE(TIMER_VALUE, 2 * DATA_W)
   timer_core timer0 (
      .TIMER_ENABLE(ENABLE),
      .TIMER_SAMPLE(SAMPLE),
      .TIMER_VALUE (TIMER_VALUE),
      .clk_i       (clk_i),
      .cke_i       (cke_i),
      .arst_i      (arst_int)
   );

   assign DATA_LOW  = TIMER_VALUE[DATA_W-1:0];
   assign DATA_HIGH = TIMER_VALUE[2*DATA_W-1:DATA_W];

endmodule
