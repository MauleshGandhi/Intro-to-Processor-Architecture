module Fetch_Pipe(f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,predict_PC,M_icode,M_Cnd,M_valA,W_icode,W_valM,F_predPC);
                       //64 bit progf_ram counter
input [3:0] M_icode;
input M_Cnd;
input [63:0] M_valA;
input [3:0] W_icode;
input [63:0] W_valM;
input [63:0] F_predPC;

output wire [3:0] f_stat;                 //AOK,instr_invalid,imem_error,halt
output wire [3:0] f_icode,f_ifun,f_rA,f_rB;
output wire [63:0] f_valC,f_valP;
output wire [63:0] predict_PC;

reg [7:0] instr_mem[1023:0];            //1kb instruction_memory
wire [79:0] instr;                      //instruction
wire need_reg_ids;
wire need_f_valC;
wire [63:0] f_pc;

                //predict PC

assign predict_PC = (f_icode==7|f_icode==8) ? f_valC : f_valP;

                //select PC

assign f_pc = ((M_icode==7)&&(!M_Cnd)) ? M_valA : (W_icode==9) ? W_valM : F_predPC;     //jump misprediction->fetch at incremented PC
                                                                                        //ret completed->read return address
                                                                                        //else use predicted PC
                //read instructions from f_pc

assign instr[79:72] = instr_mem[f_pc];
assign instr[71:64] = instr_mem[f_pc+1];
assign instr[63:56] = instr_mem[f_pc+2];
assign instr[55:48] = instr_mem[f_pc+3];
assign instr[47:40] = instr_mem[f_pc+4];
assign instr[39:32] = instr_mem[f_pc+5];
assign instr[31:24] = instr_mem[f_pc+6];
assign instr[23:16] = instr_mem[f_pc+7];
assign instr[15:8]  = instr_mem[f_pc+8];
assign instr[7:0]   = instr_mem[f_pc+9]; 

                //decode instructions

assign f_icode[3:0] = instr[79:76];
assign f_ifun[3:0] = instr[75:72];
assign f_rA = (f_icode==2|f_icode==3|f_icode==4|f_icode==5|f_icode==6|f_icode==10|f_icode==11) ? instr[71:68] : 4'hf;
assign f_rB = (f_icode==2|f_icode==3|f_icode==4|f_icode==5|f_icode==6|f_icode==10|f_icode==11) ? instr[67:64] : 4'hf;
assign f_valC = (f_icode==3|f_icode==4|f_icode==5) ? instr[63:0] : (f_icode==7|f_icode==8) ? instr[71:8] : 64'h0;
assign need_reg_ids = (f_icode==2|f_icode==3|f_icode==4|f_icode==5|f_icode==6|f_icode==10|f_icode==11);
assign need_f_valC = (f_icode==3|f_icode==4|f_icode==5|f_icode==7|f_icode==8);
assign f_valP = f_pc + 1 + need_reg_ids + 8*need_f_valC;
                
                //assign stat

assign f_stat[2] = (f_icode==0|f_icode==1|(f_icode==2 && f_ifun>=0 && f_ifun <=6)|f_icode==3|f_icode==4|f_icode==5|(f_icode==6 && f_ifun>=0 && f_ifun<=3)|(f_icode==7 && f_ifun>=0 && f_ifun<=6)|f_icode==8|f_icode==9|f_icode==10|f_icode==11) ? 0 : 1;
assign f_stat[1] = (f_pc>1023);
assign f_stat[0] = (f_icode==0);
assign f_stat[3] = (f_stat[0]==1|f_stat[1]==1|f_stat[2]==1) ? 0 : 1;

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
    
    instr_mem[509] = 8'h60;             //add r9 and r8
    instr_mem[510] = 8'h98; 

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
    
    instr_mem[536] = 8'hb0;             // push
    instr_mem[537] = 8'h8f;             
    
    instr_mem[538] = 8'ha0;             // pop
    instr_mem[539] = 8'h9f;

    instr_mem[540] = 8'h00;
    instr_mem[541] = 8'h10;

    instr_mem[542] = 8'h10;
    instr_mem[543] = 8'h10;

    instr_mem[544] = 8'h10;
    instr_mem[545] = 8'hcf;             
    instr_mem[546] = 8'h00;             

    instr_mem[547] = 8'ha0;             
    instr_mem[548] = 8'h90;             

    instr_mem[549] = 8'hb0;             
    instr_mem[550] = 8'h20;             
end

endmodule

