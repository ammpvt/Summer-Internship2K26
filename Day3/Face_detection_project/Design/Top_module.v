`timescale 1ns / 1ps

module Top_module(
    input clk,
    input rst,
    input [7:0] p_in,      
    output [7:0] p_out,    
    output full,           
    output empty
);
    wire [7:0] d1;         
    wire w1;               
    wire [7:0] d2;         
    wire r1;               
    
    Face_detection_module U1 (
        .P_in(p_in),
        .clk(clk),
        .rst(rst),
        .fifo_full(full),
        .P_out(d1),
        .wrenabler(w1)
    );
        
    FIFO U2 (
        .clk(clk),               
        .rst(rst),               
        .wrenb(w1),
        .rdenb(r1),
        .data_in(d1),
        .data_out(d2),                
        .full(full),
        .empty(empty)
    );    
    
    Data_Out_FSM fsm_inst (
        .clk(clk),               
        .rst(rst),               
        .empty_flag(empty),                
        .d_in(d2),
        .rdenabler(r1),                
        .d_out(p_out)              
    );
    
endmodule
