module F_regs(F_predPC,F_stall,predict_PC,clk);

input F_stall;
input [63:0] predict_PC;
input clk;

reg [63:0] F_predPC1;
output wire [63:0] F_predPC;
 

initial
begin
    F_predPC1=421;
end

always@(posedge clk & !F_stall)
begin
    F_predPC1 <= predict_PC;  
end

assign F_predPC=F_predPC1;

endmodule