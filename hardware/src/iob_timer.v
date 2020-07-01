`timescale 1ns/1ps

`define TIMER_RESET (`UART_ADDR_W'd0)
`define TIMER_STOP (`UART_ADDR_W'd1)
`define TIMER_DATA_HIGH (`UART_ADDR_W'd2)
`define TIMER_DATA_LOW (`UART_ADDR_W'd3)

module iob_timer
   (
    input 	      rst, //Count reset.
    input 	      clk,
    input [1:0]       addr,
    input [31:0]      data_in,
    output reg [31:0] data_out,
    input 	      valid,
    output reg 	      ready
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
        data_out = 32'b0;
   	if(valid)
   	  case (addr)
   	    `TIMER_RESET:     rst_soft_en = 1'b1;
   	    `TIMER_STOP:      tmp_reg_en = 1'b1;
   	    `TIMER_DATA_HIGH: data_out = tmp_reg[63:32];
   	    `TIMER_DATA_LOW:  data_out = tmp_reg[31:0];
   	    default:;
   	  endcase
   end 
     	
   //soft reset pulse
   always @(posedge clk, posedge rst)
     if(rst)
       rst_soft <= 1'b0;
     else if (rst_soft_en)
       rst_soft <= data_in[0];
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

