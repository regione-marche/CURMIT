-- Serena 01/06/2012

begin;

alter table iter_maintainers add la boolean default 'f';
alter table iter_maintainers add lb boolean default 'f';
alter table iter_maintainers add lc boolean default 'f';
alter table iter_maintainers add ld boolean default 'f';
alter table iter_maintainers add le boolean default 'f';
alter table iter_maintainers add lf boolean default 'f';
alter table iter_maintainers add lg boolean default 'f';
alter table iter_maintainers add uni_iso varchar(100);
alter table iter_maintainers add altre_certificazioni text;
alter table iter_maintainers add albo_artigiani varchar(15);

CREATE TABLE iter_ordboll (
	ordboll_id	    integer PRIMARY KEY
      , maintainer_id       integer references iter_maintainers(maintainer_id)
      , num_boll_g          integer
      , num_boll_f1         integer
      , num_boll_f2         integer
      , num_boll_e          integer
      , consegna            char(1)
      , address_ass_posta   varchar(200)
      , city_ass_posta      varchar(40)
      , zipcode_ass_posta   varchar(5)
      , delegato            varchar(200)
      , delegato_comune_nas varchar(100)
      , delegato_data_nas   date
      , data_prenotazione   date
      , cod_prenotazione    varchar(20)
      , creation_user       integer references users(user_id)
      , creation_date       date
      , editing_user        integer references users(user_id)
      , editing_date        date
      , flag_evaso          boolean default 'f'
);

create sequence ordboll_seq start 1;

alter table coimboll add ordboll_id       integer references iter_ordboll(ordboll_id);

alter table coimtpbo add ultima_matricola integer;

CREATE TABLE iter_prot (
	prot_id	          integer PRIMARY KEY
      , modalita          char(1)
      , var_protocollo    varchar(20)
      , num_protocollo    varchar(20)
      , data_protocollo   date
      , data_documento    date
      , tipo_documento    varchar(2)
      , intestatario      varchar(200)
      , indirizzo         varchar(200)
      , comune            varchar(40)
      , cap               varchar(5)
      , note              text
      , id_tipo_documento integer references coimtdoc(id_tipo_documento)
      , mod_ricezione     char(1)
);

alter table iter_prot add id_tipo_documento integer references coimtdoc(id_tipo_documento);

create table coimtdoc (
        id_tipo_documento integer PRIMARY KEY
      , tipo_documento    varchar(2)
      , descrizione       varchar(100)
      , flag_modifica     char(1)
);

alter table coimfatt add data_scadenza date;
alter table coimfatt add data_pag date;
alter table coimfatt add importo_pag numeric(10,2);

-- TABELLE DI APPOGGIO PER CARICAMENTO FATTURE
create table coimfatt_2
     ( cod_fatt           varchar(08)  not null
     , data_fatt          date         not null
     , num_fatt           varchar(10)  not null
     , cod_sogg           varchar(08)
     , tipo_sogg          char(01)
     , imponibile         numeric(8,2)
     , perc_iva           numeric(5,2)
     , flag_pag           char(01)
     , matr_da            varchar(20)
     , matr_a             varchar(20)
     , n_bollini          integer
     , nota               varchar(4000)
     , mod_pag            varchar(400)
     , data_ins           date
     , data_mod           date 
     , id_utente          varchar(10)
     , desc_fatt          varchar(4000)
     , spe_legali         numeric(11,2)
     , spe_postali        numeric(11,2)
     , data_scadenza      date
     , data_pag           date
     , importo_pag        numeric(11,2)
);

create sequence coimfatt_2_s start 1;
create sequence coimboll_2_s start 1;

create table coimboll_2
     ( cod_bollini        varchar(8)   not null
     , cod_manutentore    varchar(8)   not null
     , data_consegna      date
     , nr_bollini         integer
     , matricola_da       varchar(20)
     , matricola_a        varchar(20)
     , pagati             char(1)
     , costo_unitario     numeric(6,2)
     , nr_bollini_resi    numeric(8,0)
     , note               varchar(4000)
     , data_ins           date
     , data_mod           date
     , utente             varchar(10)
     , data_scadenza      date
     , cod_tpbo           varchar(2)
     , imp_pagato         numeric(10,2)
     , imp_sconto         numeric(10,2)
     , cod_tpbl           varchar(8)
     , cod_fatt           varchar(8)
     , ordboll_id         integer
);

create table iter_maint_2 (
	maint_2_id	   integer PRIMARY KEY
      , name               varchar(200) NOT NULL
      , address1           varchar(200)
      , address2           varchar(40)
      , city               varchar(40)
      , province           varchar(4)
      , zipcode            varchar(5)
      , fiscal_code        varchar(16)
      , iva_code           varchar(11)
      , phone              varchar(50)
      , mobile             varchar(50)
      , email              varchar(256)
      , fax                varchar(50)
      , associated_to      varchar(200)
      , where_registered   varchar(40)
      , registration_no    varchar(50)
      , where_rea          varchar(40)
      , rea_no             varchar(15)
      , capital            numeric(11,2)
      , role               char(1) check (role in ('0', '1', '2'))
      , representative_id integer 
      , notes              text
      , lotto_no           numeric(18)
      , validated_p        boolean
      , validating_user    integer 
      , validating_date    date
      , iter_code          varchar(8)
      , company_type       varchar(4) 
      , is_active_p        boolean NOT NULL
      , creation_user      integer 
      , creation_date      date
      , editing_user       integer 
      , editing_date       date
      , op_number          integer
      , an_number          integer
      , de_number          integer
      , approved_p         boolean
      , cait_id            integer
      , wallet_id          varchar(18)
      , iban_code          varchar(27)
      , cc_name            varchar(100)
      , la boolean default 'f'
      , lb boolean default 'f'
      , lc boolean default 'f'
      , ld boolean default 'f'
      , le boolean default 'f'
      , lf boolean default 'f'
      , lg boolean default 'f'
      , uni_iso            varchar(100)
      , altre_certificazioni text
      , albo_artigiani     varchar(15)
);

alter table coimfatt add importo numeric(10,2);

commit;
