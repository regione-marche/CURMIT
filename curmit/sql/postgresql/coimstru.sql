/*====================================================================*/
/* table  coimstru:						      */
/*====================================================================*/

create table coimstru
     (cod_strumento	varchar(8)   not null
     , cod_opve         varchar(8)    not null
     , cod_enve         varchar(8)    not null
     , tipo_strum       character(1)            
     , marca_strum      varchar(50)   
     , modello_strum    varchar(50)   
     , matr_strum       varchar(50)		
     , dt_tar_strum     date                    
     , dt_inizio_att    date                    
     , dt_fine_att      date                    
     , strum_default    character(1));

create unique index coimstru_00
    on coimstru
     ( cod_strumento
     );
