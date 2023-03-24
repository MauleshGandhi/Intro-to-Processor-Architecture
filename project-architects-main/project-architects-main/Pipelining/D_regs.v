module D_regs(D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_bubble,D_stall,f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,clk);

input [3:0] f_stat;
input [3:0] f_icode,f_ifun;
input [3:0] f_rA,f_rB;
input [63:0] f_valC,f_valP;
input D_bubble,D_stall;
input clk;

output wire [3:0] D_stat;
output wire [3:0] D_icode,D_ifun;
output wire [3:0] D_rA,D_rB;
output wire [63:0] D_valC,D_valP;

reg [3:0] D_stat1;
reg [3:0] D_icode1,D_ifun1;
reg [3:0] D_rA1,D_rB1;
reg [63:0] D_valC1,D_valP1;

initial
begin
    D_stat1=8;
    D_icode1=1;
    D_ifun1=0;
    D_rA1=0;
    D_rB1=0;
    D_valC1=0;
    D_valP1=0;
end

assign D_stat = D_stat1;
assign D_icode = D_icode1;
assign D_ifun = D_ifun1;
assign D_rA = D_rA1;
assign D_rB = D_rB1;
assign D_valC = D_valC1;
assign D_valP = D_valP1;

always@(posedge clk && !D_stall)
begin
    if(D_bubble)
    begin
        D_stat1<=4'b1000;
        D_icode1<=4'h1;
        D_ifun1<=4'h0;
        D_rA1<=4'hf;
        D_rB1<=4'hf;
        D_valC1<=64'h0;
        D_valP1<=64'h0;
    end
    else
    begin
        D_stat1<=f_stat;
        D_icode1<=f_icode;
        D_ifun1<=f_ifun;
        D_rA1<=f_rA;
        D_rB1<=f_rB;
        D_valC1<=f_valC;
        D_valP1<=f_valP;
    end
end

endmodule