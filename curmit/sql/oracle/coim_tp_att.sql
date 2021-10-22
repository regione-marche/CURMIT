/*==============================================================*/
/* table coim_tp_att:				                */
/*==============================================================*/

create table coim_tp_att
     ( cod_attivita	varchar2(08)  not null primary key
     , descr_attivita	varchar2(500)
     , data_ins		date
     , data_mod        	date
     , utente_ins       varchar2(10)
     , utente_mod	varchar2(10)
     ) tablespace &ts_dat;