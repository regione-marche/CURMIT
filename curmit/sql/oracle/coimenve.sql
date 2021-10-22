/*==============================================================*/
/* table coimenve: Anagrafica enti verificatori                 */
/*==============================================================*/

create table coimenve
     ( cod_enve         varchar2(08) not null
     , ragione_01       varchar2(40) not null
     , ragione_02       varchar2(40) 
     , indirizzo        varchar2(40) 
     , numero           varchar2(08)  
     , cap              varchar2(05)       
     , localita         varchar2(40) 
     , comune           varchar2(40) 
     , provincia        varchar2(04)
     , cod_fiscale      varchar2(16)      
     , cod_piva         varchar2(16)        
     , telefono         varchar2(15)
     , cellulare        varchar2(15)
     , fax              varchar2(15)            
     , email            varchar2(35)
     , note             varchar2(4000)
     , tracciato        varchar2(250)
     , data_ins         date
     , data_mod         date
     , utente           varchar2(10)
     )  tablespace &ts_dat;

create unique index coimenve_00
    on coimenve
     ( cod_enve
     )  tablespace &ts_idx;

