module tb_Decode_WriteBack_Pipe();

reg [3:0] f_stat;
reg [3:0] f_icode,f_ifun;
reg [3:0] f_rA,f_rB;
reg [63:0] f_valC,f_valP;
reg D_bubble,D_stall;
reg clk;

reg [3:0] e_dstE;
reg [63:0] e_valE;
reg [3:0] M_dstM,M_dstE;
reg [63:0] m_valM,M_valE;

reg [3:0] m_stat;
reg [3:0] m_icode;
reg [63:0] m_valE;
reg [3:0] m_dstE,m_dstM;
reg W_stall;

wire [3:0] D_stat;
wire [3:0] D_icode,D_ifun;
wire [3:0] D_rA,D_rB;
wire [63:0] D_valC,D_valP;
wire [3:0] W_dstE,W_dstM;
wire [63:0] W_valE,W_valM;

wire [3:0] W_stat;
wire [3:0] W_icode;

wire [3:0] d_stat;
wire [3:0] d_icode,d_ifun;
wire [63:0] d_valC,d_valA,d_valB;
wire [3:0] d_dstE,d_dstM,d_srcA,d_srcB;

D_regs tb_D_regs(D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_bubble,D_stall,f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,clk);
W_regs tb_W_regs(W_stat,W_icode,W_valE,W_valM,W_dstE,W_dstM,W_stall,m_stat,m_icode,m_valE,m_valM,m_dstE,m_dstM,clk);

Decode_WriteBack_Pipe tb_Decode_WriteBack_Pipe(d_stat,d_icode,d_ifun,d_valC,d_valA,d_valB,d_dstE,d_dstM,d_srcA,d_srcB,
D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,
W_valE,W_dstE,W_valM,W_dstM,
m_valM,M_dstM,M_valE,M_dstE,
e_valE,e_dstE,clk);

initial
begin
    $dumpfile("Decode_WriteBack_Pipe.vcd");
    $dumpvars(0,tb_Decode_WriteBack_Pipe);
    $monitor("time =%0t ,clk=%b ,f_stat=%b  ,f_icode=%h ,f_ifun=%h  ,f_rA=%h    ,f_rB=%h    ,f_valC=%d  ,f_valP=%d  ,D_bubble=%b    ,D_stall=%b ,D_stat=%b  ,D_icode=%h ,D_ifun=%h  ,D_rA=%h    ,D_rB=%h    ,D_valC=%d  ,d_stat=%b  ,d_icode=%h ,d_ifun=%h  ,d_valC=%d  ,d_valA=%d  ,d_valB=%d  ,d_dstE=%h  ,d_dstM=%h  ,d_srcA=%h  ,d_srcB=%h\n ",$time,clk,f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,D_bubble,D_stall,D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,d_stat,d_icode,d_ifun,d_valC,d_valA,d_valB,d_dstE,d_dstM,d_srcA,d_srcB);

    m_stat=4'b1000; m_icode=4'h1; m_valE=64'd78;m_dstE=4'h3;m_dstM=4'h7;M_dstM=4'hf; M_dstE=4'hf;e_dstE=4'hf;m_dstE=4'hf;m_dstM=4'hf;

    #5 clk <=0;
    #5 clk<=~clk;
    #5 f_icode<=4'h3; f_ifun=4'h0;f_rA<=4'h1;    f_rB<=4'h8; f_stat=4'b1000; f_valC=64'd109;f_valP=64'd427;clk<=~clk;    
    #5 clk<=~clk;
    #5 f_icode<=4'h6; f_ifun=4'h0;f_rA<=4'h6;    f_rB<=4'h8; f_stat=4'b1000; f_valC=64'd45;f_valP=64'd450;clk<=~clk; D_bubble=1; D_stall=0;   
    #5 clk<=~clk;
    #5 f_icode<=4'h6; f_ifun=4'h9;f_rA<=4'h8;    f_rB<=4'h8; f_stat=4'b1001; f_valC=64'd45;f_valP=64'd450;clk<=~clk;    

    $finish;
end
endmodule