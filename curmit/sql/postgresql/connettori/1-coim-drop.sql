-- tabelle
drop table coimaimp_cnt;
drop table coimanom_cnt;
drop table coimcimp_cnt;
drop table coimcitt_cnt;
drop table coimcomb_cnt;
drop table coimcost_cnt;
drop table coimdimp_cnt;
drop table coimgend_cnt;
drop table coimmanu_cnt;
drop table coimopve_cnt;
drop table coimprog_cnt;
drop table coimtopo_cnt;
drop table coimviae_cnt;

-- sequence
drop sequence coimaimp_cnt_s;
drop sequence coimaimp_cnt_est_s;
drop sequence coimcimp_cnt_s; 
drop sequence coimcitt_cnt_s; 
drop sequence coimcost_cnt_s; 
drop sequence coimdimp_cnt_s; 
drop sequence coimmanu_cnt_s;
drop sequence coimprog_cnt_s; 
drop sequence coimviae_cnt_s; 

-- funzioni richiamate dai trigger
drop function coimaimp_cnt_upper_pr();
drop function coimcitt_cnt_upper_pr();
drop function coimviae_cnt_upper_pr();

