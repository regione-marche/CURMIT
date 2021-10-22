/*==============================================================*/
/* table coimcitt: Anagrafica conduttori                        */
/*==============================================================*/

create table coimcondu 
     ( cod_conduttore    varchar(8) not null    
     , cognome           varchar(250)
     , nome              varchar(250)
     , cod_fiscale       varchar(16) 
     , indirizzo         varchar(40)
     , numero            varchar(8)
     , comune            varchar(40)
     , provincia         varchar(4)
     , cap               char(5)
     , telefono          varchar(15)
     , cellulare         varchar(15)
     , fax               varchar(15)
     , email             varchar(35)
     , pec               varchar(35)
     , data_patentino    date
     , ente_rilascio_patentino varchar(250)
     );
create unique index coimcondu_00
    on coimcondu
     ( cod_conduttore
     );
create sequence coimcondu_s start 1;
