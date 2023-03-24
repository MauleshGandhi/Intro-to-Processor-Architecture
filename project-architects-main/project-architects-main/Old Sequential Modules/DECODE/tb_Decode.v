module tb_Decode();

reg [3:0]rA,rB,icode;
wire [63:0]valA,valB;
Decode tb_Decode(valA,valB,rA,rB,icode);
initial
begin
    $dumpfile("Decode.vcd");
    $dumpvars(0,tb_Decode);
    $monitor("time =%0t ,\nrA   = %b ,\nrB   = %b ,\nicode = %b\n ,\nvalA = %b\n ,\nvalB = %b\n",$time,rA,rB,icode,valA,valB);

    rA=4'h0; rB=4'h1; icode=4'h0;    #5 
    rA=4'h1; rB=4'h2; icode=4'h1;    #5
    rA=4'h2; rB=4'h3; icode=4'h2;    #5
    rA=4'h3; rB=4'h4; icode=4'h3;    #5
    rA=4'h4; rB=4'h5; icode=4'h4;    #5
    rA=4'h5; rB=4'h6; icode=4'h5;    #5
    rA=4'h6; rB=4'h7; icode=4'h6;    #5
    rA=4'h7; rB=4'h8; icode=4'h7;    #5
    rA=4'h8; rB=4'h9; icode=4'h8;    #5
    rA=4'h9; rB=4'ha; icode=4'h9;    #5
    rA=4'ha; rB=4'hb; icode=4'ha;    #5
    rA=4'hb; rB=4'hc; icode=4'hb;    #5

    $finish;
end
endmodule
 
    