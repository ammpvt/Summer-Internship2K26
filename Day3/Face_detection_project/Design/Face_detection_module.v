`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 14:54:12
// Design Name: 
// Module Name: Face_detection_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Face_detection_module(
    input [7:0] P_in,     
    input clk,rst,fifo_full,      
    output reg [7:0] P_out, 
    output reg wrenabler  
);
    
    always @(posedge clk) 
    begin 
        if (rst) begin
           P_out<=8'h00;
           wrenabler<=0;
        end else if (fifo_full) 
        begin
             wrenabler<= 0;
        end else begin   
            P_out<=P_in;
            wrenabler<=1;
        end   
    end 
endmodule
