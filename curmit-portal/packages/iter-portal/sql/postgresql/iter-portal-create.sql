begin;

--LucaR. 04/05/2018 aggiunta tabella per i cittadini che si registrano sul portale.
 create table iter_citizens (
              citizen_id          integer not null
            , legal_nature        char(1)
            , last_name           varchar(100)
            , first_name          varchar(100)
            , address1            varchar(100)
            , number              varchar(8)
            , cap                 varchar(5)
            , address2            varchar(40)
            , city                varchar(40) 
            , province            varchar(4)
            , fiscal_code         varchar(16) not null
            , cod_piva            varchar(16)
            , phone               varchar(15)
            , mobile              varchar(15)
            , fax                 varchar(15)
            , email               varchar(100)
            , born_date           date
            , born_city           varchar(40)
            , creation_user       varchar(10)
            , creation_date       date 
            , editing_date        date
            , editing_user        varchar(10)
            , notes               varchar(400)
            , born_state          varchar(8)
            , sex                 char(1)
            , pec                 varchar(35)
) ;

create unique index iter_citizens_00
    on iter_citizens
     ( citizen_id
     );
create unique index iter_citizens_01
    on iter_citizens
     ( citizen_id
     , fiscal_code
     ) ;	   

-- soggetti
CREATE TABLE iter_parties (
	party_id	 integer PRIMARY KEY
      , name             varchar(200) NOT NULL
      , first_name       varchar(100)
      , address1         varchar(200)
      , address2         varchar(40)
      , city             varchar(40)
      , province         varchar(4)
      , zipcode          varchar(5)
      , fiscal_code      varchar(16)
      , creation_user    integer references users(user_id)
      , creation_date    date
      , editing_user     integer references users(user_id)
      , editing_date     date
);

comment on table iter_parties is '
Tabella dei soggetti legati ad Iter.
';

-- CAIT
CREATE TABLE iter_cait (

	cait_id	 integer PRIMARY KEY -- references users(user_id) 

      -- dati anagrafici e contatto
      , name             varchar(200) NOT NULL
      , address1         varchar(200)
      , address2         varchar(40)
      , city             varchar(40)
      , province         varchar(4)
      , zipcode          varchar(5)
      , fiscal_code      varchar(16)
      , iva_code         varchar(11)
      , phone            varchar(50)
      , mobile           varchar(50)
      , email            varchar(256) NOT NULL
      , fax              varchar(50)
      , notes            text
      , creation_user    integer references users(user_id)
      , creation_date    date
      , editing_user     integer references users(user_id)
      , editing_date     date
      , iban_code          varchar(27)
      , cc_name            varchar(100)
);

-- manutentori
CREATE TABLE iter_maintainers (

	maintainer_id	 integer PRIMARY KEY -- references users(user_id) 

      -- dati anagrafici e contatto
      , name             varchar(200) NOT NULL
      , address1         varchar(200)
      , address2         varchar(40)
      , city             varchar(40)
      , province         varchar(4)
      , zipcode          varchar(5)
      , fiscal_code      varchar(16)
      , iva_code         varchar(11)
      , phone            varchar(50)
      , mobile           varchar(50)
      , email            varchar(256) NOT NULL
      , fax              varchar(50)

      -- registri e associazioni
      , associated_to    varchar(200)
      , where_registered varchar(40)
      , registration_no  varchar(50)
      , where_rea        varchar(40)
      , rea_no           varchar(15)
      , capital          numeric(11,2)

      -- 0=Installatore 1=Manutentore 2=Installatore/manutentore
      , role             char(1) check (role in ('0', '1', '2'))
      , representative_id integer references iter_parties(party_id)
      , notes            text

      -- i dati seguenti devono essere compilati dal responsabile della validazione
      , lotto_no         numeric(18)
      , validated_p      boolean
      , validating_user  integer references users(user_id)
      , validating_date  date
      , iter_code        varchar(8)

      -- soc, srl, spa, sapa, snc, sas, coop
      , company_type     varchar(4) 
      , is_active_p      boolean NOT NULL
      , creation_user    integer references users(user_id)
      , creation_date    date
      , editing_user     integer references users(user_id)
      , editing_date     date

      -- numero di operatori dichiarati
      , op_number        integer
      -- numero di analizzatori di combustione dichiarati
      , an_number        integer
      -- numero di deprimometri dichiarati
      , de_number        integer
      -- flag di conferma da parte del manutentore
      , approved_p       boolean
      , cait_id          integer references iter_cait(cait_id)

      -- id portafoglio Lottomatica formato da:
        -- 4 digit identificativi di Curit (0001)
        -- 6 digit identificativi del soggetto (da 3 a 8 di iter_code)
        -- 8 digit random
      , wallet_id          varchar(18)
      -- Codice IBAN per l'alimentazione del portafoglio tramite Bonifico formato da
        -- 2 digit codice paese
        -- 2 digit codice di controllo
        -- 1 digit CIN
        -- 5 digit ABI
        -- 5 digit CAB
        -- 12 digit Conto Corrente 
      , iban_code          varchar(27)
      , cc_name            varchar(100)

      -- impianti su cui il manutentore è abilitato ad operare
      , la boolean default 'f'
      , lb boolean default 'f'
      , lc boolean default 'f'
      , ld boolean default 'f'
      , le boolean default 'f'
      , lf boolean default 'f'
      , lg boolean default 'f'

      -- requisiti ulteriori in possesso del manutentore
      , uni_iso varchar(100)
      , altre_certificazioni text
      , albo_artigiani varchar(15)

      , pec            varchar(150)                 -- 14/06/2016
      , patentino      boolean not null default 'f' -- 08/08/2016
      , path_dichiaraz_dpr varchar(250)             -- 17/04/2018
);

create index iter_maintainers_fiscal_code_index on iter_maintainers(fiscal_code); 
create index iter_maintainers_iva_code_index    on iter_maintainers(iva_code); 

comment on table iter_maintainers is '
Tabella dei manutentori di ITER.
E'' un''estensione della tabella users, di cui condivide la primary key.
';

comment on column iter_maintainers.role is '
Valori possibili: 0=Installatore 1=Manutentore 2=Installatore/Manutentore
';

comment on column iter_maintainers.wallet_id is '
id portafoglio Lottomatica formato da:
  4 digit identificativi di Curit (valore fisso 0001)
  6 digit identificativi del soggetto (da 3 a 8 di iter_code)
  8 digit random
';

create view iter_maintainers_view as
        select m.*, 
               ah_edit_num(op_number, 0) as op_number_pretty, 
               ah_edit_num(an_number, 0) as an_number_pretty, 
               ah_edit_num(de_number, 0) as de_number_pretty, 
               ah_edit_num(capital, 2) as capital_pretty, 
               case 
                 when m.role = '0' then 'Installatore' 
                 when m.role = '0' then 'Manutentore' 
                 else 'Installatore/Manutentore' 
               end as role_pretty, 
               p.name as rep_name, 
               p.first_name as rep_first_name, 
               p.address1 as rep_address1, 
               p.city as rep_city, 
               p.address2 as rep_address2, 
               p.province as rep_province, 
               p.zipcode as rep_zipcode, 
               p.fiscal_code as rep_fiscal_code
          from iter_maintainers m
             , iter_parties     p
         where m.representative_id = p.party_id;


-- operatori
create sequence iter_operators_seq start 1;

CREATE TABLE iter_operators (
	operator_id	 integer PRIMARY KEY
      , maintainer_id    integer NOT NULL references iter_maintainers(maintainer_id)
      , name             varchar(200) NOT NULL
      , first_name       varchar(100)
      , no               varchar(50)
      , iter_no          varchar(16) 
      , phone            varchar(50)
      , mobile           varchar(50)
      , address          varchar(200)
      , is_active_p      boolean NOT NULL
      , fiscal_code      varchar(16)
      -- 0=Tecnico 1=Segreteria
      , role             char(1) check (role in ('0', '1'))
      , notes            text
      , password         varchar(10)
);

create index iter_operators_fiscal_code_index on iter_operators(fiscal_code); 

comment on table iter_operators is '
Tabella degli operatori di un dato manutentore di ITER.
';

comment on column iter_operators.role is '
Valori possibili: 0=Tecnico 1=Segreteria
';

-- strumenti manutentori
CREATE TABLE iter_tools (
	tool_id	 integer PRIMARY KEY
      -- 0=Analizzatori di Combustione 1=Deprimometri
      , type             char(1) check (type in ('0', '1'))
      , maintainer_id    integer NOT NULL references iter_maintainers(maintainer_id)
      , brand            varchar(200)
      , model            varchar(200)
      , no               varchar(200)
      , last_calibration_date  date
      , creation_user    integer references users(user_id)
      , creation_date    date
      , editing_user     integer references users(user_id)
      , editing_date     date
);

comment on table iter_tools is '
Tabella degli strumenti utilizzati dai manutentori.
';

comment on column iter_tools.type is '
Valori possibili: 0=Analizzatori di Combustione 1=Deprimometri
';

-- Distributori di carburante
CREATE TABLE iter_distributors (

	distributor_id	  integer PRIMARY KEY references users(user_id) 

      -- dati anagrafici e contatto
      , name              varchar(200) NOT NULL
      , representative_id integer references iter_parties(party_id)
      , address1          varchar(200)
      , address2          varchar(40)
      , city              varchar(40)
      , province          varchar(4)
      , zipcode           varchar(5)
      , fiscal_code       varchar(16)
      , iva_code          varchar(11)
      , phone             varchar(50)
      , mobile            varchar(50)
      , email             varchar(256) NOT NULL
      , fax               varchar(50)
      , notes             text
      , creation_date     date
      , editing_user      integer references users(user_id)
      , editing_date      date
);

-- forniture dei Distributori
create table iter_distributors_supplies (
      distributor_id       integer not null
    , supply_id            integer not null
    , foreign key (distributor_id, supply_id) references attachments(object_id, item_id)
    , supply_date          date
    -- Ente di competenza
    , body_id              integer not null references groups(group_id)
    , user_name            varchar(200) 
    , topo_type            varchar(20)
    , topo_name            varchar(100) 
    , number               varchar(10) 
    , zip_code             integer
    , city                 varchar(100) 
    , istat                varchar(9) 
    , phone                varchar(100)  
    , user_fuel            varchar(50) 
    , return_point         varchar(50) 
    , consumption          numeric(11, 2)
    , um_code              varchar(2)
    , contract             varchar(2) 
    , volume               numeric(11, 2)
    , fiscal_code          varchar(16) 
    , iva_code             varchar(11) 
);

create index iter_distributors_supplies_body_index on iter_distributors_supplies(body_id);
create index iter_distributors_supplies_city_index on iter_distributors_supplies(city);

-- Studi associati degli amministratori di condominio
CREATE TABLE iter_offices (

	office_id	 integer PRIMARY KEY -- references users(user_id) 

      -- dati anagrafici e contatto
      , name             varchar(200) NOT NULL
      , address1         varchar(200)
      , address2         varchar(40)
      , city             varchar(40)
      , province         varchar(4)
      , zipcode          varchar(5)
      , fiscal_code      varchar(16)
      , iva_code         varchar(11)
      , phone            varchar(50)
      , mobile           varchar(50)
      , email            varchar(256) NOT NULL
      , fax              varchar(50)
      , notes            text
      , creation_user    integer references users(user_id)
      , creation_date    date
      , editing_user     integer references users(user_id)
      , editing_date     date
      , iban_code          varchar(27)
      , cc_name            varchar(100)
);

-- amministratori di condominio
CREATE TABLE iter_trustees (

	trustee_id	 integer PRIMARY KEY -- references users(user_id) 

      -- dati anagrafici e contatto
      , name             varchar(200) NOT NULL
      , first_name       varchar(200)
      , address1         varchar(200)
      , address2         varchar(40)
      , city             varchar(40)
      , province         varchar(4)
      , zipcode          varchar(5)
      -- 0=Giuridica 1=Fisica
      , jtype            char(1) check (jtype in ('0', '1'))
      , fiscal_code      varchar(16)
      , iva_code         varchar(11)
      , phone            varchar(50)
      , mobile           varchar(50)
      , email            varchar(256) NOT NULL
      , fax              varchar(50)

      , validated_p      boolean
      , validating_user  integer references users(user_id)
      , validating_date  date
      , iter_code        varchar(8)
      , is_active_p      boolean NOT NULL
      , creation_user    integer references users(user_id)
      , creation_date    date
      , editing_user     integer references users(user_id)
      , editing_date     date
      , approved_p       boolean
      , notes            text
      , password         varchar(10)

      -- id portafoglio Lottomatica formato da:
        -- 4 digit identificativi di Curit (0001)
        -- 6 digit identificativi del soggetto (da 3 a 8 di iter_code)
        -- 8 digit random
      , wallet_id          varchar(18)
      -- Codice IBAN per l'alimentazione del portafoglio tramite Bonifico formato da
        -- 2 digit codice paese
        -- 2 digit codice di controllo
        -- 1 digit CIN
        -- 5 digit ABI
        -- 5 digit CAB
        -- 12 digit Conto Corrente 
      , iban_code          varchar(27)
      , cc_name            varchar(100)
      -- eventuale studio associato
      , office_id          integer references iter_offices(office_id)
);

-- aziende incaricate della ispezione
CREATE TABLE iter_inspecting_companies (

	company_id	 integer PRIMARY KEY -- references users(user_id) 

      -- dati anagrafici e contatto
      , name             varchar(200) NOT NULL
      , address1         varchar(200)
      , address2         varchar(40)
      , city             varchar(40)
      , province         varchar(4)
      , zipcode          varchar(5)
      , fiscal_code      varchar(16)
      , iva_code         varchar(11)
      , phone            varchar(50)
      , mobile           varchar(50)
      , email            varchar(256) NOT NULL
      , fax              varchar(50)
      , notes            text
      , creation_user    integer references users(user_id)
      , creation_date    date
      , editing_user     integer references users(user_id)
      , editing_date     date
);

-- ispettori / verificatori
CREATE TABLE iter_inspectors (

	inspector_id	 integer PRIMARY KEY -- references users(user_id) 

      -- dati anagrafici e contatto
      , name             varchar(200) NOT NULL
      , first_name       varchar(200)
      , address1         varchar(200)
      , address2         varchar(40)
      , city             varchar(40)
      , province         varchar(4)
      , zipcode          varchar(5)
      , fiscal_code      varchar(16)
      , iva_code         varchar(11)
      , phone            varchar(50)
      , mobile           varchar(50)
      , email            varchar(256) NOT NULL
      , fax              varchar(50)
      -- tipo corso formazione E=Enea L=Ente Locale
      , course_type      char(1) check (course_type in ('E', 'L'))
      , course_resp      varchar(200)
      , course_certif    varchar(30)
      , validated_p      boolean
      , validating_user  integer references users(user_id)
      , validating_date  date
      , iter_code        varchar(8)
      , is_active_p      boolean NOT NULL
      , creation_user    integer references users(user_id)
      , creation_date    date
      , editing_user     integer references users(user_id)
      , editing_date     date
      , approved_p       boolean
      , notes            text
      , password         varchar(10)
      , company_id       integer references iter_inspecting_companies(company_id) 
);


-- strumenti ispettori
CREATE TABLE iter_inspectors_tools (
	tool_id	 integer PRIMARY KEY
      -- 0=Analizzatori di Combustione 1=Deprimometri
      , type             char(1) check (type in ('0', '1'))
      , inspector_id     integer NOT NULL references iter_inspectors(inspector_id)
      , brand            varchar(200)
      , model            varchar(200)
      , no               varchar(200)
      , last_calibration_date  date
      , creation_user    integer references users(user_id)
      , creation_date    date
      , editing_user     integer references users(user_id)
      , editing_date     date
);

-- Enti
-- I dati degli Enti sono gestiti tramite le tabelle 'groups' e 'parties' di OpenACS

-- mapping fra Enti e ispettori
create table iter_bodies_inspectors_map ( 
	  map_id		integer primary key
	, body_id        	integer not null references groups(group_id)
	, inspector_id      	integer not null references iter_inspectors(inspector_id)
        -- se presente indica che l'Ente ha incaricato l'azienda
        , company_id            integer references iter_inspecting_companies(company_id) 
        , is_active_p           boolean 
);

create unique index iter_bodies_inspectors_map_index on iter_bodies_inspectors_map(body_id, inspector_id);

-- Tabella Comuni
create table iter_comuni (
      id_comune        integer not null primary key
     ,cod_comune       varchar(08) not null
     ,cod_provincia    varchar(08) not null
     ,denominazione    varchar(40) not null
     ,flag_val         char(01)    check (flag_val in ('T', 'F'))
     ,cap              varchar(05)
     ,id_belfiore      varchar(04)
     ,cod_istat        varchar(07)
     ,popolaz_citt     numeric(07)
     ,popolaz_aimp     numeric(07)
     ,progressivo      numeric(07)
     -- ente responsabile
     ,body_id          integer     not null references groups(group_id)
  );

-- Istanze
create table iter_instances ( 
	  instance_id	 	integer primary key
	, instance_name  	varchar(40) not null
);

-- Manutentori da bonificare
create table iter_maintainers_to_adjust (
	  maintainers_adj_id    integer primary key
        , iter_code             varchar(8)  not null
	, password              varchar(8)
	, instance_name  	varchar(40) not null
	, f_one_time            boolean
	, one_time_date         date
	, one_time_user         integer references users(user_id)
);
 
-- ordini bollini
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

-- protocolli
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

-- ricreata la tabella dei tipi documento assegnandogli un id
create table coimtdoc (
        id_tipo_documento integer PRIMARY KEY
      , tipo_documento    varchar(2)
      , descrizione       varchar(100)
      , flag_modifica     char(1)
);


-- ======================================================================
-- ( 13.06.2013 - Nelson ) Tabella documenti collegati ad un protocollo )
-- ======================================================================

create sequence iterprotdocu_s start 1;

create table iterprotdocu (
  id_documento         integer    not null primary key,
  prot_id              integer    not null references iter_prot,
  tipo_doc             integer    not null,
  oggetto	       text,
  stato                char(1)    not null default 'N',
  check (stato in ('N', 'S', 'A')),
  -- N=nascente, S=spedito, A=annullato
  id_num_protocollo    varchar(25),
  -- id_protocollo: protocollo generale attribuito al documento
  protocollo_dt        date,
  -- protocollo_dt: data di protocollazione del documento
  referente            varchar(50),
  -- referente: persona dell'ufficio a cui fare riferimento  
  documento            oid,
  estensione           char(30),
  data_ora_generazione timestamp,
  data_ultimamodifica  date,
  path                 varchar(255),
  -- frammento html che rappresenta la stampa prima del consolidamento
  html                 text,
  flag_attivo          boolean not null default 't',
  utente_inserimento   varchar(20),
  data_inserimento     date
);

create unique index iterprotdocu_idx_01 on iterprotdocu (prot_id,id_documento);
create unique index iterprotdocu_idx_03 on iterprotdocu (tipo_doc,id_documento);


-- Storico rappresentanti legali delle ditte di manutenzione
create table iter_hist_representatives
     ( hist_representative_id integer   not null primary key
     , maintainer_id         integer   not null references iter_maintainers(maintainer_id)
    -- end_date = data fine validità
     , end_date              date      not null
     , representative_id     integer   not null references iter_parties(party_id)
     , creation_user         integer            references users(user_id)
     , creation_timestamp    timestamp not null default current_timestamp
     , editing_user          integer            references users(user_id)
     , editing_timestamp     timestamp
     );

create unique index iter_hist_representatives_idx_01
    on iter_hist_representatives
     ( maintainer_id
     , end_date
     );

comment on table iter_hist_representatives is 'Tabella di storico rappresentanti legali delle ditte di manutenzione';

comment on column iter_hist_representatives.end_date is 'Data fine validità';

\i coimlott.sql
\i coimplic.sql
\i coimtarg.sql
\i iter_ordtarg.sql



end;
