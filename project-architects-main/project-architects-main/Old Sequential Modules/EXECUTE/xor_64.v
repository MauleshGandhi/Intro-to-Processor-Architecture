module xor_64(XOR,a,b);
input [63:0] a,b;
output [63:0] XOR;

  genvar i;

generate
    for(i = 0; i < 64; i=i+1) begin
        xor X1(XOR[i],a[i],b[i]);
    end
endgenerate

endmodule
