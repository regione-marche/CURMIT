/*==============================================================*/
/* table coimmail: invio delle email tramite pec                */
/*==============================================================*/

create table coimmail
     ( id_mail         integer      not null
     , mittente        varchar(250) not null
     , destinatario    varchar(250) not null
     , cc              varchar(250)
     , oggetto         varchar(1000) not null
     , testo           varchar(4000) 
     , allegato        varchar(250)
     , utente_ins      varchar(10)
     , data_ins        timestamp with time zone
     , nome_file       varchar(250)
     );
     
create unique index coimmail_00
    on coimmail
     ( id_mail
     );
