/*===============================================================*/
/* table coimrfis: ricevute fiscali                              */
/*===============================================================*/
create table coimrfis
     ( cod_rfis           varchar2(08)  not null
     , data_rfis          date         not null
     , num_rfis           varchar2(10)  not null
     , cod_sogg           varchar2(08)
     , tipo_sogg          char(01)
     , imponibile         number(8,2)
     , perc_iva           number(5,2)
     , flag_pag           char(01)
     , matr_da            varchar2(20)
     , matr_a             varchar2(20)
     , n_bollini          integer
     , nota               varchar2(4000)
     , mod_pag            varchar2(400)
     , data_ins           date
     , data_mod           date 
     , id_utente          varchar2(10)
     , desc_fatt          varchar2(4000)
     , spe_legali         number(11,2)
     , spe_postali        number(11,2)
     , estr_pag           varchar2(08)
     ) tablespace &ts_dat;

create unique index coimrfis_00
    on coimrfis
     ( cod_rfis
     ) tablespace &ts_idx;

create unique index coimrfis_02
    on coimrfis
     ( data_rfis
     , num_rfis
     ) tablespace &ts_idx;
