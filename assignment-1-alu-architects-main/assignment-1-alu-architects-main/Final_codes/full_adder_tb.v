module full_adder_tb();
    reg a,b,cin;

    integer i;
    wire cout,s;

    full_adder full_adder_tb(s,cout,a,b,cin);
    initial
    begin
        $dumpfile("full_adder.vcd");
        $dumpvars(0,full_adder_tb);
        $monitor("time =%0t , a = %d , b = %d ,cin = %d ,sum = %d ,cout = %d",$time,a,b,cin,s,cout);

        a=1'b0;b=1'b0;cin=1'b0;#5
        a=1'b1;b=1'b1;#5
        a=1'b1;b=1'b0;#5

        $finish;

    end 
endmodule