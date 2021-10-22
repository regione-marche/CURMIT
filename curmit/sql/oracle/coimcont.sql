/*==============================================================*/
/* table coimcont: tabella dei contratti                        */
/*==============================================================*/

create table coimcont
     ( cod_contratto         varchar2(08)  not null
     , num_contratto         varchar2(08)
     , cod_impianto          varchar2(08)
     , cod_manutentore       varchar2(08)
     , cod_soggetto          varchar2(08)
     , data_inizio_valid     date
     , data_fine_valid       date
     , stato                 char(01)
     , data_ins              date
     , data_mod              date
     , utente                varchar2(10)
     );

create unique index coimcont_00
    on coimcont
     ( cod_contratto
     ) tablespace &ts_idx;

create        index coimcont_01
    on coimcont
     ( cod_impianto
     , data_inizio_valid
     , cod_contratto
     ) tablespace &ts_idx;

create        index coimcont_02
    on coimcont
     ( num_contratto
     ) tablespace &ts_idx;

