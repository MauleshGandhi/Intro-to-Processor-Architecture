module tb_adder();
    reg signed [63:0]a,b;

    integer i=1;
    wire [63:0]sum;
    adder_64 tb_adder(sum,a,b);
    initial
    begin
        $dumpfile("adder_64.vcd");
        $dumpvars(0,tb_adder);
        $monitor("time =%0t ,\na   = %b ,\nb   = %b ,\nsum = %b\n",$time,a,b,sum);

        a=64'd54;    b=64'd46;    #5                    //adding two +ves
        a=-64'd1;    b=64'd10;    #5                    //1st -ve and 2nd +ve
        a=64'd1000; b=-64'd15;    #5                    //1st +ve and 2nd -ve
        a=-64'd455; b=-64'd45;    #5                    //both -ve
        a=1<<63;      b=1<<63;    #5                    //-ve overflow
        a=1<<62;      b=1<<62;    #5                    //+ve overflow
        
        $finish;
        
end 
endmodule