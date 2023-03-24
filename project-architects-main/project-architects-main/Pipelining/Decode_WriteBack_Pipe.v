module Decode_WriteBack_Pipe(d_stat,d_icode,d_ifun,d_valC,d_valA,d_valB,d_dstE,d_dstM,d_srcA,d_srcB,
D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,
W_valE,W_dstE,W_valM,W_dstM,
m_valM,M_dstM,M_valE,M_dstE,
e_valE,e_dstE,clk);

input [3:0] e_dstE;
input [63:0] e_valE;
input [3:0] M_dstM,M_dstE;
input [63:0] m_valM,M_valE;
input [3:0] W_dstE,W_dstM;
input [63:0] W_valE,W_valM;
input [3:0] D_stat;
input [3:0] D_icode,D_ifun;
input [3:0] D_rA,D_rB;
input [63:0] D_valC,D_valP;
input clk;

output wire [3:0] d_stat;
output wire [3:0] d_icode,d_ifun;
output wire [63:0] d_valC,d_valA,d_valB;
output wire [3:0] d_dstE,d_dstM,d_srcA,d_srcB;

wire [3:0] d_rvalA,d_rvalB;

reg [63:0]rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14;
wire [3:0] d_rA,d_rB;
wire [63:0] d_valP;
/////////////// TO BE REMOVED     USE irmovq to put values in it
// check STAT
initial 
begin
rax=64'h0;
rcx=64'h1;
rdx=64'h2;
rbx=64'h3;
rsp=64'h4;
rbp=64'h5;
rsi=64'h6;
rdi=64'h7;
r8 =64'h8;
r9 =64'h9;
r10=64'ha;
r11=64'hb;
r12=64'hc;
r13=64'hd;
r14=64'he;
end
/////////////////
assign d_stat = D_stat;
assign d_icode = D_icode;
assign d_ifun = D_ifun;
assign d_rA = D_rA;
assign d_rB = D_rB;
assign d_valC = D_valC;
assign d_valP = D_valP;

assign d_srcA = (d_icode==4'd2 | d_icode==4'd4 | d_icode==4'd6 | d_icode==4'ha) ? d_rA : (d_icode==4'h9 | d_icode==4'hb) ? 4'h4 : 4'hf;
assign d_srcB = (d_icode==4'h4 | d_icode==4'h5 | d_icode==4'h6) ? d_rB : (d_icode==4'd8 | d_icode==4'd9 | d_icode==4'd10 | d_icode==4'd11) ? 4'h4 : 4'hf;

assign d_rvalA = (d_srcA==0)?rax:(d_srcA==1)?rcx:(d_srcA==2)?rdx:(d_srcA==3)?rbx:(d_srcA==4)?rsp:(d_srcA==5)?rbp:(d_srcA==6)?rsi:(d_srcA==7)?rdi:(d_srcA==8)?r8:(d_srcA==9)?r9:(d_srcA==10)?r10:(d_srcA==11)?r11:(d_srcA==12)?r12:(d_srcA==13)?r13:(d_srcA==14)?r14:64'h0;
assign d_rvalB = (d_srcB==0)?rax:(d_srcB==1)?rcx:(d_srcB==2)?rdx:(d_srcB==3)?rbx:(d_srcB==4)?rsp:(d_srcB==5)?rbp:(d_srcB==6)?rsi:(d_srcB==7)?rdi:(d_srcB==8)?r8:(d_srcB==9)?r9:(d_srcB==10)?r10:(d_srcB==11)?r11:(d_srcB==12)?r12:(d_srcB==13)?r13:(d_srcB==14)?r14:64'h0;

//Forwarding
assign d_valA = (d_icode==4'h8)?d_valP:(d_srcA==e_dstE)?e_valE:(d_srcA==M_dstE)?M_valE:(d_srcA==M_dstM)?m_valM:(d_srcA==W_dstM)?W_valM:(d_srcA==W_dstE)?W_valE:d_rvalA;
assign d_valB = (d_srcB==e_dstE)?e_valE:(d_srcB==M_dstE)?M_valE:(d_srcB==M_dstM)?m_valM:(d_srcB==W_dstM)?W_valM:(d_srcB==W_dstE)?W_valE:d_rvalB;
////

assign d_dstE = (d_icode==4'h2 ||d_icode==4'h3 ||d_icode==4'h6) ? d_rB :(d_icode==4'h8 ||d_icode==4'h9 ||d_icode==4'ha ||d_icode==4'hb) ? 4'h4 : 4'hf;
assign d_dstM = (d_icode==4'h5 ||d_icode==4'hb) ? d_rA:4'hf;

always @(negedge clk)
begin
    
    if(W_dstE != 4'hf)
    begin
    case(W_dstE)
    4'h0 : rax<= W_valE;
    4'h1 : rcx<= W_valE;
    4'h2 : rdx<= W_valE;
    4'h3 : rbx<= W_valE;
    4'h4 : rsp<= W_valE;
    4'h5 : rbp<= W_valE;
    4'h6 : rsi<= W_valE;
    4'h7 : rdi<= W_valE;
    4'h8 : r8 <= W_valE;
    4'h9 : r9 <= W_valE;
    4'ha : r10<= W_valE;
    4'hb : r11<= W_valE;
    4'hc : r12<= W_valE;
    4'hd : r13<= W_valE;
    4'he : r14<= W_valE;
    endcase
    end

    if(W_dstM != 4'hf)
    begin
    case(W_dstM)
    4'h0 : rax<=W_valM;
    4'h1 : rcx<=W_valM;
    4'h2 : rdx<=W_valM;
    4'h3 : rbx<=W_valM;
    4'h4 : rsp<=W_valM;
    4'h5 : rbp<=W_valM;
    4'h6 : rsi<=W_valM;
    4'h7 : rdi<=W_valM;
    4'h8 : r8 <=W_valM;
    4'h9 : r9 <=W_valM;
    4'ha : r10<=W_valM;
    4'hb : r11<=W_valM;
    4'hc : r12<=W_valM;
    4'hd : r13<=W_valM;
    4'he : r14<=W_valM;
    endcase
    end
end

endmodule

