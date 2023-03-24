instr_mem[405] = 8'h10;                 
instr_mem[406] = 8'h10;                 
instr_mem[407] = 8'h10;            
instr_mem[408] = 8'h10;             
instr_mem[409] = 8'h10; 
            
instr_mem[410] = 8'h30;         //irmov             
instr_mem[411] = 8'hf0;             
instr_mem[412] = 8'h10;  
instr_mem[413] = 8'h10;                 
instr_mem[414] = 8'h10;             
instr_mem[415] = 8'h10;             
instr_mem[416] = 8'h10;             
instr_mem[417] = 8'h10;             
instr_mem[418] = 8'h10;             
instr_mem[419] = 8'h09;         //9          

instr_mem[420] = 8'h10;             
instr_mem[421] = 8'h10;             
instr_mem[422] = 8'h10;             
instr_mem[423] = 8'h10;

instr_mem[424] = 8'h20;         //cmovxx
instr_mem[425] = 8'h01;         //rax->rcx

instr_mem[426] = 8'h10;             
instr_mem[427] = 8'h10;             
instr_mem[428] = 8'h10;             
instr_mem[429] = 8'h10;             

instr_mem[430] = 8'h40;         //rmmmov          
instr_mem[431] = 8'h10;         //rcx->(rax+5)
instr_mem[432] = 8'h00;             
instr_mem[433] = 8'h00;                 
instr_mem[434] = 8'h00;             
instr_mem[435] = 8'h00;                 
instr_mem[436] = 8'h00;            
instr_mem[437] = 8'h00;                 
instr_mem[438] = 8'h00;             
instr_mem[439] = 8'h05;

instr_mem[440] = 8'h10;
instr_mem[441] = 8'h10;
instr_mem[442] = 8'h10;    
instr_mem[443] = 8'h10; 

instr_mem[444] = 8'h50;         //mrmov          
instr_mem[445] = 8'h30;         //rbx<-(rax+5) 
instr_mem[446] = 8'h00;             
instr_mem[447] = 8'h00;             
instr_mem[448] = 8'h00;
instr_mem[449] = 8'h00;
instr_mem[450] = 8'h00;
instr_mem[451] = 8'h00;
instr_mem[452] = 8'h00;             
instr_mem[453] = 8'h05;             

instr_mem[454] = 8'h10;             
instr_mem[455] = 8'h10;             
instr_mem[456] = 8'h10;             
instr_mem[457] = 8'h10;

instr_mem[458] = 8'h61;     //op subtract
instr_mem[459] = 8'h01;     //rax-rcx->rcx == 0

instr_mem[460] = 8'h10;
instr_mem[461] = 8'h10;
instr_mem[462] = 8'h10;
instr_mem[463] = 8'h10;

instr_mem[464] = 8'h70;             //jump le
instr_mem[465] = 8'h00;             
instr_mem[466] = 8'h00;             
instr_mem[467] = 8'h00;                 
instr_mem[468] = 8'h00;             
instr_mem[469] = 8'h00;                 
instr_mem[470] = 8'h00;             
instr_mem[471] = 8'h01;                 
instr_mem[472] = 8'hdd;

instr_mem[473] = 8'h10;                 
instr_mem[474] = 8'h00;                        
instr_mem[475] = 8'h00;             
instr_mem[476] = 8'h00;

instr_mem[477] = 8'h10;
instr_mem[478] = 8'h10;
instr_mem[479] = 8'h10;
instr_mem[480] = 8'h10;

instr_mem[481] = 8'h30;             //irmov
instr_mem[482] = 8'hf4;             //rsp->1023             
instr_mem[483] = 8'h00;            
instr_mem[484] = 8'h00;
instr_mem[485] = 8'h00;
instr_mem[486] = 8'h00;
instr_mem[487] = 8'h00;
instr_mem[488] = 8'h00;
instr_mem[489] = 8'h03;             
instr_mem[490] = 8'hff;

instr_mem[491] = 8'h10;                
instr_mem[492] = 8'h10;             
instr_mem[493] = 8'h10;
instr_mem[494] = 8'h10;

instr_mem[495] = 8'ha0;             //push
instr_mem[496] = 8'h0f;             //rax

instr_mem[497] = 8'h10;
instr_mem[498] = 8'h10;
instr_mem[499] = 8'h10;             
instr_mem[500] = 8'h10;

instr_mem[501] = 8'hb0;             //pop     
instr_mem[502] = 8'h80;             //r8x

instr_mem[503] = 8'h10;
instr_mem[504] = 8'h10;
instr_mem[505] = 8'h10;
instr_mem[506] = 8'h10;

instr_mem[507] = 8'h80;             //call
instr_mem[508] = 8'h00;
instr_mem[509] = 8'h00;             
instr_mem[510] = 8'h00;             
instr_mem[511] = 8'h00;
instr_mem[512] = 8'h00;
instr_mem[513] = 8'h00;
instr_mem[514] = 8'h02;
instr_mem[515] = 8'h09;             //520

instr_mem[516] = 8'h00;
instr_mem[517] = 8'h10;
instr_mem[518] = 8'h10;             
instr_mem[519] = 8'h10;
     
instr_mem[520] = 8'h10;
instr_mem[521] = 8'h10;
instr_mem[522] = 8'h10;
instr_mem[523] = 8'h10;             

instr_mem[524] = 8'h90;             //ret

instr_mem[525] = 8'h00;
instr_mem[526] = 8'h10;             
instr_mem[527] = 8'h10;             
instr_mem[528] = 8'h10;             
instr_mem[529] = 8'h10;
instr_mem[530] = 8'h10;
instr_mem[531] = 8'h10;
instr_mem[532] = 8'h10;
instr_mem[533] = 8'h10;
instr_mem[534] = 8'h10;
instr_mem[535] = 8'h10;
instr_mem[536] = 8'h10;
instr_mem[537] = 8'h10;             
instr_mem[538] = 8'h10;             
instr_mem[539] = 8'h10;
instr_mem[540] = 8'h10;
instr_mem[541] = 8'h10;
instr_mem[542] = 8'h10;
instr_mem[543] = 8'h10;
instr_mem[544] = 8'h10;
instr_mem[545] = 8'h10;             
instr_mem[546] = 8'h10;             
instr_mem[547] = 8'h10;             
instr_mem[548] = 8'h10;             
instr_mem[549] = 8'h10;             
instr_mem[550] = 8'h10; 