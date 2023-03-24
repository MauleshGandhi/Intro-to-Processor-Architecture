module tb_subtract();
    reg [63:0]a,b;

    integer i;
    wire [63:0]sub;
    subtract_64 tb_subtract(sub,a,b);
    initial
    begin
        $dumpfile("subtract_64.vcd");
        $dumpvars(0,tb_subtract);
        $monitor("time =%0t ,\na   = %b ,\nb   = %b ,\nsub = %b\n",$time,a,b,sub);

        a=64'd54;    b=64'd46;    #5                    //adding two +ves
        a=-64'd1;    b=64'd10;    #5                    //1st -ve and 2nd +ve
        a=64'd1000; b=-64'd15;    #5                    //1st +ve and 2nd -ve
        a=-64'd455; b=-64'd45;    #5                    //both -ve
        a=1<<63;      b='b1<<62;  #5                    //-ve overflow
        a=1<<62;      b='b11<<62; #5                    //+ve overflow
        

        $finish;
        
end 
endmodule