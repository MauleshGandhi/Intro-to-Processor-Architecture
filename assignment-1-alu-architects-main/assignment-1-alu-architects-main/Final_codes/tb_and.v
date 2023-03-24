module tb_and();
    reg [63:0]a,b;
    integer i;
    wire [63:0]AND;
    and_64 tb_and(AND,a,b);
    initial
    begin
        $dumpfile("and_64.vcd");
        $dumpvars(0,tb_and);
        $monitor("time =%0t ,\na   = %b ,\nb   = %b ,\nAND = %b\n",$time,a,b,AND);

        a=(1<<64)-1;    b=(1<<64)-1;    #5
        a=64'b10101010101010101010101010101010101010101010101010101010101;    b=a<<1;   #5
        a=64'd12548000; b=64'd1012545;   #5
        a=64'd45687895; b=-64'd12548796; #5
        a=-64'd558855;  b=-64'd55996688; #5

        $finish;
end 
endmodule