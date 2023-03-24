module tb_Decode_WriteBack();

reg [3:0]rA,rB,icode;
reg clk,Cnd;
reg [63:0]valE,valM;

wire [63:0]valA,valB;
Decode_WriteBack tb_Decode_WriteBack(valA,valB,clk,icode,rA,rB,Cnd,valE,valM);
initial
begin
    $dumpfile("Decode_WriteBack.vcd");
    $dumpvars(0,tb_Decode_WriteBack);
    $monitor("time =%0t ,\nrA   = %b ,\nrB   = %b ,\nicode = %b ,\nCnd = %b ,\nValE = %d ,\nvalM = %d ,\nvalA = %d ,\nvalB = %d\n",$time,rA,rB,icode,Cnd,valE,valM,valA,valB);

    #5 clk <=0;
    #5 clk<=~clk;
    #5 icode<=4'h3; rA<=4'hf;    rB<=4'h8;    Cnd<=1;  valE<=64'd43;    valM<=64'd63;   clk<=~clk;    
    #5 clk<=~clk;
    #5 clk<=~clk;    icode<=4'h4; rA<=4'h8;    rB<=4'ha;            

    $finish;
end
endmodule
 
    