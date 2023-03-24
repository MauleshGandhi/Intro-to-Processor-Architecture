module Memory(valM,stat,icode,valE,valA,valP,instr_valid,imem_error);

input imem_error,instr_valid;
input [3:0]icode;
input signed [63:0]valE,valA,valP;

output stat;  //what is stat
output wire [63:0] valM;

reg [7:0]mem[1023:0];//1kB memory

wire read,write,dmem_error;
wire [63:0]MemAddr,MemData;

assign read  = (icode==4'h5  ||  icode==4'h9  ||  icode==4'hb);
assign write = (icode==4'h4  ||  icode==4'h8  ||  icode==4'ha);

assign MemAddr=(icode==4'h4  ||  icode==4'h5  ||  icode==4'h8  ||  icode==4'ha)?valE:valA;
// MemAddr might have valA even when we dont have to do any read/write
assign MemData = (icode==4'h4  ||  icode==4'ha)?valA:valP;
//MemData might have valP even when we dont have to write anything
assign dmem_error =(MemAddr>1023);

assign valM[7 : 0] = (read&(~dmem_error))?mem[MemAddr  ]:8'h0;
assign valM[15: 8] = (read&(~dmem_error))?mem[MemAddr+1]:8'h0;
assign valM[23:16] = (read&(~dmem_error))?mem[MemAddr+2]:8'h0;
assign valM[31:24] = (read&(~dmem_error))?mem[MemAddr+3]:8'h0;
assign valM[39:32] = (read&(~dmem_error))?mem[MemAddr+4]:8'h0;
assign valM[47:40] = (read&(~dmem_error))?mem[MemAddr+5]:8'h0;
assign valM[55:48] = (read&(~dmem_error))?mem[MemAddr+6]:8'h0;
assign valM[63:56] = (read&(~dmem_error))?mem[MemAddr+7]:8'h0;

always @(*)
begin
    if(write&(~dmem_error))
    begin
    mem[MemAddr]  <=MemData[7:0];
    mem[MemAddr+1]<=MemData[15:8];
    mem[MemAddr+2]<=MemData[23:16];
    mem[MemAddr+3]<=MemData[31:24];
    mem[MemAddr+4]<=MemData[39:32];
    mem[MemAddr+5]<=MemData[47:40];
    mem[MemAddr+6]<=MemData[55:48];
    mem[MemAddr+7]<=MemData[63:56];
    end
end
endmodule
