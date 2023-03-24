module adder_64(sum,a,b);

input [63:0]a,b;


output [63:0]sum;

wire [64:0]ci ;
assign ci[0]=0;

genvar i;
generate
    for(i=0;i<64;i=i+1)
    begin
        full_adder FA(sum[i],ci[i+1],a[i],b[i],ci[i]);
    end
endgenerate

endmodule