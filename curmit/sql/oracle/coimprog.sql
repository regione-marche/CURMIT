/*==============================================================*/
/* table coimmanu: tabella progettisti                          */
/*==============================================================*/

create table coimprog
     ( cod_progettista  varchar2(08)  not null
     , cognome          varchar2(40)
     , nome             varchar2(40)
     , indirizzo        varchar2(40)
     , localita         varchar2(40)
     , provincia        varchar2(04)
     , cap              varchar2(05)
     , comune           varchar2(40)
     , cod_fiscale      varchar2(16)
     , cod_piva         varchar2(16)
     , telefono         varchar2(15)
     , cellulare        varchar2(15)
     , fax              varchar2(15)
     , email            varchar2(35)
     , reg_imprese      varchar2(15)
     , localita_reg     varchar2(40)
     , rea              varchar2(15)
     , localita_rea     varchar2(40)
     , capit_sociale    number(11,2)
     , data_ins         date
     , data_mod         date
     , utente           varchar2(10)
     , note             varchar2(4000)
     ) tablespace &ts_dat;

create unique index coimprog_00
    on coimprog
     ( cod_progettista
     ) tablespace &ts_idx;
