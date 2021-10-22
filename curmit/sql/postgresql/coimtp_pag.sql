/*==============================================================*/
/* table coimtp_pag: tabella tipi pagamento                     */
/*==============================================================*/

create table coimtp_pag
     ( cod_tipo_pag      varchar(08)  not null
     , descrizione       varchar(300)
     , ordinamento       integer
     , data_ins        date
     , data_mod        date
     , utente          varchar(10)
     );

create unique index coimtp_pag_00
    on coimtp_pag
     ( cod_tipo_pag
     );
