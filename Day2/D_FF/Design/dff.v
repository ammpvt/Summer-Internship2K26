`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 13:43:59
// Design Name: 
// Module Name: dff
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


module dff(
    input d, rst, clk, 
    output reg q, 
    output reg qbar
);
    
    always @(posedge clk or posedge rst) begin 
        if (rst) begin
         q <= 1'b0;
           qbar <= 1'b1;
        end else begin
            q <= d;
           qbar <= ~d;
        end
    end
endmodule
