/*====================================================================*/
/* table coim_d_tano:                                                 */
/*====================================================================*/

create table coim_d_tano
     ( cod_tano		  varchar2(08)
     , descr_tano	  varchar2(200)
     , descr_breve	  varchar2(80)
     , data_ins		  date
     , data_mod		  date
     , utente		  varchar2(10)
     , flag_scatenante	  char(01)
     , norma		  varchar2(100)
     , flag_stp_esito	  char(01)
     , gg_adattamento	  numeric2(03)
     , flag_report	  char(01)
     , flag_modello	  char(01)
     , data_fine_valid	  date
     , clas_funz	  varchar2(08)	  
     ) tablespace &ts_dat;

create unique index coim_d_tano_00
    on coim_d_tano
     ( cod_tano
     ) tablespace &ts_idx;

