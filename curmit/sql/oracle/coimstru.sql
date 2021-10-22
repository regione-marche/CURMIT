/*====================================================================*/
/* table  coimstru:						      */
/*====================================================================*/

create table coimstru
     (cod_strumento	varchar2(8)   not null
     , cod_opve         varchar2(8)    not null
     , cod_enve         varchar2(8)    not null
     , tipo_strum       char(1)            
     , marca_strum      varchar2(50)   
     , modello_strum    varchar2(50)   
     , matr_strum       varchar2(50)		
     , dt_tar_strum     date                    
     , dt_inizio_att    date                    
     , dt_fine_att      date                    
     , strum_default    char(1)
) tablespace &ts_dat;

create unique index coimstru_00
    on coimstru
     ( cod_strumento
     ) tablespace &ts_idx;
