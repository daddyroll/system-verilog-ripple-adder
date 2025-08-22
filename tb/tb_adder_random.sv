`timescale 1ns/1ps   // FIX: add backtick for the directive
module tb_adder_file;

  // ---- parameters ----
  parameter N = 8;                 // match your vectors

  // ---- DUT signals (Verilog-2005 types) ----
  reg  [N-1:0] a, b;
  reg          cin;
  wire [N-1:0] sum;
  wire         cout;

  // ---- DUT ----
  adder_nbit #(.N(N)) dut (
    .a(a), .b(b), .cin(cin), .sum(sum), .cout(cout)
  );

  // ---- VCD ----
  initial begin
    $dumpfile("waves_file.vcd");
    $dumpvars(0, tb_adder_file);
  end

  // ---- file driven check (Icarus-friendly) ----
  integer fd, r, line, fails, total;
  integer ai, bi, sumi, scin, scout;
  reg [8*256:1] linebuf;           // FIX: buffer to consume bad/partial lines

  initial begin
    line  = 0;
    fails = 0;
    total = 0;

    fd = $fopen("vectors/vectors_8bit.txt", "r");
    if (fd == 0) begin
      $display("ERROR: cannot open vectors/vectors_8bit.txt");
      $finish;
    end

    // each line: A_hex B_hex cin_dec SUM_hex cout_dec
    while (!$feof(fd)) begin
      r = $fscanf(fd, "%h %h %d %h %d\n", ai, bi, scin, sumi, scout); // FIX: include \n

      if (r == 5) begin
        line = line + 1;

        // drive DUT; implicit truncation to N bits (no integer slicing)
        a   = ai;
        b   = bi;
        cin = scin;

        #1;  // settle

        // mask SUM to N bits using integer arithmetic (no vectors/functions)
        if ( (sum !== (sumi & ((1<<N)-1))) || (cout !== (scout & 1)) ) begin
          $display("MISMATCH line %0d: a=%h b=%h cin=%0d -> got {%0d,%h} exp {%0d,%h}",
                   line, a, b, cin, cout, sum, (scout & 1), (sumi & ((1<<N)-1)));
          fails = fails + 1;
        end

        total = total + 1;
      end
      else begin
        // FIX: Verilog-2005 has no 'continue'—eat the rest of the line safely
        $fgets(linebuf, fd);
      end
    end

    $fclose(fd);

    if (fails == 0)
      $display("FILE TB PASS (N=%0d): %0d vectors OK.", N, total);
    else
      $display("FILE TB FAIL (N=%0d): %0d/%0d mismatches.", N, fails, total);

    #5 $finish;
  end

endmodule
