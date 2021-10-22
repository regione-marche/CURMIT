/*==============================================================*/
/* table coimtp_pag: tabella tipi pagamento                     */
/*==============================================================*/

create table coimtp_pag
     ( cod_tipo_pag    varchar2(08)  not null
     , descrizione     varchar2(300)
     , ordinamento     number(08)
     , data_ins        date
     , data_mod        date
     , utente          varchar2(10)
     ) tablespace &ts_dat;

create unique index coimtp_pag_00
    on coimtp_pag
     ( cod_tipo_pag
     ) tablespace &ts_idx;
