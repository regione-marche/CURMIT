/*====================================================================*/
/* table coim_as_resp:                                                 */
/*====================================================================*/

create table coim_as_resp
     (cod_as_resp	   varchar2(08)	not null
     , cod_impianto        varchar2(08)
     , cod_legale_rapp     varchar2(08)
     , cod_manutentore     varchar2(08)
     , data_inizio         date
     , data_fine           date
     , causale_fine	   char(01)
     , toponimo            varchar2(20)
     , indirizzo           varchar2(100) 
     , cod_via             varchar2(08)
     , localita            varchar2(40)  
     , numero              varchar2(08)           
     , esponente           varchar2(3)   
     , scala               varchar2(5)   
     , piano               varchar2(5)   
     , interno             varchar2(3)   
     , cod_comune          varchar2(08)
     , cod_responsabile    varchar2(08)
     , potenza             numeric(9,2)
     , cod_utgi            varchar2(08)
     , data_ins            date
     , data_mod            date
     , utente              varchar2(10)  
     , flag_tracciato      varchar2(10)  
     , committente         varchar2(100) 
     , nome_condominio     varchar2(100) 
     , cod_docu_distinta   varchar2 (08)
     , flag_ammimp         char(1)
     , fornitore_energia_p boolean     
     ) tablespace &ts_dat;

create unique index coim_as_resp_00
    on coim_as_resp
     ( cod_as_resp
     ) tablespace &ts_dat;
