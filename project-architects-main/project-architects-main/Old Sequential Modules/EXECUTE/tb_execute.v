module tb_execute();

    reg [3:0] icode;
    reg [3:0] ifun;
    reg signed [63:0] valA;
    reg signed [63:0] valB;
    reg signed [63:0] valC;

    wire cnd;
    wire [2:0] CC;
    wire signed [63:0] valE;

    execute tb_execute(cnd,CC,valE,icode,ifun,valA,valB,valC);

    initial
        begin
            $dumpfile("execute.vcd");
            $dumpvars(0,tb_execute);
            $monitor("time =%0t , cnd=%b , CC=%b , valE=%d, valA=%d, valB=%d, valC=%d",$time,cnd,CC,valE,valA,valB,valC);
            #5
            icode = 4'h6;
            ifun = 4'h0;
            valA = 1<<63;
            valB = 1<<63;
            valC = 64'h2;
            #5
            icode = 4'h7;
            ifun = 4'h2;
            valA = 64'h5;
            valB = 64'he;
            valC = 64'h2;
            #5
            ifun = 4'h3;
            valC = 64'h1;
            #5
            $finish;
        end
    
endmodule