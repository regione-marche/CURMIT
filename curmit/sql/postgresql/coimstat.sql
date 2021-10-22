/*====================================================================*/
/* table coimstat:                                                    */
/*====================================================================*/

create table coimstat
     ( cod_stato          varchar(08)     not null primary key
     , sigla              varchar(10)
     , denominazione      varchar(100)
     , cod_istat          varchar(10)
     );

