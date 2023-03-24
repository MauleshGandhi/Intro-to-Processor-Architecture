`include "mux4x1.v"
`include "adder_64.v"
`include "subtract_64.v"
`include "and_64.v"
`include "xor_64.v"
`include "full_adder.v"

module execute(cnd,CC,valE,icode,ifun,valA,valB,valC);

input [3:0] icode;
input [3:0] ifun;
input signed [63:0] valA;
input signed [63:0] valB;
input signed [63:0] valC;

output signed [63:0] valE;
output cnd;
output reg [2:0]CC; // ZF SF OF

wire signed [63:0] aluA;
wire signed [63:0] aluB;
wire set_cc;
wire [1:0] alufun;

//set cc
assign set_cc = (icode==4'h6);

//alu A
assign aluA = ((icode==4'h2)||(icode==4'h6)) ? valA : ((icode==4'h3)||(icode==4'h4)||(icode==4'h5)) ? valC : ((icode==4'h8)||(icode==4'ha)) ? -64'h8 : ((icode==4'h9)||(icode==4'hb)) ? 64'h8 : 64'h0;

//alu B
assign aluB = valB;

//alufun
assign alufun = (icode==4'h6) ? ifun[1:0] : 0;

                //ALU

wire [63:0]valE0,valE1,valE2,valE3;

adder_64 add(valE0,aluA,aluB);
subtract_64 subtract(valE1,aluA,aluB);
and_64 and1(valE2,aluA,aluB);
xor_64 xor1(valE3,aluA,aluB); 
	
genvar i;

generate
	for(i=0;i<64;i=i+1)
	begin
		mux4x1 mux4(alufun[0],alufun[1],valE0[i],valE1[i],valE2[i],valE3[i],valE[i]);
	end
endgenerate

                //cond
assign cnd = ((icode==4'h2)||(icode==4'h7)) ? (ifun==4'h0) ? 1 : ((ifun==4'h1)&&((CC[1]^CC[0])||CC[2])) ? 1 : ((ifun==4'h2)&&(CC[1]^CC[0])) ? 1 : ((ifun==4'h3)&&(CC[2])) ? 1 : ((ifun==4'h4)&&(!CC[2])) ? 1 : ((ifun==4'h5)&&(!(CC[1]^CC[0]))) ? 1 : ((ifun==4'h6)&&(!(CC[1]^CC[0])&&(!CC[2]))) ? 1 : 0 : 0;

// always @(set_cc)
// begin
//     CC[2]=(valE==63'h0);
//     CC[1]=(valE<63'h0);
//     CC[0]=((valE[63]!=0 == aluA[63]==0) && (aluA[63]==0 == aluB[63]==0));
// end

always@(*)
    begin
        if(set_cc)
            begin
                CC[2]=(valE==63'h0);
                CC[1]=(valE[63]==1);
                CC[0]=((valE[63]!=0 == aluA[63]==0) && (aluA[63]==0 == aluB[63]==0));
            end

                //Cond

        // if ((icode==4'h2)||(icode==4'h7))
        //     begin
        //         if (ifun==4'h0)             //xx
        //             cnd=1;
        //         else if (ifun==4'h1)        //le
        //             begin
        //                 if((CC[1]^CC[0])||CC[2])
        //                     cnd=1;                      //(sf^of)||zf
        //                 else
        //                     cnd=0;
        //             end
        //         else if (ifun==4'h2)        //l
        //             begin
        //                 if((CC[1]^CC[0]))
        //                     cnd=1;
        //                 else
        //                     cnd=0;                      //sf^of
        //             end
        //         else if (ifun==4'h3)        //e
        //             begin
        //                 if(CC[2])
        //                     cnd=1;                      //zf
        //                 else
        //                     cnd=0;
        //             end
        //         else if (ifun==4'h4)        //ne
        //             begin
        //                 if(!CC[2])                      //!zf
        //                     cnd=1;
        //                 else
        //                     cnd=0;    
        //             end
        //         else if (ifun==4'h5)        //ge
        //             begin
        //                 if(!(CC[1]^CC[0]))                      //!(sf^of)
        //                     cnd=1;
        //                 else
        //                     cnd=0;    
        //             end
        //         else if (ifun==4'h6)        //g
        //             begin
        //                 if((!(CC[1]^CC[0]))&&(!CC[2]))          //!(sf^of)&&!(zf)
        //                     cnd=1;
        //                 else
        //                     cnd=0;
        //             end
        //     end
    end

endmodule

