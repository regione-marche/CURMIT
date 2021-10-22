/*==============================================================*/
/* table coimboll: tabella blocchetti bollini per manutentore   */
/*==============================================================*/

create table coimboll
     ( cod_bollini       integer      not null
     , cod_manutentore   varchar2(08)  not null
     , data_consegna     date
     , nr_bollini        number(08)  
     , matricola_da      varchar2(20)
     , matricola_a       varchar2(20)
     , pagati            char(01)     -- bollini pagati s/n
     , costo_unitario    number(6,2)
     , nr_bollini_resi   number(08)
     , note              varchar2(4000)
     , data_ins          date
     , data_mod          date
     , utente            varchar2(10)
     , data_scadenza     date
     , cod_tpbo          varchar2(02)
     , imp_pagato        number(10,2)
     , imp_sconto        number(10,2)
     , cod_tpbl          varchar2(08) 
     , cod_fatt          varchar2(08)
     , mod_pag           varchar2(100)
     , data_pag          date         -- 2014-06-07 (Sandro)
     ) tablespace &ts_dat;

create unique index coimboll_00
    on coimboll
     ( cod_bollini
     ) tablespace &ts_idx;

create        index coimboll_01
    on coimboll
     ( cod_manutentore
     , data_consegna
     ) tablespace &ts_idx;
