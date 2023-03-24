module and_64(out,a,b);
input [63:0] a,b;
output [63:0] out;

genvar i;

generate
    for(i = 0; i < 64; i=i+1) begin
        and A1(out[i],a[i],b[i]);
    end
endgenerate

endmodule