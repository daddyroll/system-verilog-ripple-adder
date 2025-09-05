`timescale 1ns/1ps
module full_adder_naive(
    input a, b, cin,
    output sum, cout
);

wire s1, c1, c2;

// reuse your half_adder
half_adder ha0(.x(a), .y(b), .s(s1), .c(c1));
half_adder ha1(.x(s1), .y(cin), .s(sum), .c(c2));

assign cout = c1 | c2;
endmodule
