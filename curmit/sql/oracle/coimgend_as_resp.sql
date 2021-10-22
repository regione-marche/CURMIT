/*====================================================================*/
/* table coimgend_as_resp:                                            */
/*====================================================================*/

create table coimgend_as_resp
     (cod_as_resp         varchar2(8)	 not null
     , gen_prog           numeric(8,0)   not null
     , cod_combustibile   varchar2(8)
     , potenza            numeric(9,2) 
     ) tablespace &ts_dat;

create unique index coimgend_as_resp_00
    on coimgend_as_resp
     ( cod_as_resp
     , gen_prog
     ) tablespace &ts_dat;
