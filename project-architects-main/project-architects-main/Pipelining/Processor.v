`include "F_regs.v"
`include "Fetch_Pipe.v"
`include "D_regs.v"
`include "Decode_WriteBack_Pipe.v"
`include "W_regs.v"
`include "Execute_Pipe.v"
`include "M_regs.v"
`include "Memory_Pipe.v"
`include "PCL.v"

module Processor();
reg clk;

wire [63:0] F_predPC;

wire [3:0] f_stat;                 //AOK,instr_invalid,imem_error,halt
wire [3:0] f_icode,f_ifun,f_rA,f_rB;
wire [63:0] f_valC,f_valP;
wire [63:0] predict_PC;

wire [3:0] D_stat;
wire [3:0] D_icode,D_ifun;
wire [3:0] D_rA,D_rB;
wire [63:0] D_valC,D_valP;

wire [3:0] d_stat;
wire [3:0] d_icode,d_ifun;
wire [63:0] d_valC,d_valA,d_valB;
wire [3:0] d_dstE,d_dstM,d_srcA,d_srcB;

wire [3:0] e_stat;
wire [3:0] e_icode;
wire [63:0] e_valE;
wire [63:0] e_valA;
wire [3:0] e_dstE;
wire [3:0] e_dstM;
wire [3:0] E_icode,E_dstM;
wire e_Cnd;

wire [3:0] m_stat;
wire [3:0] m_icode;
wire [63:0] m_valE;
wire [63:0] m_valM;
wire [3:0] m_dstE;
wire [3:0] m_dstM;

wire W_stall;
wire M_bubble;
wire set_cc;
wire E_bubble;
wire D_bubble,D_stall;
wire F_stall;

reg [3:0] M_stat;
reg [3:0] M_icode;
reg M_Cnd;
reg [63:0] M_valE;
reg [63:0] M_valA;
reg [3:0] M_dstE;
reg [3:0] M_dstM;

reg [3:0] W_stat;
reg [3:0] W_icode;
reg [63:0] W_valE,W_valM;
reg [3:0] W_dstE,W_dstM;


F_regs F_regs(F_predPC,F_stall,predict_PC,clk);
Fetch_Pipe Fetch_Pipe(f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,predict_PC,M_icode,M_Cnd,M_valA,W_icode,W_valM,F_predPC);
D_regs D_regs(D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_bubble,D_stall,f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,clk);
Decode_WriteBack_Pipe Decode_WriteBack_Pipe(d_stat,d_icode,d_ifun,d_valC,d_valA,d_valB,d_dstE,d_dstM,d_srcA,d_srcB,
                        D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,
                        W_valE,W_dstE,W_valM,W_dstM,
                        m_valM,M_dstM,M_valE,M_dstE,
                        e_valE,e_dstE,clk);
Execute_Pipe Execute_Pipe(E_icode,E_dstM,e_stat,e_icode,e_Cnd,e_valE,e_valA,e_dstE,e_dstM,d_stat,d_icode,d_ifun,d_valC,d_valA,d_valB,d_dstE,d_dstM,d_srcA,d_srcB,W_stat,m_stat,clk,E_bubble);
Memory_Pipe Memory_Pipe(m_stat,m_icode,m_valE,m_valM,m_dstE,m_dstM,M_stat,M_icode,M_Cnd,M_valE,M_valA,M_dstE,M_dstM);
PCL PCL(W_stall,M_bubble,set_cc,E_bubble,D_bubble,D_stall,F_stall,D_icode,d_srcA,d_srcB,E_icode,E_dstM,e_Cnd,M_icode,m_stat,W_stat);

initial
begin
    clk=0;
    $dumpfile("Processor.vcd");
    $dumpvars(0,Processor);
    $monitor("time=%0t, clk=%b,\nF_predPC=%d,F_stall=%b,\n\nf_stat=%b,f_icode=%h,f_ifun=%h,f_rA=%h,f_rB=%h,f_valC=%d,D_valP=%d,\n\nD_stat=%b,D_icode=%h,D_ifun=%h,D_rA=%h,D_rB=%h,D_valC=%d,D_valP=%d,D_stall=%b,D_bubble=%b,\n\nE_icode1=%h,e_icode=%h,d_stat=%b,d_icode=%h,d_ifun=%h,d_valC=%d,d_valA=%d,d_valB=%d,d_dstE=%h,d_dstM=%h,d_srcA=%h,d_srcB=%h,E_bubble=%b\n\nM_stat=%b,M_icode=%h,M_Cnd=%b,M_valE=%d,M_valA=%d,M_dstE=%h,M_dstM=%h,M_bubble=%b,\n\nW_stat=%b,W_icode=%h,W_valE=%d,W_valM=%d,W_dstE=%h,W_dstM=%h,W_stall=%b \n",$time,clk,F_predPC,F_stall,
    f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,
    D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_stall,D_bubble,
    E_icode,e_icode,d_stat,d_icode,d_ifun,d_valC,d_valA,d_valB,d_dstE,d_dstM,d_srcA,d_srcB,E_bubble,
    M_stat,M_icode,M_Cnd,M_valE,M_valA,M_dstE,M_dstM,M_bubble,
    W_stat,W_icode,W_valE,W_valM,W_dstE,W_dstM,W_stall);

    M_stat=8;
    M_icode=1;
    M_Cnd=0;
    M_valE=0;
    M_valA=0;
    M_dstE=0;
    M_dstM=0;   

    W_stat=8;
    W_icode=1;
    W_valE=0;
    W_valM=0;
    W_dstE=0;
    W_dstM=0; 

end

always @(posedge clk) 
begin
    if (M_bubble == 1) 
    begin
            M_stat <= 1;
            M_icode <= 1;
            M_Cnd <= 0;
            M_valE <= 0;
            M_valA <= 0;
            M_dstE <= 0;
            M_dstM <= 0;
    end
        else 
        begin
            M_stat <= e_stat;
            M_icode <= e_icode;
            M_Cnd <= e_Cnd;
            M_valE <= e_valE;
            M_valA <= e_valA;
            M_dstE <= e_dstE;
            M_dstM <= e_dstM;
        end
end

always@(posedge clk && !W_stall)
begin
    W_stat<=m_stat;
    W_icode<=m_icode;
    W_valE<=m_valE;
    W_valM<=m_valM;
    W_dstE<=m_dstE;
    W_dstM<=m_dstM;
end
    
    always #5 clk=~clk;
always@*
begin
    if(W_stat[0] | W_stat[1] | W_stat[2])
    $finish;
end
endmodule