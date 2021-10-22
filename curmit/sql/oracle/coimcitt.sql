/*==============================================================*/
/* table coimcitt: Anagrafica cittadini                         */
/*==============================================================*/

create table coimcitt
     ( cod_cittadino    varchar2(08) not null
     , natura_giuridica char(01) 
     , cognome          varchar2(100)
     , nome             varchar2(100)
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
     , data_nas         date
     , comune_nas       varchar2(40)
     , utente           varchar2(10)
     , data_ins         date
     , data_mod         date
     , utente_ult       varchar2(10)
     , note             varchar2(4000)
     , stato_citt       char(01) not null default 'A' --A=Attivo, N=Non attivo -- 2014-06-30
     ) tablespace &ts_dat;

create unique index coimcitt_00
    on coimcitt
     ( cod_cittadino
     ) tablespace &ts_idx;

create index coimcitt_01
    on coimcitt
     ( cognome
     , nome
     , cod_cittadino
     ) tablespace &ts_idx;

alter table coimcitt
  add constraint chk_natura_giuridica_coimcitt
check (natura_giuridica in ('F', 'G'));

create or replace trigger coimcitt_upper_tr
   before insert or update on coimcitt
      for each row
begin
   :new.cognome          := upper(:new.cognome);
   :new.nome             := upper(:new.nome);
   :new.indirizzo        := upper(:new.indirizzo);
   :new.numero           := upper(:new.numero);
   :new.localita         := upper(:new.localita);
   :new.comune           := upper(:new.comune);
   :new.provincia        := upper(:new.provincia);
   :new.cod_fiscale      := upper(:new.cod_fiscale);
   :new.comune_nas       := upper(:new.comune_nas);
end coimcitt_upper_tr;
/
show errors
