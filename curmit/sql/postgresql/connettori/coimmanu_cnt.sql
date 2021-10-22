/*==============================================================*/
/* table coimmanu_cnt: tabella dei manutentori                      */
/*==============================================================*/

create table coimmanu_cnt
     ( cod_manutentore     varchar(08)  not null
     , cognome             varchar(40)
     , nome                varchar(40)
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
     , reg_imprese         varchar(15)
     , localita_reg        varchar(40)
     , rea                 varchar(15)
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
     );

create unique index coimmanu_cnt_00
    on coimmanu_cnt
     ( cod_manutentore
     );
