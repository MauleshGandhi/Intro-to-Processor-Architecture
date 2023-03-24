module tb_xor();
    reg [63:0]a,b;
    integer i;
    wire [63:0]XOR;
    xor_64 tb_xor(XOR,a,b);
    initial
    begin
        $dumpfile("xor_64.vcd");
        $dumpvars(0,tb_xor);
        $monitor("time =%0t ,\na   = %b ,\nb   = %b ,\nXOR = %b\n",$time,a,b,XOR);

        a=(1<<64)-1;    b=(1<<64)-1;    #5
        a=64'b10101010101010101010101010101010101010101010101010101010101;    b=a<<1;   #5
        a=64'd12548000; b=64'd1012545;   #5
        a=64'd45687895; b=-64'd12548796; #5
        a=-64'd558855;  b=-64'd55996688; #5

        $finish;
end 
endmodule