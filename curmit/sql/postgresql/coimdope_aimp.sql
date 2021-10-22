--===========================================================================================
-- table coimdope_aimp: Tabella delle dichiarazioni di frequenza e di elenco operazioni di
--                      controllo e manutenzione dell'impianto
--===========================================================================================

create table coimdope_aimp
( cod_dope_aimp		integer      not null
, cod_impianto          varchar(08)
, flag_tipo_impianto    char(01)     -- R=Riscaldamento, F=Raffreddamento 
, cognome_dichiarante   varchar(100)
, nome_dichiarante      varchar(100)
, flag_dichiarante      char(01)     -- L=Legale rappresentante, R=Responsabile tecnico
, cod_manutentore       varchar(08)  -- Ditta di Manutenzione

, flag_tipo_tecnico     char(01)     -- In qualita' di I=Installatore, M=Manutentore

, cod_utgi              varchar(08)  -- Destinazione d'uso dell'impianto -- per storicizzare
, pot_nom_risc          numeric(9,2) -- Questi campi servono per storicizzare quanto dichiarato
, pot_nom_raff          numeric(9,2) -- ""
, num_generatori	numeric(08)  -- ""
, cod_combustibile      varchar(08)  -- ""
, toponimo              varchar(20)  -- ""
, indirizzo             varchar(100) -- ""
, cod_via               varchar(08)  -- ""
, localita              varchar(40)  -- ""
, numero                varchar(08)  -- ""
, esponente             varchar(03)  -- "" 
, scala                 varchar(05)  -- ""
, piano                 varchar(05)  -- "" 
, interno               varchar(05)  -- "" 
, cod_comune            varchar(08)  -- "" 
, cod_distr             varchar(08)  -- Distributore di energia
, cod_responsabile      varchar(08)  -- ""
, flag_resp             char(01)     -- O=Occupante, P=Proprietario, A=Amministratore, T=Terzo responsabile
, flag_doc_tecnica      boolean not null default 'f'
, flag_istr_tecniche    boolean not null default 'f'
, flag_man_tecnici      boolean not null default 'f'
, flag_reg_locali       boolean not null default 'f'
, flag_norme_uni_cei    boolean not null default 'f'
, altri_doc             varchar(400)
, data_dich             date

, data_ins		date	   	not null default current_date
, utente_ins		varchar(10)
, data_mod		date
, utente_mod		varchar(10)

, cod_documento         varchar(08)   -- Serve per salvare la stampa sulla coimdocu
);

create unique index coimdope_aimp_00
    on coimdope_aimp
     ( cod_dope_aimp
     );

create index coimdope_aimp_01
    on coimdope_aimp
     ( cod_impianto
     );

create index coimdope_aimp_02
    on coimdope_aimp
     ( cod_manutentore
     );

