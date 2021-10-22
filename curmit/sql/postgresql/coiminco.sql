/*===============================================================*/
/* table coiminco: incontri                                      */
/*===============================================================*/
create table coiminco
     ( cod_inco           varchar(08)  not null
     , cod_cinc           varchar(08)  
     , tipo_estrazione    varchar(08)
     , cod_impianto       varchar(08)
     , data_estrazione    date
     , data_assegn        date
     , cod_opve           varchar(08)
     , data_verifica      date
     , ora_verifica       varchar(08)
     , data_avviso_01     date
     , cod_documento_01   varchar(08)
     , data_avviso_02     date
     , cod_documento_02   varchar(08)
     , stato              char(01)
     , esito              char(01)
     , note               varchar(4000)
     , data_ins           date
     , data_mod           date
     , utente             varchar(10)
     , tipo_lettera       char(01)
     , cod_noin           varchar(08)
     );

create unique index coiminco_00
    on coiminco
     ( cod_inco
     ) ;

create index coiminco_01
    on coiminco
     ( cod_impianto
     , data_estrazione
     ) ;

create unique index coiminco_02
    on coiminco
     ( cod_cinc
     , cod_inco
     ) ;

create index coiminco_03
    on coiminco
     ( cod_opve
     , cod_impianto
     ) ;

