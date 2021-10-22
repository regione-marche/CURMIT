/*====================================================================*/
/* table coim_as_resp:                                                 */
/*====================================================================*/

create table coim_as_resp
     (cod_as_resp	   varchar(08)	not null
     , cod_impianto        varchar(08)
     , cod_legale_rapp     varchar(08)
     , cod_manutentore     varchar(08)
     , data_inizio         date
     , data_fine           date
     , causale_fine	   char(01)
     , toponimo            varchar(20)
     , indirizzo           varchar(100) 
     , cod_via             varchar(08)
     , localita            varchar(40)  
     , numero              varchar(08)           
     , esponente           varchar(3)   
     , scala               varchar(5)   
     , piano               varchar(5)   
     , interno             varchar(3)   
     , cod_comune          varchar(08)
     , cod_responsabile    varchar(08)
     , potenza             numeric(9,2)
     , cod_utgi            varchar(08)
     , data_ins            date
     , data_mod            date
     , utente              varchar(10)  
     , flag_tracciato      varchar(10)  
     , committente         varchar(100) 
     , nome_condominio     varchar(100) 
     , cod_docu_distinta   varchar(08)
     , flag_ammimp         character(1)
     , fornitore_energia_p boolean     
     );

create unique index coim_as_resp_00
    on coim_as_resp
     ( cod_as_resp
     );
