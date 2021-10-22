/*==============================================================*/
/* table coimragr : tabella raggruppamenti per i pesi dei       */
/*                  campi dei rapporti di verifica              */
/*==============================================================*/

create table coimragr
     ( cod_raggruppamento          varchar(08)  not null
     , descrizione       varchar(50)
     , peso_da           numeric(9,0)
     , peso_a            numeric(9,0)
     , data_ins          date
     , data_mod          date
     , utente            varchar(10)
     );

create unique index coimragr_00
    on coimragr
     ( cod_raggruppamento );
