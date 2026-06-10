`timescale 1ns / 1ps

module FIFO(
    input clk,
    input rst,
    input wrenb,
    input rdenb,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output full,
    output empty
);
    reg [7:0] mem [7:0];
    reg [3:0] wr_ptr;
    reg [3:0] rd_ptr; //3 bit il ninn 4 bit aaki
    
    assign empty = (wr_ptr == rd_ptr) && !wrenb;
    assign full = (wr_ptr[3] != rd_ptr[3] && wr_ptr[2:0] == rd_ptr[2:0]);
    
    integer i;
    
    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 8; i = i + 1) begin
                mem[i] <= 0;
            end
            wr_ptr <= 0;
            rd_ptr <= 0;
            data_out <= 0;
        end else begin
            // Write 
            if (wrenb && !full) begin
                mem[wr_ptr[2:0]] <= data_in;
                wr_ptr <= wr_ptr + 1;
            end
            
            
            if (rdenb && !empty) begin 
                // Bypass memory when reading and writing simultaneously to an empty FIFO
                if (wrenb && (wr_ptr == rd_ptr)) begin
                    data_out <= data_in;
                end else begin
                    data_out <= mem[rd_ptr[2:0]];
                end
                rd_ptr <= rd_ptr + 1;
            end
        end
    end
endmodule