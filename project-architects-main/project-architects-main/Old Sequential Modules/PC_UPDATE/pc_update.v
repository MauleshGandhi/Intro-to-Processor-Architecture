module pc_update(PC, icode, cnd, valC, valM, valP, clk);

input [3:0] icode;
input cnd;
input signed [63:0] valC;
input signed [63:0] valM;
input signed [63:0] valP;
input clk;

output reg [63:0]PC;
always @(posedge clk)
    begin
        if (icode==4'h8)
            PC=valC;
        else if ((icode==4'h7)&&(cnd))
            PC=valC;
        else if (icode==4'h9)
            PC=valM;
        else
            PC=valP;
    end

endmodule