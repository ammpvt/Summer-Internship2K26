`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 16:14:39
// Design Name: 
// Module Name: Data_Out_FSM
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

module Data_Out_FSM (
    input clk,
    input rst,empty_flag,
    input [7:0] d_in,
    output reg rdenabler,
    output reg [7:0] d_out
);
    parameter IDLE   = 2'b00;
    parameter DELAY1 = 2'b01;
    parameter DELAY2 = 2'b10;
    reg [1:0] ps, ns;
//ps logic
    always @(posedge clk) begin
        if (rst) begin
           ps<=IDLE;
            d_out<= 8'h00;
        end else begin
            ps <=ns; 
            if (ps == DELAY2) begin
             d_out<= d_in;
          end
        end
    end
    // nest state logic
    always @(*) begin
        ns= ps;
        rdenabler=1'b0;

        case (ps)
            IDLE: begin
                if(empty_flag == 1'b0) begin
                rdenabler = 1'b1;   
                 ns = DELAY1;
   end else begin
                    rdenabler = 1'b0;
                    ns = IDLE;
                end
            end

            DELAY1: begin
                rdenabler = 1'b0;       
                ns= DELAY2;     
            end

            DELAY2: begin
                rdenabler = 1'b0;
       ns = IDLE;       
            end

            default: ns =IDLE;
        endcase
    end
endmodule


