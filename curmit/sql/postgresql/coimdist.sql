/*==============================================================*/
/* table coimdist: Anagrafica distributori                      */
/*==============================================================*/

create table coimdist
     ( cod_distr        varchar(08) not null
     , ragione_01       varchar(40) not null
     , ragione_02       varchar(40) 
     , indirizzo        varchar(40) 
     , numero           varchar(08)  
     , cap              varchar(05)       
     , localita         varchar(40) 
     , comune           varchar(40) 
     , provincia        varchar(04)
     , cod_fiscale      varchar(16)      
     , cod_piva         varchar(16)        
     , telefono         varchar(15)
     , cellulare        varchar(15)
     , fax              varchar(15)            
     , email            varchar(35)
     , note             varchar(4000)
     , tracciato        varchar(250)
     , data_ins         date
     , data_mod         date
     , utente           varchar(10)
     , tipo_energia     char(01) --E=Elettrica, T=Termica T, G=Elettrica/Termica -- 2014-06-30
     );

create unique index coimdist_00
    on coimdist
     ( cod_distr
     );

