module Decode(valA,valB,rA,rB,icode);

input [3:0]rA,rB,icode;
output wire [63:0]valA,valB;

reg [63:0]rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14;
/////////////// TO BE REMOVED     USE irmovq to put values in it
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

wire [3:0]srcA,srcB;

assign srcA = (icode==4'd2 | icode==4'd4 | icode==4'd6 | icode==4'ha) ? rA : (icode==4'h9 | icode==4'hb) ? 4'h4 : 4'hf;
assign srcB = (icode==4'h4 | icode==4'h5 | icode==4'h6) ? rB : (icode==4'h2) ? 4'h0 : (icode==4'd8 | icode==4'd9 | icode==4'd10 | icode==4'd11) ? 4'h4 : 4'hf;

assign valA = (srcA==0)?rax:(srcA==1)?rcx:(srcA==2)?rdx:(srcA==3)?rbx:(srcA==4)?rsp:(srcA==5)?rbp:(srcA==6)?rsi:(srcA==7)?rdi:(srcA==8)?r8:(srcA==9)?r9:(srcA==10)?r10:(srcA==11)?r11:(srcA==12)?r12:(srcA==13)?r13:(srcA==14)?r14:64'h0;
assign valB = (srcB==0)?rax:(srcB==1)?rcx:(srcB==2)?rdx:(srcB==3)?rbx:(srcB==4)?rsp:(srcB==5)?rbp:(srcB==6)?rsi:(srcB==7)?rdi:(srcB==8)?r8:(srcB==9)?r9:(srcB==10)?r10:(srcB==11)?r11:(srcB==12)?r12:(srcB==13)?r13:(srcB==14)?r14:64'h0;
endmodule
