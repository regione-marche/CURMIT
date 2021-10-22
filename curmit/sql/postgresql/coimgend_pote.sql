/*==============================================================*/
/* table coimgend_pote: Potenza delle singole prove fumi        */
/*==============================================================*/

create table coimgend_pote (
             cod_pr_fumi               varchar (8) not null
           , progressivo_prova_fumi    integer
           , cod_impianto              varchar (8)
           , gen_prog                  decimal (8,0)
           , potenza_utile_focolare    decimal (9,2)
           , potenza_nominale_focolare decimal (9,2)
     ) ;

create unique index coimgend_pote_00
    on coimgend_pote
     ( cod_pr_fumi
     );
