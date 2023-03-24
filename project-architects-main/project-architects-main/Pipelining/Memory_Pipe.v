module Memory_Pipe(m_stat,m_icode,m_valE,m_valM,m_dstE,m_dstM,M_stat,M_icode,M_Cnd,M_valE,M_valA,M_dstE,M_dstM);

input [3:0] M_stat;
input [3:0] M_icode;
input M_Cnd;
input [63:0] M_valE;
input [63:0] M_valA;
input [3:0] M_dstE;
input [3:0] M_dstM;

output wire [3:0] m_stat;
output wire [3:0] m_icode;
output wire [63:0] m_valE;
output wire [63:0] m_valM;
output wire [3:0] m_dstE;
output wire [3:0] m_dstM;

reg [7:0]mem[1023:0];               //1kB memory
wire read,write;
wire [63:0]MemAddr;

assign m_icode=M_icode;
assign m_valE=M_valE;
assign m_dstE=M_dstE;
assign m_dstM=M_dstM;

assign read  = (M_icode==4'h5  ||  M_icode==4'h9  ||  M_icode==4'hb);
assign write = (M_icode==4'h4  ||  M_icode==4'h8  ||  M_icode==4'ha);

assign MemAddr=(M_icode==4'h4  ||  M_icode==4'h5  ||  M_icode==4'h8  ||  M_icode==4'ha)?M_valE:M_valA;

assign m_stat[0]=M_stat[0];
assign m_stat[1] =((MemAddr>1023)|M_stat[1]);       //dmem_error
assign m_stat[2]=M_stat[2];
assign m_stat[3]=!(M_stat[2]|M_stat[1]|M_stat[0]|(MemAddr>1023));

assign m_valM[7 : 0] = (read&(m_stat[3]))?mem[MemAddr+7]:8'h0;
assign m_valM[15: 8] = (read&(m_stat[3]))?mem[MemAddr+6]:8'h0;
assign m_valM[23:16] = (read&(m_stat[3]))?mem[MemAddr+5]:8'h0;
assign m_valM[31:24] = (read&(m_stat[3]))?mem[MemAddr+4]:8'h0;
assign m_valM[39:32] = (read&(m_stat[3]))?mem[MemAddr+3]:8'h0;
assign m_valM[47:40] = (read&(m_stat[3]))?mem[MemAddr+2]:8'h0;
assign m_valM[55:48] = (read&(m_stat[3]))?mem[MemAddr+1]:8'h0;
assign m_valM[63:56] = (read&(m_stat[3]))?mem[MemAddr+0]:8'h0;

always @(*)
    begin
        if(write&(m_stat[3]))
        begin
        mem[MemAddr+7]<=M_valA[7:0];
        mem[MemAddr+6]<=M_valA[15:8];
        mem[MemAddr+5]<=M_valA[23:16];
        mem[MemAddr+4]<=M_valA[31:24];
        mem[MemAddr+3]<=M_valA[39:32];
        mem[MemAddr+2]<=M_valA[47:40];
        mem[MemAddr+1]<=M_valA[55:48];
        mem[MemAddr+0]<=M_valA[63:56];
        end
    end

endmodule