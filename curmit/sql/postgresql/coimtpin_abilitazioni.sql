/*=======================================================================================================================*/
/* table coimtpim_abilitazioni : tipologia impianti su cui un operatore/manutentore può operare.                         */
/*=======================================================================================================================*/


create table coimtpin_abilitazioni (
             cod_tpin_abil       integer not null
           , cod_coimtpin            integer not null
           , flag_tipo_impianto  varchar(1)
           , tipo_combustibile   varchar(1)
           ) ;

create unique index coimtpin_abilitazioni_00
    on coimtpin_abilitazioni
     ( cod_tpin_abil
     );

create unique index coimtpin_abilitazioni_01
    on coimtpin_abilitazioni
     ( cod_coimtpin
     , flag_tipo_impianto
     , tipo_combustibile
     );

