/*==============================================================*/
/* table coimcitt_cnt: Anagrafica cittadini                         */
/*==============================================================*/

create table coimcitt_cnt
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
     );

create unique index coimcitt_cnt_00
    on coimcitt_cnt
     ( cod_cittadino
     );

create index coimcitt_cnt_01
    on coimcitt_cnt
     ( cognome
     , nome
     , cod_cittadino
     ) ;

alter table coimcitt_cnt
  add constraint chk_natura_giuridica_coimcitt_cnt
check (natura_giuridica in ('F', 'G'));

create function coimcitt_cnt_upper_pr() returns opaque as '
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

create trigger coimcitt_cnt_upper_tr
    before insert or update on coimcitt_cnt
    for each row
        execute procedure coimcitt_cnt_upper_pr();
