module tb_alu();
    reg [63:0]a,b;
    reg [1:0]mode;

    wire [63:0]out;
    wire [2:0]CC;
    alu_64 tb_alu(out,CC,mode,a,b);
    initial
    begin
        $dumpfile("alu_64.vcd");
        $dumpvars(0,tb_alu);
        $monitor("time =%0t ,\nmode = %b,\na   = %b ,\nb   = %b ,\nout = %b ,\nCC = %b",$time,mode,a,b,out,CC);

        mode=2'd0;
        a=64'd54;    b=64'd46;    #5                    //adding two +ves
        a=-64'd1;    b=64'd10;    #5                    //1st -ve and 2nd +ve
        a=64'd1000; b=-64'd15;    #5                    //1st +ve and 2nd -ve
        a=-64'd455; b=-64'd45;    #5                    //both -ve
        a=1<<63;      b=1<<63;    #5                    //-ve overflow
        a=1<<62;      b=1<<62;    #5                    //+ve overflow
        
        mode=2'd1;
        a=64'd54;    b=64'd46;    #5                    //adding two +ves
        a=-64'd1;    b=64'd10;    #5                    //1st -ve and 2nd +ve
        a=64'd1000; b=-64'd15;    #5                    //1st +ve and 2nd -ve
        a=-64'd455; b=-64'd45;    #5                    //both -ve
        a=1<<63;      b='b1<<62;  #5                    //-ve overflow
        a=1<<62;      b='b11<<62; #5                    //+ve overflow
        
        mode=2'd2;
        a=(1<<64)-1;    b=(1<<64)-1;    #5
        a=64'b10101010101010101010101010101010101010101010101010101010101;    b=a<<1;   #5
        a=64'd12548000; b=64'd1012545;   #5
        a=64'd45687895; b=-64'd12548796; #5
        a=-64'd558855;  b=-64'd55996688; #5

        mode=2'd3;
        a=(1<<64)-1;    b=(1<<64)-1;    #5
        a=64'b10101010101010101010101010101010101010101010101010101010101;    b=a<<1;   #5
        a=64'd12548000; b=64'd1012545;   #5
        a=64'd45687895; b=-64'd12548796; #5
        a=-64'd558855;  b=-64'd55996688; #5

        $finish;
        
end 
endmodule
