/*==============================================================*/
/* table coim_tp_att:				                */
/*==============================================================*/

create table coim_tp_att
     ( cod_attivita	varchar(08)  not null primary key
     , descr_attivita	varchar(500)
     , data_ins		date
     , data_mod        	date
     , utente_ins       varchar(10)
     , utente_mod	varchar(10)
     );