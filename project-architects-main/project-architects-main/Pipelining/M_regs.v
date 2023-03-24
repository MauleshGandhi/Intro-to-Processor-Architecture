module M_regs(M_stat,M_icode,M_Cnd,M_valE,M_valA,M_dstE,M_dstM,e_stat,e_icode,e_Cnd,e_valE,e_valA,e_dstE,e_dstM,M_bubble,clk);

input [3:0] e_stat;
input [3:0] e_icode;
input e_Cnd;
input [63:0] e_valE;
input [63:0] e_valA;
input [3:0] e_dstE;
input [3:0] e_dstM;
input M_bubble;
input clk;

reg [3:0] M_stat1;
reg [3:0] M_icode1;
reg M_Cnd1;
reg [63:0] M_valE1;
reg [63:0] M_valA1;
reg [3:0] M_dstE1;
reg [3:0] M_dstM1;

output wire [3:0] M_stat;
output wire [3:0] M_icode;
output wire M_Cnd;
output wire [63:0] M_valE;
output wire [63:0] M_valA;
output wire [3:0] M_dstE;
output wire [3:0] M_dstM;

initial
begin
    M_stat1=8;
    M_icode1=1;
    M_Cnd1=0;
    M_valE1=0;
    M_valA1=0;
    M_dstE1=0;
    M_dstM1=0;
end

assign M_stat=M_stat1;
assign M_icode=M_icode1;
assign M_Cnd=M_Cnd1;
assign M_valE=M_valE1;
assign M_valA=M_valA1;
assign M_dstE=M_dstE1;
assign M_dstM=M_dstM1;


always @(posedge clk)
    if (M_bubble)
        begin
            M_stat1=4'b1000;
            M_icode1=4'h1;
            M_Cnd1=0;
            M_valE1=0;
            M_valA1=0;
            M_dstE1=0;
            M_dstM1=0;
        end
    else
        begin
            M_stat1=e_stat;
            M_icode1=e_icode;
            M_Cnd1=e_Cnd;
            M_valE1=e_valE;
            M_valA1=e_valA;
            M_dstE1=e_dstE;
            M_dstM1=e_dstM;
        end


endmodule