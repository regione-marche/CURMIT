
begin;

--l'upgrade aggiunge il paramentro login_cittadino_p e login_cohesion_marche_p

--gac01 15-20/02/2018 Aggiunti campi patentino per la regione Marche e aggiunto path_carta_identita
/*
alter table iter_operators add patentino boolean not null default 'f';            --gac01
alter table iter_operators add patentino_fgas boolean not null default 'f';       --gac01
alter table iter_parties add patentino boolean not null default 'f';              --gac01
alter table iter_parties add patentino_fgas boolean not null default 'f';         --gac01


alter table iter_parties add path_carta_identita varchar(250);

--gac01 29/05/2018 aggiunti campi carta di identità
alter table iter_parties add tipo_doc_identita varchar (100);
alter table iter_parties add num_doc_identita varchar (50);
alter table iter_parties add ente_rilascio_doc_identita varchar (100);
alter table iter_parties add data_rilascio_doc_identita date;
alter table iter_parties add data_fine_validita_doc_identita date;


--gac01 fine
drop view iter_maintainers_view;
create or replace view iter_maintainers_view as
 SELECT m.maintainer_id,
    m.name,
    m.address1,
    m.address2,
    m.city,
    m.province,
    m.zipcode,
    m.fiscal_code,
    m.iva_code,
    m.phone,
    m.mobile,
    m.email,
    m.fax,
    m.associated_to,
    m.where_registered,
    m.registration_no,
    m.where_rea,
    m.rea_no,
    m.capital,
    m.role,
    m.representative_id,
    m.notes,
    m.lotto_no,
    m.validated_p,
    m.validating_user,
    m.validating_date,
    m.iter_code,
    m.company_type,
    m.is_active_p,
    m.creation_user,
    m.creation_date,
    m.editing_user,
    m.editing_date,
    m.op_number,
    m.an_number,
    m.de_number,
    m.approved_p,
    m.cait_id,
    m.wallet_id,
    m.iban_code,
    m.cc_name,
    m.la,
    m.lb,
    m.lc,
    m.ld,
    m.le,
    m.lf,
    m.lg,
    m.uni_iso,
    m.altre_certificazioni,
    m.albo_artigiani,
    m.pec,
    m.patentino,
    m.patentino_fgas,
    ah_edit_num(m.op_number::double precision, 0) AS op_number_pretty,
    ah_edit_num(m.an_number::double precision, 0) AS an_number_pretty,
    ah_edit_num(m.de_number::double precision, 0) AS de_number_pretty,
    ah_edit_num(m.capital, 2) AS capital_pretty,
        CASE
            WHEN m.role = '0'::bpchar THEN 'Installatore'::text
            WHEN m.role = '0'::bpchar THEN 'Manutentore'::text
            ELSE 'Installatore/Manutentore'::text
        END AS role_pretty,
    p.name AS rep_name,
    p.first_name AS rep_first_name,
    p.address1 AS rep_address1,
    p.city AS rep_city,
    p.address2 AS rep_address2,
    p.province AS rep_province,
    p.zipcode AS rep_zipcode,
    p.fiscal_code AS rep_fiscal_code,
    p.patentino AS patentino_rapp, 
    p.patentino_fgas AS patentino_fgas_rapp,
    p.tipo_doc_identita,
    p.num_doc_identita,               
    p.ente_rilascio_doc_identita,     
    iter_edit_data(p.data_rilascio_doc_identita) as data_rilascio_doc_identita_pretty,     
    iter_edit_data(p.data_fine_validita_doc_identita) as data_fine_validita_doc_identita_pretty
    
   FROM iter_maintainers m,
    iter_parties p
  WHERE m.representative_id = p.party_id;

--Luca R. create e insert della tabella tipologie di impianto. --

create table iter_installation_types
     ( installation_type_id          integer        not null
     , installation_type_code        varchar(50)
     , installation_type_description varchar(250)	  
     );

create unique index iter_installation_types_00
    on iter_installation_types
     ( installation_type_id
     );

insert into iter_installation_types 
     values 
     	  ( 1
	  , 'CALDO_GAS_LIQ'
	  ,'Impianti dotati di gruppi termici o caldaie alimentati da combustibili gassosi o liquidi');

insert into iter_installation_types  
     values 
     	  ( 2
	  , 'CALDO_SOLIDI'
	  , 'Impianti dotati di gruppi termici o caldaie alimentati da combustibili solidi/biomasse legnose');

insert into iter_installation_types  
     values 
          ( 3
	  , 'FREDDO_SOLIDI_LIQ' 
	  , 'Impianti dotati di macchine frigorifere/pompe di calore non alimentate a gas');

insert into iter_installation_types  
     values 
      	  ( 4
	  , 'TELERISCALDAMENTO'
	  , 'Impianti di teleriscaldamento/teleraffrescamento');

insert into iter_installation_types  
     values 
          ( 5
	  , 'COGENERATORI'
	  , 'Cogeneratori/Trigeneratori');

insert into iter_installation_types 
     values 
     	  ( 6
	  , 'CAMPI_SOLARI'
	  , 'Campi solari termici');

insert into iter_installation_types  
     values 
     	  ( 7
	  , 'ALTRO'
	  , 'Altre tipologie di generatori');

insert into iter_installation_types
     values
          ( 8
	  , 'FREDDO_GAS'
          , 'Impianti dotati di macchine frigorifere/pompe di calore alimentate a gas'
	  ) ;


--Luca R. create della tabella iter_mantainer_installations 

Create table iter_maintainer_installations 
           ( maintainer_installations_id  integer  not null
           , maintainer_id                integer  not null
           , installation_type_id         integer  not null 
           , creation_user                integer               
           , creation_date                date
                   
);
create unique index iter_maintainer_installations_00
    on iter_maintainer_installations
     ( maintainer_installations_id
     );
create unique index iter_maintainer_installations_01
    on iter_maintainer_installations
     ( maintainer_id
     , installation_type_id
     );


--sim: Tabella per gestione del single sign-on
create table iter_login 
     ( utente          varchar(100)
     , data_last_login timestamp
     , token_code      varchar(100)
);

create unique index iter_login_00
    on iter_login 
     ( utente
     );
 

--l'upagrade crea il parametro dbname_portale




-- da lanciare una-tantum sulla Regione Marche
update iter_instances set descrizione = 'Comune di Ancona - dev'             where instance_name = 'itercman-dev';
update iter_instances set descrizione = 'Comune di Ascoli Piceno'            where instance_name = 'itercmap';
update iter_instances set descrizione = 'Comune di Civitanova Marche'        where instance_name = 'itercmcivitanovamarche';
update iter_instances set descrizione = 'Comune di Macerata'                 where instance_name = 'itercmmc';
update iter_instances set descrizione = 'Comune di San Benedetto del Tronto' where instance_name = 'itercmsanbenedettotronto';
update iter_instances set descrizione = 'Provincia di Ascoli Piceno'         where instance_name = 'iterprap';
update iter_instances set descrizione = 'Provincia di Fermo - dev'           where instance_name = 'iterprfm';
update iter_instances set descrizione = 'Provincia di Macerata'              where instance_name = 'iterprmc';


--Le seguenti tabelle vengono usate per gestire la chiamata a MPAY. Serviranno solo per la Regione Marche ma le tengo
--comunque per tutti

\i ../mpay_paymentrequest.sql

\i ../mpay_paymentdata.sql

\i ../mpay_enti_destinatari.sql

--gab01
alter table iter_maintainers add path_dichiaraz_dpr varchar(250);

--fine Mpay


--LucaR. 04/05/2018 
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

--LUCA R. 30/10/2018 
\i ../citizen_documents.sql

\i ../mpay_enti_portafogli_abilitati.sql
*/
end;
