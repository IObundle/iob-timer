`timescale 1ns / 1ps
`include "iob_lib.vh"
`include "iob_timer_conf.vh"
`include "iob_timer_swreg_def.vh"

module iob_timer #(
   `include "iob_timer_params.vs"
) (
   `include "iob_timer_io.vs"
);
   // This mapping is required because "iob_timer_swreg_inst.vh" uses "iob_s_portmap.vh" (This would not be needed if mkregs used "iob_s_s_portmap.vh" instead)
   wire [         1-1:0] iob_avalid = iob_avalid_i;  //Request valid.
   wire [    ADDR_W-1:0] iob_addr = iob_addr_i;  //Address.
   wire [    DATA_W-1:0] iob_wdata = iob_wdata_i;  //Write data.
   wire [(DATA_W/8)-1:0] iob_wstrb = iob_wstrb_i;  //Write strobe.
   wire [         1-1:0]                                              iob_rvalid;
   assign iob_rvalid_o = iob_rvalid;  //Read data valid.
   wire [DATA_W-1:0] iob_rdata;
   assign iob_rdata_o = iob_rdata;  //Read data.
   wire [1-1:0] iob_ready;
   assign iob_ready_o = iob_ready;  //Interface ready.


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
