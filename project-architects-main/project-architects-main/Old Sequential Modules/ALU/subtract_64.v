module subtract_64(sub,a,b);

input [63:0]a,b;

output [63:0]sub;

wire [64:0]ci,bi;

//assign b=~b;
assign ci[0]=1'b1;

genvar i;
generate
    for(i=0;i<64;i=i+1)
    begin
        not Not(bi[i],b[i]);
        full_adder FA(sub[i],ci[i+1],a[i],bi[i],ci[i]);
    end
endgenerate

endmodule
