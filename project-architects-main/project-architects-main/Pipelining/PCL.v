module PCL(W_stall,M_bubble,set_cc,E_bubble,D_bubble,D_stall,F_stall,D_icode,d_srcA,d_srcB,E_icode,E_dstM,e_Cnd,M_icode,m_stat,W_stat);

input [3:0] D_icode;
input [3:0] d_srcA,d_srcB;
input [3:0] E_icode,E_dstM;
input e_Cnd;
input [3:0] M_icode;
input [3:0] m_stat;
input [3:0] W_stat;

output wire W_stall;
output wire M_bubble;
output wire set_cc;
output wire E_bubble;
output wire D_bubble,D_stall;
output wire F_stall;

assign W_stall = 0;//(W_stat[0] | W_stat[1] | W_stat[2]);

assign M_bubble = 0//((W_stat[0] | W_stat[1] | W_stat[2])|(m_stat[0] | m_stat[1] | m_stat[2])) ;

//assign set_cc = //done in execute itself

//E_bubble
assign E_bubble = (((E_icode==7)&&(!e_Cnd))|
                   (((E_icode==5)|(E_icode==6))&&((E_dstM==d_srcA)|(E_dstM==d_srcB))));  //mispredicted branch| load/use hazard

assign D_bubble = (((E_icode==7)&&(!e_Cnd))
                    |(!(((E_icode==5)|(E_icode==6))&&((E_dstM==d_srcA)|(E_dstM==d_srcB)))
                            &&(D_icode==4'h9 | E_icode==4'h9 | M_icode==4'h9)));

assign D_stall = ((E_icode==4'h5 | E_icode==4'hb)&&(E_dstM==d_srcA | E_dstM==d_srcB));

assign F_stall = (((E_icode==4'h5 | E_icode==4'hb)&&(E_dstM==d_srcA | E_dstM==d_srcB))|
                    (D_icode==4'h9 | E_icode==4'h9 | M_icode==4'h9));

endmodule