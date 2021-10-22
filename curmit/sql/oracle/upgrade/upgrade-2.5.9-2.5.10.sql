-- Nicola e Simone 28/05/2014 per adeguamento al dpr74
-- Sono tutte alter fatte da Sandro su iter-dev che vanno propagate agli altri clienti

begin;

alter table coimaimp rename column cod_catasto to foglio;

-- creo la primary key su tabella coimcaus
alter table coimcaus
  add constraint coimcaus_pkey
      primary key (id_caus);

--aggiungo colonne a tabella coimcimp
alter table coimcimp add data_284       date;
alter table coimcimp add flag_pres_284  char(01);
alter table coimcimp add flag_comp_284	char(01); 

--creo tabella coimcout
-- Tabella dei comuni associati ad un utente
\i ../coimcout.sql

-- creo tabella coimflre: anagrafica fluidi refrigeranti
\i ../coimflre.sql

--aggiungo campi a tabella coimfatt
alter table coimfatt add desc_fatt	 varchar(4000);  
alter table coimfatt add spe_legali	 numeric(11,2);
alter table coimfatt add spe_postali 	 numeric(11,2);
alter table coimfatt add estr_pag 	 varchar(8);

--aggiungo campi a tabella coimrfis
alter table coimrfis add desc_fatt	 varchar(4000);  
alter table coimrfis add spe_legali	 numeric(11,2);
alter table coimrfis add spe_postali 	 numeric(11,2);
alter table coimrfis add estr_pag 	 varchar(8);

--aggiungo campo alla tabella coimtgen
alter table coimtgen add numincora       integer;

--aggiungo campi a tabella coimgend
alter table coimgend add cod_tpco    	      	 varchar(08);
alter table coimgend add cod_flre		 varchar(08);
alter table coimgend add carica_refrigerante	 numeric(10,2);
alter table coimgend add sigillatura_carica 	 char(01); 
alter table coimgend add cod_mode                integer;
alter table coimgend add cod_mode_bruc           integer;

--aggiungo campi a tabella coimtpbo
alter table coimtpbo add data_fine_valid	 date;
alter table coimtpbo add cod_potenza		 varchar(08);

-- creo tabella coimtpco tabella anagrafica tipi condizionatore
\i ../coimtpco.sql

create sequence coimtpco_s start 1;
-- Eseguo comunque la setval nel caso qualche cliente abbia già la tabella coimtpco
-- ma non la sequence coimtpco_s
select setval('coimtpco_s',max(to_number(cod_tpco,99999990))::bigint) from coimtpco;


end;
