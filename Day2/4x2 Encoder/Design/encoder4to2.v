`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 10:47:17
// Design Name: 
// Module Name: encoder4to2
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


module encoder4to2(
input [3:0]d,output reg [1:0]b
    );
    always@(*)
        begin
        case(d)
            0001:b=2'b00;
            0010:b=2'b00;
            0100:b=2'b00;
            1000:b=2'b00;
        endcase
        end
endmodule
