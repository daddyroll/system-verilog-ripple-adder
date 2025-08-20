module adder_nbit #(parameter int N=4)
( input  logic [N-1:0] a, b,
  input  logic         cin,
  output logic [N-1:0] sum,
  output logic         cout );
  logic [N:0] c; assign c[0] = cin;
  genvar i;
  generate
    for (i=0;i<N;i++) begin : g
      full_adder fa(.x(a[i]), .y(b[i]), .cin(c[i]), .s(sum[i]), .cout(c[i+1]));
    end
  endgenerate
  assign cout = c[N];
endmodule