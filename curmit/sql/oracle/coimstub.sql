/*==============================================================*/
/* table coimstub: tabella delle persone di riferimento         */
/*==============================================================*/

create table coimstub
     ( cod_impianto     varchar2(08)  not null 
     , data_fin_valid   date          not null 
     , cod_ubicazione   varchar2(08) 
     , localita         varchar2(40)
     , cod_via          varchar2(08)
     , toponimo         varchar2(20)
     , indirizzo        varchar2(100)
     , numero           varchar2(08)
     , esponente        varchar2(03)
     , scala            varchar2(05)
     , piano            varchar2(05)
     , interno          varchar2(03)
     , cod_comune       varchar2(08)
     , cod_provincia    varchar2(08)
     , cap              varchar2(05)
     , cod_catasto      varchar2(20)
     , cod_tpdu         varchar2(08)
     , cod_qua          varchar2(08)
     , cod_urb          varchar2(08)
     , data_ins         date
     , data_mod         date
     , utente           varchar2(10)  
     )  tablespace &ts_dat;

create unique index coimstub_00
    on coimstub
     ( cod_impianto
     , data_fin_valid
     ) tablespace &ts_idx;

