`timescale 1ns/1ps
module tb_full_adder_equiv;

  // DUT I/Os
  reg  a, b, cin;
  wire sum_naive, cout_naive;
  wire sum_opt,   cout_opt;

  // Instantiate both implementations
  full_adder_naive u_naive(.a(a), .b(b), .cin(cin), .sum(sum_naive), .cout(cout_naive));
  full_adder_opt   u_opt  (.a(a), .b(b), .cin(cin), .sum(sum_opt),   .cout(cout_opt));

  // VCD
  initial begin
    $dumpfile("waves_fa_equiv.vcd");
    $dumpvars(0, tb_full_adder_equiv);
  end

  // File-driven check
  integer fd, r, line, fails, total;
  integer ai, bi, scin, sumi, scout;   // read into integers
  reg [1023:0] linebuf;                // buffer for $fgets
  integer fret;                        // return value holder

  initial begin
    line = 0; fails = 0; total = 0;

    fd = $fopen("vectors/vectors_1bit.txt", "r");
    if (fd == 0) begin
      $display("ERROR: cannot open vectors/vectors_1bit.txt");
      $finish;
    end

    while (!$feof(fd)) begin
      r = $fscanf(fd, "%h %h %d %h %d\n", ai, bi, scin, sumi, scout);

      if (r == 5) begin
        // drive DUTs
        a   = ai[0];
        b   = bi[0];
        cin = scin[0];
        #1;

        // compare to expected
        if ((sum_naive !== (sumi & 1)) || (cout_naive !== (scout & 1))) begin
          $display("NAIVE MISMATCH line %0d: a=%0d b=%0d cin=%0d | got {%0d,%0d} exp {%0d,%0d}",
                   line, a, b, cin, cout_naive, sum_naive, (scout & 1), (sumi & 1));
          fails = fails + 1;
        end
        if ((sum_opt !== (sumi & 1)) || (cout_opt !== (scout & 1))) begin
          $display("OPT  MISMATCH line %0d: a=%0d b=%0d cin=%0d | got {%0d,%0d} exp {%0d,%0d}",
                   line, a, b, cin, cout_opt, sum_opt, (scout & 1), (sumi & 1));
          fails = fails + 1;
        end

        // cross-equivalence check
        if ((sum_naive !== sum_opt) || (cout_naive !== cout_opt)) begin
          $display("EQUIV FAIL line %0d: naive {%0d,%0d} != opt {%0d,%0d}",
                   line, cout_naive, sum_naive, cout_opt, sum_opt);
          fails = fails + 1;
        end

        total = total + 1;
      end
      else begin
        // malformed/blank line: consume the rest and keep going
        fret = $fgets(linebuf, fd);
      end

      line = line + 1;
    end

    $fclose(fd);

    if (fails == 0)
      $display("FULL ADDER EQUIV PASS: %0d vectors OK.", total);
    else
      $display("FULL ADDER EQUIV FAIL: %0d/%0d mismatches.", fails, total);

    #5 $finish;
  end
endmodule
