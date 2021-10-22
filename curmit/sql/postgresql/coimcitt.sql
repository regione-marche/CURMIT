/*==============================================================*/
/* table coimcitt: Anagrafica cittadini                         */
/*==============================================================*/

create table coimcitt
     ( cod_cittadino    varchar(08) not null
     , natura_giuridica char(01) 
     , cognome          varchar(100)
     , nome             varchar(100)
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
     , data_nas         date
     , comune_nas       varchar(40)
     , utente           varchar(10)
     , data_ins         date
     , data_mod         date
     , utente_ult       varchar(10)
     , note             varchar(4000)
     , stato_citt       char(01) not null default 'A' --A=Attivo, N=Non attivo -- 2014-06-30
     , pec              varchar(35)
     );

create unique index coimcitt_00
    on coimcitt
     ( cod_cittadino
     );

create index coimcitt_01
    on coimcitt
     ( cognome
     , nome
     , cod_cittadino
     ) ;

alter table coimcitt
  add constraint chk_natura_giuridica_coimcitt
check (natura_giuridica in ('F', 'G'));

create function coimcitt_upper_pr() returns opaque as '
declare
begin
    new.cognome          := upper(new.cognome);
    new.nome             := upper(new.nome);
    new.indirizzo        := upper(new.indirizzo);
    new.numero           := upper(new.numero);
    new.localita         := upper(new.localita);
    new.comune           := upper(new.comune);
    new.provincia        := upper(new.provincia);
    new.cod_fiscale      := upper(new.cod_fiscale);
    new.comune_nas       := upper(new.comune_nas);
    return new;
end;
' language 'plpgsql';

create trigger coimcitt_upper_tr
    before insert or update on coimcitt
    for each row
        execute procedure coimcitt_upper_pr();

--gac01 aggiunti campi patentino e patentino_fgas
alter table coimcitt add patentino boolean not null default 'f';
alter table coimcitt add patentino_fgas boolean not null default 'f';
