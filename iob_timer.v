`timescale 1ns/1ps

`define TIMER_RESET (`UART_ADDR_W'd0)
`define TIMER_DATA_HIGH (`UART_ADDR_W'd1)
`define TIMER_DATA_LOW (`UART_ADDR_W'd2)


module iob_timer
   (
    input                      rst, //Count reset.
    input                      clk,
    input [1:0]                addr,
    input [31:0]			   data_in,
    output reg [31:0] 			   data_out,
    input                      valid,
    output reg                 ready
    );

   //counter
   reg [64:0]     counter;
   reg [31:0]	  tmp_reg;
   
   // reset
   wire                        rst_int;
   reg                         rst_soft;
   reg                         rst_soft_en;
   
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
   	if(valid)
   		case (addr)
   			`TIMER_DATA_HIGH: begin 
   				data_out = counter [63:32];
   				tmp_reg = counter [31:0];
   			end
   			`TIMER_DATA_LOW: data_out = tmp_reg;
   			`TIMER_RESET: rst_soft_en = 1'b1;
   			default:;
   		endcase
   end   	
   
   // cpu interface ready signal
   always @(posedge clk, posedge rst)
     if(rst)
       ready <= 1'b0;
     else 
       ready <= valid;
       
   assign rst_int = rst | rst_soft;
   
   //Cycles counter
   always @ (posedge clk, posedge rst_int)
     if (rst_int) begin
        counter   <= 0; 
     end else begin
        counter   <= counter + 1'b1;
     end
   
endmodule

