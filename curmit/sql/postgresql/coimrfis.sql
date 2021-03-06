/*===============================================================*/
/* table coimrfui: ricevute viscali                             */
/*===============================================================*/
create table coimrfis
     ( cod_rfis           varchar(08)  not null
     , data_rfis          date         not null
     , num_rfis           varchar(10)  not null
     , cod_sogg           varchar(08)
     , tipo_sogg          char(01)
     , imponibile         numeric(8,2)
     , perc_iva           numeric(5,2)
     , flag_pag           char(01)
     , matr_da            varchar(20)
     , matr_a             varchar(20)
     , n_bollini          integer
     , nota               varchar(4000)
     , mod_pag            varchar(400)
     , data_ins           date
     , data_mod           date 
     , id_utente          varchar(10)
     , desc_fatt          varchar(4000)
     , spe_legali         numeric(11,2)
     , spe_postali        numeric(11,2)
     , estr_pag           varchar(08)
     );

create unique index coimrfis_00
    on coimrfis
     ( cod_rfis
     ) ;

create unique index coimrfis_02
    on coimrfis
     ( data_rfis
     , num_rfis
     ) ;
