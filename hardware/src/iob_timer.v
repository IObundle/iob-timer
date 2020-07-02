`timescale 1ns/1ps
`include "iob_timer.vh"

module iob_timer (
		  input 	    clk,
		  input 	    rst, //Count reset.

		  //cpu interface
		  input 	    valid,
		  input [1:0] 	    address,
		  input [31:0] 	    wdata,
		  output reg [31:0] rdata,
		  output reg 	    ready
		  );

   //counter
   reg [64:0]   counter;
   reg [64:0]	tmp_reg;
   
   // reset
   wire         rst_int;
   reg          rst_soft;
   reg          rst_soft_en;
   reg		tmp_reg_en;
   

   always @* begin
   	rst_soft_en = 1'b0;
   	tmp_reg_en = 1'b0;
        rdata = 32'b0;
   	if(valid)
   	  case (address)
   	    `TIMER_RESET:     rst_soft_en = 1'b1;
   	    `TIMER_STOP:      tmp_reg_en = 1'b1;
   	    `TIMER_DATA_HIGH: rdata = tmp_reg[63:32];
   	    `TIMER_DATA_LOW:  rdata = tmp_reg[31:0];
   	    default:;
   	  endcase
   end 
     	
   //soft reset pulse
   always @(posedge clk, posedge rst)
     if(rst)
       rst_soft <= 1'b0;
     else if (rst_soft_en)
       rst_soft <= wdata[0];
     else
       rst_soft <= 1'b0;
   
   // cpu interface ready signal
   always @(posedge clk, posedge rst)
     if(rst)
       ready <= 1'b0;
     else 
       ready <= valid;
       
   assign rst_int = rst | rst_soft;
   
   //Cycles counter
   always @ (posedge clk, posedge rst_int)
     if (rst_int)
        counter <= 0; 
     else
        counter <= counter + 1'b1;
     
     //Temporary Register
     always @ (posedge clk, posedge rst_int)
     if (rst_int)
        tmp_reg <= 0; 
     else if(tmp_reg_en)
        tmp_reg <= counter;
   
endmodule

