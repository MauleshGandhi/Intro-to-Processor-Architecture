module tb_Execute_Pipe();

reg [3:0] d_stat;
reg [3:0] d_icode;
reg [3:0] d_ifun;
reg [63:0] d_valC;
reg [63:0] d_valA;
reg [63:0] d_valB;
reg [3:0] d_dstE;
reg [3:0] d_dstM;
reg [3:0] d_srcA;
reg [3:0] d_srcB;
reg [3:0] W_stat;
reg [3:0] m_stat;
reg clk; 
reg E_bubble;

wire [3:0] e_stat;
wire [3:0] e_icode;
wire e_Cnd;
wire [63:0] e_valE;
wire [63:0] e_valA;
wire [3:0] e_dstE;
wire [3:0] e_dstM;
wire [3:0] E_icode;
wire [3:0] E_dstM;

Execute_Pipe tb_Execute_Pipe(E_icode,E_dstM,e_stat,e_icode,e_Cnd,e_valE,e_valA,e_dstE,e_dstM,d_stat,d_icode,d_ifun,d_valC,d_valA,d_valB,d_dstE,d_dstM,d_srcA,d_srcB,W_stat,m_stat,clk,E_bubble);


initial
begin
    $dumpfile("Execute_Pipe.vcd");
    $dumpvars(0,tb_Execute_Pipe);
    $monitor("time=%0t , e_stat=%d , e_icode=%d , e_Cnd=%d , e_valE=%d , e_valA=%d , e_dstE%d , e_dstM=%d",$time,e_stat,e_icode,e_Cnd,e_valE,e_valA,e_dstE,e_dstM);
    clk=0;
    d_stat=4'b1000;
    d_icode=6;
    d_ifun=1;
    d_valC=0;
    d_valA=5;
    d_valB=5;
    d_dstE=2;
    d_dstM=0;
    d_srcA=0;
    d_srcB=0;
    W_stat=4'b1000;
    m_stat=4'b1000;
    E_bubble=0;
    #5;
    clk=~clk;
    #5;
    d_stat=4'b1000; d_icode=7; d_ifun=1; clk=~clk;
    #5;
    clk=~clk;
    #5;
    d_stat=0;   clk=~clk;
    #5; clk=~clk;
    

    $finish;
end

endmodule