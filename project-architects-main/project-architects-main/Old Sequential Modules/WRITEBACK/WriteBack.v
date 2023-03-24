module WriteBack(valM,valE,rA,rB,icode,Cnd);

input [63:0]valM,valE;
input [3:0]rA,rB,icode;
input Cnd;

reg [63:0]rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14;

wire [3:0]dstE,dstM;

assign dstE = (icode==4'h2 ||icode==4'h3 ||icode==4'h6) ? rB :(icode==4'h8 ||icode==4'h9 ||icode==4'ha ||icode==4'hb) ? 4'h4 : 4'hf;
assign dstM = (icode==4'h5 ||icode==4'hb) ? rA:4'hf;
always @(*)
begin
    
    if(dstE != 4'hf)
    begin
    case(dstE)
    4'h0 : rax= valE;
    4'h1 : rcx= valE;
    4'h2 : rdx= valE;
    4'h3 : rbx= valE;
    4'h4 : rsp= valE;
    4'h5 : rbp= valE;
    4'h6 : rsi= valE;
    4'h7 : rdi= valE;
    4'h8 : r8 = valE;
    4'h9 : r9 = valE;
    4'ha : r10= valE;
    4'hb : r11= valE;
    4'hc : r12= valE;
    4'hd : r13= valE;
    4'he : r14= valE;
    endcase
    end

    if(dstM != 4'hf)
    begin
    case(dstM)
    4'h0 : rax=valM;
    4'h1 : rcx=valM;
    4'h2 : rdx=valM;
    4'h3 : rbx=valM;
    4'h4 : rsp=valM;
    4'h5 : rbp=valM;
    4'h6 : rsi=valM;
    4'h7 : rdi=valM;
    4'h8 : r8 =valM;
    4'h9 : r9 =valM;
    4'ha : r10=valM;
    4'hb : r11=valM;
    4'hc : r12=valM;
    4'hd : r13=valM;
    4'he : r14=valM;
    endcase
    end
end

endmodule
    

