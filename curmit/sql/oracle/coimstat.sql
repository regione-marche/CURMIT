/*====================================================================*/
/* table coimstat:                                                    */
/*====================================================================*/

create table coimstat
     ( cod_stato          varchar2(08)     not null primary key
     , sigla              varchar2(10)
     , denominazione      varchar2(100)
     , cod_istat          varchar2(10)
     ) tablespace &ts_dat;

