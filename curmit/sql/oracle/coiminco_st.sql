/*===============================================================*/
/* table coiminco_st: incontri                                      */
/*===============================================================*/
create table coiminco_st
     ( cod_inco           varchar2(08)  
     , cod_cinc           varchar2(08)  
     , tipo_estrazione    varchar2(08)
     , cod_impianto       varchar2(08)
     , data_estrazione    date
     , data_assegn        date
     , cod_opve           varchar2(08)
     , data_verifica      date
     , ora_verifica       varchar2(08)
     , data_avviso_01     date
     , cod_documento_01   varchar2(08)
     , data_avviso_02     date
     , cod_documento_02   varchar2(08)
     , stato              char(01)
     , esito              char(01)
     , note               varchar2(4000)
     , data_ins           date
     , data_mod           date
     , utente             varchar2(10)
     , tipo_lettera       char(01)
     , cod_noin           varchar2(08)
     , st_progressivo	  integer               not null default nextval('coiminco_st_seq'::regclass)
     , st_utente          varchar2(10)     
     , st_operazione      char(1)		check (st_operazione in ('I','M','C'))              
     , st_data_validita   timestamp with time zone  
     ) tablespace &ts_dat;
