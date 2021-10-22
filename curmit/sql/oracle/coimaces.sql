/*==============================================================*/
/* table coimaces: Nominativi acquisiti esternamente            */
/*==============================================================*/
create table coimaces
     ( cod_aces            varchar2(08)  not null
     , cod_aces_est        varchar2(15)
     , cod_acts            varchar2(08)  not null
     , cod_cittadino       varchar2(08)
     , cod_impianto        varchar2(08)
     , cod_combustibile    varchar2(08)
     , natura_giuridica    char(01)      not null
     , cognome             varchar2(40)
     , nome                varchar2(40)
     , indirizzo           varchar2(40)
     , numero              varchar2(08)
     , esponente           varchar2(03)
     , scala               varchar2(05)
     , piano               varchar2(05)
     , interno             varchar2(03)
     , cap                 varchar2(05)       
     , localita            varchar2(40)
     , comune              varchar2(40)
     , provincia           varchar2(04) 
     , cod_fiscale_piva    varchar2(16)      
     , telefono            varchar2(15)
     , data_nas            date
     , comune_nas          varchar2(40)
 -- N Nuovo record, E Esistente sulla aces, I Invariato sulla aimp, D Da analizzare, S Record scartato, P Importato aimp,  null
     , stato_01            char(01)
 -- R regolare da passare a controllo, D deceduto,  S sospeso, null
     , stato_02            char(01)
 -- risultati di eventuale caricamento
     , note                varchar2(4000)
     , consumo_annuo       number(9,2)
     , tariffa             varchar2(08)
 --dati alla modifica
     ,data_ins             date
     ,data_mod             date
     ,utente               varchar2(10)
     ) tablespace &ts_dat;

create unique index coimaces_00
    on coimaces
     ( cod_aces
     ) tablespace &ts_idx;

create  index coimaces_01
    on coimaces
     ( cod_acts
     ) tablespace &ts_idx;

create  index coimaces_02
    on coimaces
     ( cod_acts,
       comune,
       indirizzo,
       esponente,
       scala,
       piano,
       interno
     );

alter table coimaces 
  add constraint chk_natura_giuridica_coimaces 
check (natura_giuridica in ('F', 'G'));

alter table coimaces
  add constraint chk_stato_01_coimaces
check (stato_01 in ('N', 'E', 'I', 'D', 'S', 'P'));