`include "./Arithmatic_logic/mux4x1.v"
`include "./Arithmatic_logic/adder_64.v"
`include "./Arithmatic_logic/subtract_64.v"
`include "./Arithmatic_logic/and_64.v"
`include "./Arithmatic_logic/xor_64.v"
`include "./Arithmatic_logic/full_adder.v"

module Execute_Pipe(E_icode1,E_dstM1,e_stat,e_icode,e_Cnd1,e_valE,e_valA,e_dstE,e_dstM,d_stat,d_icode,d_ifun,d_valC,d_valA,d_valB,d_dstE,d_dstM,d_srcA,d_srcB,W_stat,m_stat,clk,E_bubble);

input [3:0] d_stat;
input [3:0] d_icode;
input [3:0] d_ifun;
input [63:0] d_valC;
input [63:0] d_valA;
input [63:0] d_valB;
input [3:0] d_dstE;
input [3:0] d_dstM;
input [3:0] d_srcA;
input [3:0] d_srcB;
input [3:0] W_stat;
input [3:0] m_stat;
input clk; 
input E_bubble;

output wire [3:0] e_stat;
output wire [3:0] e_icode;
output wire [63:0] e_valE;
output wire [63:0] e_valA;
output wire [3:0] e_dstE;
output wire [3:0] e_dstM;
output wire [3:0] E_dstM1;
output wire [3:0] E_icode1;
output wire e_Cnd1;             //?? reg or wire??

wire signed [63:0] aluA;
wire signed [63:0] aluB;
wire set_cc;
wire [1:0] alufun;
wire dest_E;
wire E_bubble;

reg [3:0] CC;
reg e_Cnd;
reg [3:0] E_icode;
reg [3:0] E_dstM;
reg [3:0] E_stat;
reg [3:0] E_ifun;
reg [63:0] E_valC;
reg [63:0] E_valA;
reg [63:0] E_valB;
reg [3:0] E_dstE;
reg [3:0] E_srcA;
reg [3:0] E_srcB;

initial
begin
    CC=0;
    e_Cnd<=0;
    E_icode=1;
    E_stat=8;
    E_ifun=0;
    E_valC=0;
    E_valA=0;
    E_valB=0;
    E_dstE=0;
    E_dstM=0;
    E_srcA=0;
    E_srcB=0;
end


always@(posedge clk)                                    //update reg E
  begin  
    if (!E_bubble)  
      begin
        E_stat<=d_stat;
        E_icode<=d_icode;
        E_ifun<=d_ifun;
        E_valC<=d_valC;
        E_valA=d_valA;
        E_valB=d_valB;
        E_dstE=d_dstE;
        E_dstM=d_dstM;
        E_srcA=d_srcA;
        E_srcB=d_srcB;
      end
    else
      begin
        E_stat<=4'b1000;
        E_icode<=1;
        E_ifun<=0;
        E_valC<=0;
        E_valA<=0;
        E_valB<=0;
        E_dstE<=0;
        E_dstM<=0;
        E_srcA<=0;
        E_srcB<=0;
      end
  end

assign E_dstM1 = E_dstM;
assign E_icode1 = E_icode;
assign e_Cnd1 = e_Cnd;

assign e_stat=E_stat;
assign e_icode=E_icode;
assign e_valA=E_valA;
assign e_dstM=E_dstM;
//dst E
//set e_dstE to E_dstE based on icode  and e_Cnd
assign e_dstE=(e_icode==2&&e_Cnd==0) ? 4'hf : E_dstE;

//set cc
assign set_cc = ((E_icode==4'h6)&&(m_stat==4'b1000)&&(W_stat==4'b1000));          //only setcc if normal operation

//alu A
assign aluA = ((E_icode==4'h2)||(E_icode==4'h6)) ? E_valA : ((E_icode==4'h3)||(E_icode==4'h4)||(E_icode==4'h5)) ? E_valC : ((E_icode==4'h8)||(E_icode==4'ha)) ? -64'h8 : ((E_icode==4'h9)||(E_icode==4'hb)) ? 64'h8 : 64'h0;

//alu B
assign aluB = (E_icode==4'h4| E_icode==5| E_icode==6| E_icode==8| E_icode==9|E_icode==4'ha|E_icode==4'hb)?E_valB:0;

//alufun
assign alufun = (E_icode==4'h6) ? E_ifun[1:0] : 0;

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
		mux4x1 mux4(alufun[0],alufun[1],valE0[i],valE1[i],valE2[i],valE3[i],e_valE[i]);
	end
endgenerate

always@(*)
    begin
                    //Cond
        if ((E_icode==4'h2)||(E_icode==4'h7))
        begin
            if (E_ifun==4'h0)             //xx
                e_Cnd<=1;
            else if (E_ifun==4'h1)        //le
            begin
                if((CC[1]^CC[0])||CC[2])
                    e_Cnd<=1;                      //(sf^of)||zf
                else
                    e_Cnd<=0;
            end
            else if (E_ifun==4'h2)        //l
            begin
                if((CC[1]^CC[0]))
                    e_Cnd<=1;
                else
                    e_Cnd<=0;                      //sf^of
            end
            else if (E_ifun==4'h3)        //e
            begin
                if(CC[2])
                    e_Cnd<=1;                      //zf
                else
                    e_Cnd<=0;
            end
            else if (E_ifun==4'h4)        //ne
            begin
                if(!CC[2])                      //!zf
                    e_Cnd<=1;
                else
                    e_Cnd<=0;    
            end
            else if (E_ifun==4'h5)        //ge
            begin
                if(!(CC[1]^CC[0]))                      //!(sf^of)
                    e_Cnd<=1;
                else
                    e_Cnd<=0;    
            end
            else if (E_ifun==4'h6)        //g
            begin
                if((!(CC[1]^CC[0]))&&(!CC[2]))          //!(sf^of)&&!(zf)
                    e_Cnd<=1;
                else
                    e_Cnd<=0;
            end
        end
    end
            //CC

always @(negedge clk)

    if(set_cc)
        begin
            CC[2]<=(e_valE==63'd0);
            CC[1]<=(e_valE<63'd0);
            CC[0]<=((e_valE[63]!=0 == aluA[63]==0) && (aluA[63]==0 == aluB[63]==0));
        end

//E_bubble


endmodule