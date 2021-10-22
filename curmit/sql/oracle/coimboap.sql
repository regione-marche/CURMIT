/*==============================================================*/
/* table coimboap: Tabella di appoggio bollini                  */
/*==============================================================*/

create table coimboap
     ( cod_boap			 integer	 not null
     , cod_bollini		 integer
     , cod_manutentore_da	 varchar(8)	 not null
     , cod_manutentore_a 	 varchar(8)	 not null
     , nr_bollini		 numeric(8,0)
     , matr_da			 varchar(20)
     , matr_a 			 varchar(20)
     , note 			 varchar(4000)
     , data_ins			 date
     , data_mod			 date
     , utente_ins		 varchar(10)
     , utente_mod		 varchar(10) 
     , cod_val_spost		 char(1)
     ) tablespace &ts_dat;

create unique index coimboap_00
    on coimboap
     ( cod_boap
     ) tablespace &ts_idx;

create        index coimboap_01
    on coimboap
     ( cod_manutentore_da
     ) tablespace &ts_idx;

create        index coimboap_02
    on coimboap
     ( cod_manutentore_a
     );

create        index coimboap_03
    on coimboap
     ( cod_bollini
     ) tablespace &ts_idx;
