/*============================================================================*/
/* table coimstrl: Storico rappresentanti legati delle ditte di manutenzione  */
/*============================================================================*/

create table coimstrl
     ( cod_strl              integer     not null
     , cod_manutentore       varchar(08) not null
     , data_fin_valid        date        not null
     , cod_soggetto          varchar(08) not null
     , utente_ins            varchar(10) 
     , timestamp_ins         timestamp   not null default current_timestamp
     , utente_mod            varchar(10) 
     , timestamp_mod         timestamp
     );

comment on table coimstrl is 'Tabella di storico rappresentanti legali delle ditte di manutenzione';


create unique index coimstrl_00
    on coimstrl
     ( cod_strl
     );

create unique index coimstrl_01
    on coimstrl
     ( cod_manutentore
     , data_fin_valid
     );

