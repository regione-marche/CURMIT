/*==============================================================*/
/* table coimmanu: tabella ditte manutentrici                   */
/*==============================================================*/

create table coimmanu
     ( cod_manutentore     varchar2(08)  not null
     , cognome             varchar2(40)
     , nome                varchar2(40)
     , indirizzo           varchar2(40)
     , localita            varchar2(40)
     , provincia           varchar2(04)
     , cap                 varchar2(05)
     , comune              varchar2(40)
     , cod_fiscale         varchar2(16)
     , cod_piva            varchar2(16)
     , telefono            varchar2(15)
     , cellulare           varchar2(15)
     , fax                 varchar2(15)
     , email               varchar2(35)
     , reg_imprese         varchar2(20)
     , localita_reg        varchar2(40)
     , rea                 varchar2(20)
     , localita_rea        varchar2(40)
     , capit_sociale       number(11,2)
     , data_ins            date
     , data_mod            date
     , utente              varchar2(10)
     , note                varchar2(4000)
     , flag_convenzionato  char(01)
     , prot_convenzione    varchar2(25)
     , prot_convenzione_dt date
     , flag_ruolo          char(01)
     , data_inizio         date
     , data_fine           date
     , pec                 varchar2(150)
     , wallet_id           varchar(18)
     , iban_code           varchar(27)
     , patentino           boolean       not null default 'f'
     ) tablespace &ts_dat;

create unique index coimmanu_00
    on coimmanu
     ( cod_manutentore
     ) tablespace &ts_idx;
