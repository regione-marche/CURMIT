/*============================================================================*/
/* table coimstrl: Storico rappresentanti legati delle ditte di manutenzione  */
/*============================================================================*/

create table coimstrl
     ( cod_strl              number(08)   not null
     , cod_manutentore       varchar2(08) not null
     , data_fin_valid        date         not null
     , cod_soggetto          varchar2(08) not null
     , utente_ins            varchar2(10)
     , timestamp_ins         timestamp    not null default current_timestamp
     , utente_mod            varchar2(10) 
     , timestamp_mod         timestamp
     ) tablespace &ts_dat;


create unique index coimstrl_00
    on coimstrl
     ( cod_strl
     ) tablespace &ts_idx;

create unique index coimstrl_01
    on coimstrl
     ( cod_manutentore
     , data_fin_valid
     ) tablespace &ts_idx;
