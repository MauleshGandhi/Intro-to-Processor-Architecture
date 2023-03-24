`include "mux4x1.v"
`include "adder_64.v"
`include "subtract_64.v"
`include "and_64.v"
`include "xor_64.v"
`include "full_adder.v"

module alu_64(valE,CC,alu_fun,aluA,aluB);
input [1:0]alu_fun;
input [63:0]aluA,aluB;

output [63:0]valE;
output reg [2:0]CC; // ZF SF OF

wire [63:0]valE0,valE1,valE2,valE3;

adder_64 add(valE0,aluA,aluB);
subtract_64 subtract(valE1,aluA,aluB);
and_64 and1(valE2,aluA,aluB);
xor_64 xor1(valE3,aluA,aluB); 
	
genvar i;

generate
	for(i=0;i<64;i=i+1)
	begin
		mux4x1 mux4(alu_fun[0],alu_fun[1],valE0[i],valE1[i],valE2[i],valE3[i],valE[i]);
	end
endgenerate

always @(*)
begin
	 
CC[2]=!(|valE);

CC[1]=(valE[63]==1'b1);

CC[0]=((valE[63]!=0 == aluA[63]==0) && (aluA[63]==0 == aluB[63]==0));

end
endmodule
