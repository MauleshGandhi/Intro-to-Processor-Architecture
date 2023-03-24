module W_regs(W_stat,W_icode,W_valE,W_valM,W_dstE,W_dstM,W_stall,m_stat,m_icode,m_valE,m_valM,m_dstE,m_dstM,clk);

input [3:0] m_stat;
input [3:0] m_icode;
input [63:0] m_valE,m_valM;
input [3:0] m_dstE,m_dstM;
input W_stall;
input clk;

output wire [3:0] W_stat;
output wire [3:0] W_icode;
output wire [63:0] W_valE,W_valM;
output wire [3:0] W_dstE,W_dstM;

reg [3:0] W_stat1;
reg [3:0] W_icode1;
reg [63:0] W_valE1,W_valM1;
reg [3:0] W_dstE1,W_dstM1;

initial
begin
    W_stat1=8;
    W_icode1=1;
    W_valE1=0;
    W_valM1=0;
    W_dstE1=0;
    W_dstM1=0;
end

assign W_stat = W_stat1;
assign W_icode = W_icode1;
assign W_valE = W_valE1;
assign W_valM = W_valM1;
assign W_dstE = W_dstE1;
assign W_dstM = W_dstM1;

always@(posedge clk && !W_stall)
begin
    W_stat1=m_stat;
    W_icode1=m_icode;
    W_valE1=m_valE;
    W_valM1=m_valM;
    W_dstE1=m_dstE;
    W_dstM1=m_dstM;
end

endmodule