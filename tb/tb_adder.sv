`timescale 1ns/1ps
module tb_adder;
  // DUTs
  localparam int N1 = 1;
  localparam int N2 = 8;

  // N=1
  logic [N1-1:0] a1, b1;
  logic          cin1, cout1;
  logic [N1-1:0] sum1;
  adder_nbit #(.N(N1)) dut1 (.a(a1), .b(b1), .cin(cin1), .sum(sum1), .cout(cout1));

  // N=8
  logic [N2-1:0] a2, b2;
  logic          cin2, cout2;
  logic [N2-1:0] sum2;
  adder_nbit #(.N(N2)) dut2 (.a(a2), .b(b2), .cin(cin2), .sum(sum2), .cout(cout2));

  // Waves
  initial begin
    $dumpfile("waves.vcd");
    $dumpvars(0, tb_adder);
  end

  // ---- simple, non-parameterized checks ----
  task automatic check1(
      input logic a, b, cin,
      input logic sum, input logic cout);
    logic [1:0] gold;
    begin
      gold = a + b + cin;
      if ({cout, sum} !== gold)
        $error("N=1 mismatch: a=%0d b=%0d cin=%0d -> got {%0d,%0d} expected %0d",
               a, b, cin, cout, sum, gold);
    end
  endtask

  task automatic check8(
      input logic [7:0] a, b, input logic cin,
      input logic [7:0] sum, input logic cout);
    logic [8:0] gold;
    begin
      gold = a + b + cin;
      if ({cout, sum} !== gold)
        $error("N=8 mismatch: a=%0h b=%0h cin=%0d -> got {%0d,%0h} expected %0h",
               a, b, cin, cout, sum, gold);
    end
  endtask

  // Stimulus
  initial begin
    // Exhaustive for N=1
    for (int aa = 0; aa < 2; aa++)
      for (int bb = 0; bb < 2; bb++)
        for (int cc = 0; cc < 2; cc++) begin
          a1 = aa[0]; b1 = bb[0]; cin1 = cc[0];
          #1;
          check1(a1, b1, cin1, sum1, cout1);
        end
    $display("Exhaustive N=1 PASS.");

    // Random for N=8
    for (int i = 0; i < 1000; i++) begin
      a2 = $urandom();
      b2 = $urandom();
      cin2 = $urandom_range(0,1);
      #1;
      check8(a2, b2, cin2, sum2, cout2);
    end
    $display("Randomized N=8 PASS.");
    #5 $finish;
  end
endmodule
