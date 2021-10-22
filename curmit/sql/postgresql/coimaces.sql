/*==============================================================*/
/* table coimaces: Nominativi acquisiti esternamente            */
/*==============================================================*/
create table coimaces
     ( cod_aces           varchar(08)  not null
     , cod_aces_est       varchar(15)
     , cod_acts           varchar(08)  not null
     , cod_cittadino      varchar(08)
     , cod_impianto       varchar(08)
     , cod_combustibile   varchar(08)
     , natura_giuridica   char(01)      not null
     , cognome            varchar(40)
     , nome               varchar(40)
     , indirizzo          varchar(40)
     , numero             varchar(08)
     , esponente          varchar(03)
     , scala              varchar(05)
     , piano              varchar(05)
     , interno            varchar(03)
     , cap                varchar(05)       
     , localita           varchar(40)
     , comune             varchar(40)
     , provincia          varchar(04) 
     , cod_fiscale_piva   varchar(16)      
     , telefono           varchar(15)
     , data_nas           date
     , comune_nas         varchar(40)
 -- N Nuovo record, E Esistente sulla aces, I Invariato sulla aimp, D Da analizzare, S Record scartato, P Importato aimp,  null
     , stato_01           char(01)
 -- R regolare da passare a controllo, D deceduto,  S sospeso, null
     , stato_02           char(01)
 -- risultati di eventuale caricamento
     , note               varchar(4000)
     , consumo_annuo      numeric(9,2)
     , tariffa            varchar(08)
 --dati alla modifica
     , data_ins           date
     , data_mod           date
     , utente             varchar(10)
     );

create unique index coimaces_00
    on coimaces
     ( cod_aces
     );

create  index coimaces_01
    on coimaces
     ( cod_acts
     );

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