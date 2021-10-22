/*==============================================================*/
/* table coimmanu: tabella dei manutentori                      */
/*==============================================================*/

create table coimmanu
     ( cod_manutentore     varchar(08)  not null
     , cognome             varchar(100)
     , nome                varchar(100)
     , indirizzo           varchar(40)
     , localita            varchar(40)
     , provincia           varchar(04)
     , cap                 varchar(05)
     , comune              varchar(40)
     , cod_fiscale         varchar(16)
     , cod_piva            varchar(16)
     , telefono            varchar(15)
     , cellulare           varchar(15)
     , fax                 varchar(15)
     , email               varchar(35)
     , reg_imprese         varchar(20)
     , localita_reg        varchar(40)
     , rea                 varchar(20)
     , localita_rea        varchar(40)
     , capit_sociale       numeric(11,2)
     , data_ins            date
     , data_mod            date
     , utente              varchar(10)
     , note                varchar(4000)
     , flag_convenzionato  char(01)
     , prot_convenzione    varchar(25)
     , prot_convenzione_dt date
     , flag_ruolo          char(01)
     , data_inizio         date
     , data_fine           date
     , cod_legale_rapp     varchar(08)
     , flag_a              character(1)
     , flag_b              character(1)
     , flag_c              character(1)
     , flag_d              character(1)
     , flag_e              character(1)
     , flag_f              character(1)
     , flag_g              character(1)
     , cert_uni_iso        varchar(100)
     , cert_altro          varchar(4000)
     , pec                 varchar(150)
     , wallet_id           varchar(18)
     , iban_code           varchar(27)
     , patentino           boolean       not null default 'f'
     , patentino_fgas      boolean       not null default 'f'
     );

create unique index coimmanu_00
    on coimmanu
     ( cod_manutentore
     );
