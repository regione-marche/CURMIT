/*==============================================================*/
/* table coimmanu: tabella dei progettisti                      */
/*==============================================================*/

create table coimprog
     ( cod_progettista  varchar(08)  not null
     , cognome          varchar(100)
     , nome             varchar(100)
     , indirizzo        varchar(40)
     , localita         varchar(40)
     , provincia        varchar(04)
     , cap              varchar(05)
     , comune           varchar(40)
     , cod_fiscale      varchar(16)
     , cod_piva         varchar(16)
     , telefono         varchar(15)
     , cellulare        varchar(15)
     , fax              varchar(15)
     , email            varchar(35)
     , reg_imprese      varchar(15)
     , localita_reg     varchar(40)
     , rea              varchar(15)
     , localita_rea     varchar(40)
     , capit_sociale    numeric(11,2)
     , data_ins         date
     , data_mod         date
     , utente           varchar(10)
     , note             varchar(4000)
     );

create unique index coimprog_00
    on coimprog
     ( cod_progettista
     );
