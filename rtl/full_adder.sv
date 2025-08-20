module full_adder(input logic x, y, cin, output logic s, cout);
  logic s1, c1, c2;
  half_adder ha1(.x(x),  .y(y),   .s(s1), .c(c1));
  half_adder ha2(.x(s1), .y(cin), .s(s),  .c(c2));
  assign cout = c1 | c2;
endmodule