
/*==============================================================*/
/*but01  table iter_supplies_sync: tebella di forniture 
but01     MEV4 Regione Marche Punto 1 */
/*==============================================================*/

create table iter_supplies_sync (
      supply_id            integer primary key
    , distributor_id       integer references iter_distributors (distributor_id)
    , item_id              integer
    , anno_rif             varchar(20)
    , natura_giurid        varchar(100)
    , utente_cogn_rag_soc  varchar(100)
    , utente_nome          varchar(100)
    , utente_cf            varchar(100)
    , utente_piva          varchar(100)
    , toponimo_tipo        varchar(100)
    , toponimo_nome        varchar(100)
    , toponimo_civico      varchar(10) --integer
    , toponimo_cap         integer
    , comune_nome          varchar(100)
    , comune_istat         varchar(20)
    , catasto_sezione      varchar(100)
    , catasto_foglio       varchar(100)
    , catasto_particella   varchar(100)
    , catasto_subalterno   varchar(100)
    , pdr                  varchar(20)
    , pod                  varchar(20)
    , stato_pdr            varchar(20)
    , matr_contatore       varchar(20)
    , contratto_tipo       varchar(20)
    , combustibile_tipo    integer --varchar(20)
    , combustibile_consumo varchar(20)
    , combustibile_um      integer
    , combustibile_anno    varchar(20)
    , data_ins             date
  );
