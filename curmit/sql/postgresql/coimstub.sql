/*==============================================================*/
/* table coimstub: tabella delle persone di riferimento         */
/*==============================================================*/

create table coimstub
     ( cod_impianto     varchar(08)  not null 
     , data_fin_valid   date         not null 
     , cod_ubicazione   varchar(08) 
     , localita         varchar(40)
     , cod_via          varchar(08) 
     , toponimo         varchar(20)
     , indirizzo        varchar(100)
     , numero           varchar(20)
     , esponente        varchar(03)
     , scala            varchar(05)
     , piano            varchar(05)
     , interno          varchar(03)
     , cod_comune       varchar(08)
     , cod_provincia    varchar(08)
     , cap              varchar(05)
     , cod_catasto      varchar(20)
     , cod_tpdu         varchar(08)
     , cod_qua          varchar(08)
     , cod_urb          varchar(08)
     , data_ins         date
     , data_mod         date
     , utente           varchar(10)  
     );

create unique index coimstub_00
    on coimstub
     ( cod_impianto
     , data_fin_valid
     );

