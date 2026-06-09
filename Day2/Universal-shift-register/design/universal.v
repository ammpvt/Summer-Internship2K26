`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 14:53:49
// Design Name: 
// Module Name: universal
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


module universal(input clk,rst,sin,shift,load,input [1:0]mod,input [3:0]pin,output reg sout, output reg [3:0]pout
                    );
    reg [3:0]temp;
always @(posedge clk or posedge rst) begin
        if (rst) begin
         temp <= 4'b0000;
        end else begin
            case (mod)
                2'b00: begin
                    if (shift) begin
                    temp[2:0] <= temp[3:1];
                    temp[3]   <= sin;
                    end
                end
                2'b01: begin
                    if (shift) begin
                    temp[2:0] <= temp[3:1];
                    temp[3]   <= sin;
                    end
                end
                2'b10: begin
                    if (!shift) begin
                    temp <= pin;
                    end else begin
                    temp[2:0] <= temp[3:1];
                    temp[3]   <= 1'b0;
                    end
                end
                2'b11: begin
                    temp <= pin;
                end
                default: temp <= temp;
            endcase
    end
    end
    always @(*) begin
        sout = 1'b0;
        pout = 4'b0000;

        if (load) begin
            case (mod)
        2'b00: sout = temp[0];
        2'b01: pout = temp;
        2'b10: sout = temp[0];
        2'b11: pout = temp;
            endcase
        end
    end
endmodule
