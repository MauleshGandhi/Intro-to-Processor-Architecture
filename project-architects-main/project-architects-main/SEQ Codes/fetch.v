module fetch(icode,ifun,imem_error,instr_valid,halt,rA,rB,valC,valP,PC,clk);

input clk;
input [63:0] PC;                        //64 bit program counter

output wire imem_error,instr_valid,halt;
output wire [3:0] icode,ifun,rA,rB;
output wire [63:0] valC,valP;

reg [7:0] instr_mem[1023:0];            //1kb instruction_memory
wire [79:0] instr;                       //instruction
wire need_reg_ids;
wire need_valC;

assign imem_error = (PC>1023);

assign instr[79:72] = instr_mem[PC];
assign instr[71:64] = instr_mem[PC+1];
assign instr[63:56] = instr_mem[PC+2];
assign instr[55:48] = instr_mem[PC+3];
assign instr[47:40] = instr_mem[PC+4];
assign instr[39:32] = instr_mem[PC+5];
assign instr[31:24] = instr_mem[PC+6];
assign instr[23:16] = instr_mem[PC+7];
assign instr[15:8]  = instr_mem[PC+8];
assign instr[7:0]   = instr_mem[PC+9]; 

assign icode[3:0] = instr[79:76];
assign ifun[3:0] = instr[75:72];

assign instr_valid = (icode==0|icode==1|(icode==2 && ifun>=0 && ifun <=6)|icode==3|icode==4|icode==5|(icode==6 && ifun>=0 && ifun<=3)|(icode==7 && ifun>=0 && ifun<=6)|icode==8|icode==9|icode==10|icode==11);

assign rA = (icode==2|icode==3|icode==4|icode==5|icode==6|icode==10|icode==11) ? instr[71:68] : 4'hf;
assign rB = (icode==2|icode==3|icode==4|icode==5|icode==6|icode==10|icode==11) ? instr[67:64] : 4'hf;

assign valC = (icode==3|icode==4|icode==5) ? instr[63:0] : (icode==7|icode==8) ? instr[71:8] : 64'h0;

assign need_reg_ids = (icode==2|icode==3|icode==4|icode==5|icode==6|icode==10|icode==11);
assign need_valC = (icode==3|icode==4|icode==5|icode==7|icode==8);

assign valP = PC + 1 + need_reg_ids + 8*need_valC;

assign halt = (icode==0);

initial begin
                //initialize instr_mem
    instr_mem[420] = 8'h00;             //halt

    instr_mem[421] = 8'h10;             //nop
    
    instr_mem[422] = 8'h30;             //irmov 
    instr_mem[423] = 8'hf4;             //F rsp
    instr_mem[424] = 8'h00;             //highest point of memory 1024
    instr_mem[425] = 8'h00;                 
    instr_mem[426] = 8'h00;             
    instr_mem[427] = 8'h00;             
    instr_mem[428] = 8'h00;             
    instr_mem[429] = 8'h00;             
    instr_mem[430] = 8'h03;             
    instr_mem[431] = 8'hff;             
    
    instr_mem[432] = 8'h30;             //irmov
    instr_mem[433] = 8'hf0;             //F rax    
    instr_mem[434] = 8'h00;             // 5
    instr_mem[435] = 8'h00;                 
    instr_mem[436] = 8'h00;            
    instr_mem[437] = 8'h00;                 
    instr_mem[438] = 8'h00;             
    instr_mem[439] = 8'h00;
    instr_mem[440] = 8'h00;
    instr_mem[441] = 8'h05;
    
    instr_mem[442] = 8'h30;             //irmov    
    instr_mem[443] = 8'hf1;             //F rcx
    instr_mem[444] = 8'h00;             // 8
    instr_mem[445] = 8'h00;                 
    instr_mem[446] = 8'h00;             
    instr_mem[447] = 8'h00;             
    instr_mem[448] = 8'h00;
    instr_mem[449] = 8'h00;
    instr_mem[450] = 8'h00;
    instr_mem[451] = 8'h08;
    
    instr_mem[452] = 8'h60;             //opq-->add
    instr_mem[453] = 8'h01;             //rax rcx------rcx=rax+rcx=d

    instr_mem[454] = 8'h30;             //irmov
    instr_mem[455] = 8'hf2;             //F rdx
    instr_mem[456] = 8'h00;             //13
    instr_mem[457] = 8'h00;                 
    instr_mem[458] = 8'h00;
    instr_mem[459] = 8'h00;
    instr_mem[460] = 8'h00;
    instr_mem[461] = 8'h00;
    instr_mem[462] = 8'h00;
    instr_mem[463] = 8'h0d;
    
    instr_mem[464] = 8'h61;             //opq-->sub
    instr_mem[465] = 8'h12;             //rcx rdx ----------rdx=0

    instr_mem[466] = 8'h71;             //jmp
    instr_mem[467] = 8'h00;                 
    instr_mem[468] = 8'h00;             
    instr_mem[469] = 8'h00;                 
    instr_mem[470] = 8'h00;             
    instr_mem[471] = 8'h00;                 
    instr_mem[472] = 8'h00;             
    instr_mem[473] = 8'h01;                 
    instr_mem[474] = 8'hdf;             
    
    instr_mem[475] = 8'h10;             //nop
    instr_mem[476] = 8'h10;
    instr_mem[477] = 8'h10;
    instr_mem[478] = 8'h00;

    instr_mem[479] = 8'h30;             //irmov 250-->r8
    instr_mem[480] = 8'hf8;
    instr_mem[481] = 8'h00;
    instr_mem[482] = 8'h00;                 
    instr_mem[483] = 8'h00;            
    instr_mem[484] = 8'h00;
    instr_mem[485] = 8'h00;
    instr_mem[486] = 8'h00;
    instr_mem[487] = 8'h00;
    instr_mem[488] = 8'hfa;
    
    instr_mem[489] = 8'h40;             //rmmov rcx-->mem[r8+10]
    instr_mem[490] = 8'h18;
    instr_mem[491] = 8'h00;                
    instr_mem[492] = 8'h00;             
    instr_mem[493] = 8'h00;
    instr_mem[494] = 8'h00;
    instr_mem[495] = 8'h00;
    instr_mem[496] = 8'h00;
    instr_mem[497] = 8'h00;
    instr_mem[498] = 8'h0a;
    
    instr_mem[499] = 8'h50;             //mrmov mem[r8+10]-->r9
    instr_mem[500] = 8'h98;                 
    instr_mem[501] = 8'h00;             
    instr_mem[502] = 8'h00;
    instr_mem[503] = 8'h00;
    instr_mem[504] = 8'h00;
    instr_mem[505] = 8'h00;
    instr_mem[506] = 8'h00;
    instr_mem[507] = 8'h00;
    instr_mem[508] = 8'h0a;
    
    instr_mem[509] = 8'h80;             //call to 520
    instr_mem[510] = 8'h00;             
    instr_mem[511] = 8'h00;
    instr_mem[512] = 8'h00;
    instr_mem[513] = 8'h00;
    instr_mem[514] = 8'h00;
    instr_mem[515] = 8'h00;
    instr_mem[516] = 8'h02;
    instr_mem[517] = 8'h08;
    
    instr_mem[518] = 8'h10;             
    instr_mem[519] = 8'h00;
                 
    instr_mem[520] = 8'h10;
    instr_mem[521] = 8'h10;
    instr_mem[522] = 8'h10;
    instr_mem[523] = 8'h10;             

    instr_mem[524] = 8'h20;             //shows value in rsp
    instr_mem[525] = 8'h44;

    instr_mem[526] = 8'h50;             // mrmov
    instr_mem[527] = 8'ha4;             
    instr_mem[528] = 8'h00;             
    instr_mem[529] = 8'h00;
    instr_mem[530] = 8'h00;
    instr_mem[531] = 8'h00;
    instr_mem[532] = 8'h00;
    instr_mem[533] = 8'h00;
    instr_mem[534] = 8'h00;
    instr_mem[535] = 8'h00;
    
    instr_mem[536] = 8'h90;             // push
    instr_mem[537] = 8'h8f;             
    
    instr_mem[538] = 8'ha0;             // pop
    instr_mem[539] = 8'h9f;

    instr_mem[540] = 8'h90;
    instr_mem[541] = 8'hcf;

    instr_mem[542] = 8'hb0;
    instr_mem[543] = 8'hcf;

    instr_mem[544] = 8'hb0;
    instr_mem[545] = 8'hcf;             
    instr_mem[546] = 8'h00;             

    instr_mem[547] = 8'ha0;             
    instr_mem[548] = 8'h90;             

    instr_mem[549] = 8'hb0;             
    instr_mem[550] = 8'h20;             
end

endmodule

