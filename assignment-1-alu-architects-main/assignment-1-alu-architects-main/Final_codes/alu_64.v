`include "mux4x1.v"
`include "adder_64.v"
`include "subtract_64.v"
`include "and_64.v"
`include "xor_64.v"
`include "full_adder.v"

module alu_64(out,mode,a,b);
input [1:0]mode;
input [63:0]a,b;

output [63:0]out;

wire [63:0]out0,out1,out2,out3;

adder_64 add(out0,a,b);
subtract_64 subtract(out1,a,b);
and_64 and1(out2,a,b);
xor_64 xor1(out3,a,b); 
	
genvar i;

generate
	for(i=0;i<64;i=i+1)
	begin
		mux4x1 mux4(mode[0],mode[1],out0[i],out1[i],out2[i],out3[i],out[i]);
	end
endgenerate

endmodule