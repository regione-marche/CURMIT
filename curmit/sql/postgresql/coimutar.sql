/*================================================================*/
/* table coimutar : collegamento utenti - area di competenza      */
/*================================================================*/

create table coimutar
     ( cod_area          varchar(08)  not null
     , id_utente         varchar(10)  not null
     , data_ins          date
     , data_mod          date
     , utente            varchar(10)
     );

create unique index coimutar_00
    on coimutar
     ( cod_area
     , id_utente
     );
