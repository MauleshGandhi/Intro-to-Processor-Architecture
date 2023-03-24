
`include"fetch.v"
`include"Decode_WriteBack.v"
`include"Execute.v"
`include"Memory.v"
`include"PC_Update.v"

module Processor;
  reg clk;
  reg [3:0]stat; // |AOK|HLT|ADR|INS
  reg [63:0]PC;
  wire [63:0]PC_updated;
  wire [2:0]CC; // ZF SF OF

  wire [3:0] icode;
  wire [3:0] ifun;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire [63:0] valC;
  wire [63:0] valP;
  wire instr_valid;
  wire imem_error;
  wire halt;

  wire [63:0] valA;
  wire [63:0] valB;
  wire [63:0] valE;
  wire [63:0] valM;
  wire cnd;

  wire dmem_error;

  fetch fetch(icode,ifun,imem_error,instr_valid,halt,rA,rB,valC,valP,PC,clk);
  Decode_WriteBack Decode_WriteBack(valA,valB,clk,icode,rA,rB,Cnd,valE,valM);
  execute execute(cnd,CC,valE,icode,ifun,valA,valB,valC,clk);
  Memory Memory(valM,dmem_error,icode,valE,valA,valP);
  PC_Update PC_Update(PC_updated, icode, cnd, valC, valM, valP, clk);

  always #5 clk=~clk;

  initial 
  begin
    $dumpfile("Processor.vcd");
    $dumpvars(0,Processor);
    $monitor("clk=%d PC=%d icode=%d ifun=%d rA=%d rB=%d valA=%d valB=%d valC=%d valE=%d valM=%d instr_valid=%b imem_error=%b cnd=%b halt=%b dmem_err=%b\n",clk,PC,icode,ifun,rA,rB,valA,valB,valC,valE,valM,instr_valid,imem_error,cnd,stat[2],dmem_error);
    stat=4'b1000;
    clk=1;
    PC=64'd421;///////////////////////////////////////////////////
  end 
  
  always @*
  PC=PC_updated;

  always @(posedge clk or negedge clk)
  begin
      if(!instr_valid)
      stat=4'b0001;
      else if(halt)
      stat=4'b0100;
      else if(imem_error|dmem_error)
      stat=4'b0010;
  end
    
  always@*
  begin
     if(stat[3]==1'b0)
     $finish;
  end

endmodule
   
// only issue when we use push/pop in between of call and ret



