`timescale 1ns/1ps
module full_adder_opt(
    input a, b, cin,
    output sum, cout
);

wire p; // propagate term
wire c1, c2;

assign p = a ^ b;
assign sum = p ^ cin;
assign c1 = a & b;
assign c2 = p & cin;
assign cout = c1 | c2;
endmodule

