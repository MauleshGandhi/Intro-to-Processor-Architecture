module tb_fetch();

    reg [63:0] PC;
    reg clk;

    wire [3:0] icode;
    wire [3:0] ifun;
    wire [3:0] rA;
    wire [3:0] rB;
    wire [63:0] valC;
    wire [63:0] valP;
    wire imem_error;
    wire instr_valid;
    wire halt;

    fetch tb_fetch(icode,ifun,imem_error,instr_valid,halt,rA,rB,valC,valP,PC,clk);

    initial
    begin
        $dumpfile("fetch.vcd");
        $dumpvars(0,tb_fetch);
        $monitor("time =%0t , icode =%b , ifun =%b , rA =%b , rB =%b , valC =%d , valP =%d, imem_error =%b, instr_valid =%b, halt =%b",$time,icode,ifun,rA,rB,valC,valP,imem_error,instr_valid,halt);
        
        clk=0;      PC=64'd420; #5     
        clk=~clk;               #5
        clk=~clk;   PC=valP;    #5     
        clk=~clk;               #5
        clk=~clk;   PC=valP;    #5     
        clk=~clk;               #5
        clk=~clk;   PC=valP;    #5     
        clk=~clk;               #5
        clk=~clk;   PC=valP;    #5     
        clk=~clk;               #5

        $finish;
    end
endmodule