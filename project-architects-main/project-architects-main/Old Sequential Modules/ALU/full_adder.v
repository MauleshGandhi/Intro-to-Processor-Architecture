module full_adder(s,cout,a,b,cin);
input a,b,cin;
output s,cout;

wire s0,c0,c1;

xor x1(s0,a,b);
xor x2(s,s0,cin);

and a1(c0,a,b);
and a2(c1,s0,cin);

or o1(cout,c1,c0);

endmodule
