module tb_Memory_Pipe();

reg [3:0] e_stat;
reg [3:0] e_icode;
reg e_Cnd;
reg [63:0] e_valE;
reg [63:0] e_valA;
reg [3:0] e_dstE;
reg [3:0] e_dstM;
reg M_bubble;
reg clk;

wire [3:0] m_stat;
wire [3:0] m_icode;
wire [63:0] m_valE;
wire [63:0] m_valM;
wire [3:0] m_dstE;
wire [3:0] m_dstM;
wire [3:0] M_stat;
wire [3:0] M_icode;
wire M_Cnd;
wire [63:0] M_valE;
wire [63:0] M_valA;
wire [3:0] M_dstE;
wire [3:0] M_dstM;

M_regs tb_Memory_regs(M_stat,M_icode,M_Cnd,M_valE,M_valA,M_dstE,M_dstM,e_stat,e_icode,e_Cnd,e_valE,e_valA,e_dstE,e_dstM,M_bubble,clk);
Memory_Pipe tb_Memory_Pipe(m_stat,m_icode,m_valE,m_valM,m_dstE,m_dstM,M_stat,M_icode,M_Cnd,M_valE,M_valA,M_dstE,M_dstM);

initial
begin
    $dumpfile("Memory_Pipe.vcd");
    $dumpvars(0,tb_Memory_Pipe);
    $monitor("time=%0t , m_stat=%b , m_icode=%d , m_valE=%d , m_valM=%d , m_dstE=%d , m_dstM=%d\n",$time,m_stat,m_icode,m_valE,m_valM,m_dstE,m_dstM);
    #5;
    clk=0;  e_stat=4'b1000;   e_icode=0;  e_Cnd=0;    e_valE=10;   e_valA=20;   e_dstE=10;   e_dstM=9; M_bubble=0;   #5;
    clk=~clk;   #5;
    clk=~clk;   e_icode=1; e_valE=64'd2000;   e_valA=64'd49; #5;
    clk=~clk;   #5;
    clk=~clk;   e_icode=4'h5;  e_valE=64'd100;  #5;
    clk=~clk;   #5;
    clk=~clk;   e_icode=4'h4;  e_valE=64'd200;   e_valA=64'd109;  #5;clk=~clk;
end

endmodule