module tb_Fetch_Pipe();
reg clk;                       //64 bit progf_ram counter
reg [3:0] M_icode;
reg M_Cnd;
reg [63:0] M_valA;
reg [3:0] W_icode;
reg [63:0] W_valM;
reg F_stall;

wire [3:0] f_stat;                 //AOK,instr_invalid,imem_error,halt
wire [3:0] f_icode,f_ifun,f_rA,f_rB;
wire [63:0] f_valC,f_valP;
wire [63:0] predict_PC;
wire [63:0] F_predPC;

// always@*
// begin
//   F_predPC = F_predPC1;
//   predict_PC1 = predict_PC;
// end

Fetch_Pipe tb_Fetch_Pipe(f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,predict_PC,M_icode,M_Cnd,M_valA,W_icode,W_valM,F_predPC);
F_regs tb_Fetch_regs(F_predPC,F_stall,predict_PC,clk);

initial
begin
    $dumpfile("Fetch_Pipe.vcd");
    $dumpvars(0,tb_Fetch_Pipe);
    $monitor("time=%0t , f_valP=%d , f_stat=%d , f_icode=%d , f_ifun=%d , f_rA=%d , f_rB=%d , f_valC=%d, f_stat=%b,F_predPC=%d",$time,f_valP,f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_stat,F_predPC);
    clk=0;
    M_icode=1;
    M_Cnd=1;
    M_valA=0;
    W_icode=1;
    W_valM=0;
    F_stall=0;
end

always #5 clk=~clk;

always@(posedge clk or negedge clk)
  begin
     if(f_stat[3]==1'b0)
     $finish;
  end

endmodule