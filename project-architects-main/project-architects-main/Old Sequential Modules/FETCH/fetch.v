module fetch(icode,ifun,imem_error,instr_valid,halt,rA,rB,valC,valP,PC,clk);

input clk;
input [63:0] PC;                        //64 bit program counter

output reg [3:0] icode;
output reg [3:0] ifun;
output reg [3:0] rA;
output reg [3:0] rB;
output reg [63:0] valC;
output reg [63:0] valP;
output reg imem_error;
output reg instr_valid;
output reg halt;

reg [7:0] instr_mem[1023:0];            //1kb instruction_memory
reg [79:0] instr;                       //instruction
reg need_reg_ids;
reg need_valC;

initial begin
                //initialize instr_mem

    instr_mem[420] = 8'h00;             //halt

    instr_mem[421] = 8'h10;             //nop
    
    instr_mem[422] = 8'h20;             //rrmov 
    instr_mem[423] = 8'h03;                 //rax rbx
    instr_mem[424] = 8'h21;             //cmovle
    instr_mem[425] = 8'h11;                 //rcx rcx **
    instr_mem[426] = 8'h22;             //cmovl
    instr_mem[427] = 8'hde;                 //r13 r14
    instr_mem[428] = 8'h23;             //cmove
    instr_mem[429] = 8'hff;                 //no_reg no_reg **
    instr_mem[430] = 8'h24;             //cmovne
    instr_mem[431] = 8'hf0;                 //no_reg rax **
    instr_mem[432] = 8'h25;             //cmovge
    instr_mem[433] = 8'h1f;                 //rcx no_reg **
    instr_mem[434] = 8'h26;             //cmovg
    instr_mem[435] = 8'h12;                 //rcx rdx
    
    instr_mem[436] = 8'h30;             //irmov
    instr_mem[437] = 8'h02;                 //rax rcx
    instr_mem[438] = 8'h00;             
    instr_mem[439] = 8'h00;
    instr_mem[440] = 8'h00;
    instr_mem[441] = 8'h00;
    instr_mem[442] = 8'h00;
    instr_mem[443] = 8'h00;
    instr_mem[444] = 8'h00;
    instr_mem[445] = 8'h13;                 //19

    instr_mem[446] = 8'h40;             //rmmov
    instr_mem[447] = 8'h01;                 //rax rcx
    instr_mem[448] = 8'h00;
    instr_mem[449] = 8'h00;
    instr_mem[450] = 8'h00;
    instr_mem[451] = 8'h00;
    instr_mem[452] = 8'h00;
    instr_mem[453] = 8'h00;
    instr_mem[454] = 8'h00;
    instr_mem[455] = 8'hfa;                 //250

    instr_mem[456] = 8'h50;             //mrmov
    instr_mem[457] = 8'h01;                 //rax rcx
    instr_mem[458] = 8'h00;
    instr_mem[459] = 8'h00;
    instr_mem[460] = 8'h00;
    instr_mem[461] = 8'h00;
    instr_mem[462] = 8'h00;
    instr_mem[463] = 8'h00;
    instr_mem[464] = 8'h00;
    instr_mem[465] = 8'h08;                 //8

    instr_mem[466] = 8'h60;             //OP add
    instr_mem[467] = 8'h02;                 //rax rdx
    instr_mem[468] = 8'h61;             //OP subtract
    instr_mem[469] = 8'h01;                 //rax rcx
    instr_mem[470] = 8'h62;             //OP and
    instr_mem[471] = 8'h03;                 //rax rbx
    instr_mem[472] = 8'h63;             //OP exor
    instr_mem[473] = 8'h13;                 //rcx rbx

    instr_mem[474] = 8'h70;             //jmp
    instr_mem[475] = 8'h00;
    instr_mem[476] = 8'h00;
    instr_mem[477] = 8'h00;
    instr_mem[478] = 8'h00;
    instr_mem[479] = 8'h00;
    instr_mem[480] = 8'h00;
    instr_mem[481] = 8'h00;
    instr_mem[482] = 8'hd8;                 //216
    instr_mem[483] = 8'h71;             //jle
    instr_mem[484] = 8'h00;
    instr_mem[485] = 8'h00;
    instr_mem[486] = 8'h00;
    instr_mem[487] = 8'h00;
    instr_mem[488] = 8'h00;
    instr_mem[489] = 8'h00;
    instr_mem[490] = 8'h00;
    instr_mem[491] = 8'hff;                 //255
    instr_mem[492] = 8'h72;             //jl
    instr_mem[493] = 8'h00;
    instr_mem[494] = 8'h00;
    instr_mem[495] = 8'h00;
    instr_mem[496] = 8'h00;
    instr_mem[497] = 8'h00;
    instr_mem[498] = 8'h00;
    instr_mem[499] = 8'h00;
    instr_mem[500] = 8'h0f;                 //15
    instr_mem[501] = 8'h73;             //je
    instr_mem[502] = 8'h00;
    instr_mem[503] = 8'h00;
    instr_mem[504] = 8'h00;
    instr_mem[505] = 8'h00;
    instr_mem[506] = 8'h00;
    instr_mem[507] = 8'h00;
    instr_mem[508] = 8'h00;
    instr_mem[509] = 8'h2d;                 //45
    instr_mem[510] = 8'h74;             //jne
    instr_mem[511] = 8'h00;
    instr_mem[512] = 8'h00;
    instr_mem[513] = 8'h00;
    instr_mem[514] = 8'h00;
    instr_mem[515] = 8'h00;
    instr_mem[516] = 8'h00;
    instr_mem[517] = 8'h00;
    instr_mem[518] = 8'h01;                 //1
    instr_mem[519] = 8'h75;             //jge
    instr_mem[520] = 8'h00;
    instr_mem[521] = 8'h00;
    instr_mem[522] = 8'h00;
    instr_mem[523] = 8'h00;
    instr_mem[524] = 8'h00;
    instr_mem[525] = 8'h00;
    instr_mem[526] = 8'h00;
    instr_mem[527] = 8'h84;                 //132
    instr_mem[528] = 8'h76;             //jg
    instr_mem[529] = 8'h00;
    instr_mem[530] = 8'h00;
    instr_mem[531] = 8'h00;
    instr_mem[532] = 8'h00;
    instr_mem[533] = 8'h00;
    instr_mem[534] = 8'h00;
    instr_mem[535] = 8'h00;
    instr_mem[536] = 8'he3;                 //227

    instr_mem[537] = 8'h80;             //call
    instr_mem[538] = 8'h00;
    instr_mem[539] = 8'h00;
    instr_mem[540] = 8'h00;
    instr_mem[541] = 8'h00;
    instr_mem[542] = 8'h00;
    instr_mem[543] = 8'h00;
    instr_mem[544] = 8'h00;
    instr_mem[545] = 8'h48;                 //72

    instr_mem[546] = 8'h90;             //ret

    instr_mem[547] = 8'ha0;             //pushq
    instr_mem[548] = 8'h90;                 //r9

    instr_mem[549] = 8'hb0;             //popq
    instr_mem[550] = 8'h20;                 //rdx

    //initialize halt
    halt = 0;
end

always @(posedge clk)
begin
  
                //reading first 10 bytes from PC 
    instr[79:72] = instr_mem[PC];
    instr[71:64] = instr_mem[PC+1];
    instr[63:56] = instr_mem[PC+2];
    instr[55:48] = instr_mem[PC+3];
    instr[47:40] = instr_mem[PC+4];
    instr[39:32] = instr_mem[PC+5];
    instr[31:24] = instr_mem[PC+6];
    instr[23:16] = instr_mem[PC+7];
    instr[15:8]  = instr_mem[PC+8];
    instr[7:0]   = instr_mem[PC+9];   
    

                //imem_error

    imem_error = 0;
    if (PC>1023)                            //since instr_mem is 1kb
        begin
            imem_error = 1;
        end

                //split

    icode[3:0] = instr[79:76];
    ifun[3:0] = instr[75:72];


                //align

    if (icode==4'h0)                  
        begin
            rA[3:0] = 4'hf;
            rB[3:0] = 4'hf;
            valC = 64'h0;
            need_reg_ids = 0;
            need_valC = 0;
            instr_valid = 1; 
            halt = 1;
        end
    else if (icode==4'h1)                  
        begin
            rA[3:0] = 4'hf;
            rB[3:0] = 4'hf;
            valC = 64'h0;
            need_reg_ids = 0;
            need_valC = 0;
            instr_valid = 1; 
        end
    else if (icode==4'h2)               
        begin
            if ((ifun>=4'h0)&&(ifun<4'h7))
                begin
                    rA[3:0] = instr[71:68];
                    rB[3:0] = instr[67:64];
                    valC[63:0] = 64'h0;
                    need_reg_ids = 1;
                    need_valC = 0;
                    instr_valid = 1;
                end
            else
                begin
                    need_reg_ids = 1;
                    need_valC = 0;
                    instr_valid = 0;
                end
        end
    else if ((icode==4'h3)||(icode==4'h4)||(icode==4'h5))            
        begin
                rA[3:0] = instr[71:68];
                rB[3:0] = instr[67:64];
                valC[63:0] = instr[63:0];
                need_reg_ids = 1;
                need_valC = 1;
                instr_valid = 1;
        end
    else if (icode==4'h6)               
        begin
            if ((ifun>=4'h0)&&(ifun<4'h4))
                begin
                    rA[3:0] = instr[71:68];
                    rB[3:0] = instr[67:64];
                    valC[63:0] = 64'h0;
                    need_reg_ids = 1;
                    need_valC = 0;
                    instr_valid = 1;
                end
            else
                begin
                    need_reg_ids = 1;
                    need_valC = 0;
                    instr_valid = 0;
                end
        end
    else if (icode==4'h7)                        
        begin
            if ((ifun>=4'h0)&&(ifun<4'h7))
                begin
                    rA[3:0] = 4'hf;
                    rB[3:0] = 4'hf;
                    valC[63:0] = instr[71:8];
                    need_reg_ids = 0;
                    need_valC = 1;
                    instr_valid = 1;
                end
            else
                begin
                    need_reg_ids = 0;
                    need_valC = 1;
                    instr_valid = 1;
                end
        end
    else if (icode==4'h8)                        
        begin
            rA[3:0] = 4'hf;
            rB[3:0] = 4'hf;
            valC[63:0] = instr[71:8];
            need_reg_ids = 0;
            need_valC = 1;
            instr_valid = 1;
        end
    else if (icode==4'h9)                  
        begin
            rA[3:0] = 4'hf;
            rB[3:0] = 4'hf;
            valC[63:0] = 64'h0;
            need_reg_ids = 0;
            need_valC = 0;
            instr_valid = 1; 
        end
    else if ((icode==4'ha)||(icode==4'hb))               
        begin
                rA[3:0] = instr[71:68];
                rB[3:0] = instr[67:64];
                valC[63:0] = 64'h0;
                need_reg_ids = 1;
                need_valC = 0;
                instr_valid = 1;
        end
    else
        begin
            instr_valid = 0;
        end

                    //PC increment

    valP = PC + 1 + need_reg_ids + 8*need_valC;

end


endmodule

