`timescale 1ns/1ps

`define TIMER_DATA       (`UART_ADDR_W'd0)
`define TIMER_RESET (`UART_ADDR_W'd1)


module time_counter #(parameter   COUNTER_WIDTH = 32)
   (
    input                 rst, //Count reset.
    input                  clk,
    input                 addr,
    input                 enable,
    input [COUNTER_WIDTH-1:0]		  data_in,
    output reg            ready,
    output [COUNTER_WIDTH-1:0] data_out
    );

   reg [COUNTER_WIDTH-1:0]         counter;
   
   // reset
   wire                              rst_int;
   reg                               rst_soft;
   reg                               rst_soft_en;
   
   //soft reset pulse
   always @(posedge clk, posedge rst)
     if(rst)
       rst_soft <= 1'b0;
     else if (rst_soft_en)
       rst_soft <= data_in[0];
     else
       rst_soft <= 1'b0;

   always @* begin
   	rst_soft_en = 1'b0;
   	if(enable)
   		case (addr)
   			`TIMER_DATA:;
   			`TIMER_RESET: rst_soft_en = 1'b1;
   			default:;
   		endcase
   end
   	
   
   // cpu interface ready signal
   always @(posedge clk, posedge rst)
     if(rst)
       ready <= 1'b0;
     else 
       ready <= enable;
       
   assign rst_int = rst | rst_soft;
   assign data_out = counter;
       
   always @ (posedge clk, posedge rst_int)
     if (rst_int) begin
        counter   <= 0; 
     end else begin
        counter   <= counter + 1'b1;
     end
   
endmodule

