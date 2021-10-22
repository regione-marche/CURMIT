/*==============================================================*/
/* table coimboll: tabella blocchetti bollini per manutentore   */
/*==============================================================*/

create table coimboll
     ( cod_bollini       integer      not null
     , cod_manutentore   varchar(08)  not null
     , data_consegna     date
     , nr_bollini        numeric(08)  
     , matricola_da      varchar(20)
     , matricola_a       varchar(20)
     , pagati            char(01)     -- bollini pagati s/n
     , costo_unitario    numeric(6,2)
     , nr_bollini_resi   numeric(08)
     , note              varchar(4000)
     , data_ins          date
     , data_mod          date
     , utente            varchar(10)
     , data_scadenza     date
     , cod_tpbo          varchar(02)
     , imp_pagato        numeric(10,2)
     , imp_sconto        numeric(10,2)
     , cod_tpbl          varchar(08)
     , cod_fatt          varchar(08)
     , mod_pag           varchar(100)
     , data_pag          date         -- 2014-06-07 (Sandro)
     , perc_iva          numeric(5,2)
     );

create unique index coimboll_00
    on coimboll
     ( cod_bollini
     );

create        index coimboll_01
    on coimboll
     ( cod_manutentore
     , data_consegna
     );
