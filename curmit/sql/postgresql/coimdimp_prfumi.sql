/*==============================================================*/
/* table coimdimp_prfumi: tabella prova fumi                    */
/*==============================================================*/

create table coimdimp_prfumi
        ( cod_prfumi	         varchar(08)
        , cod_dimp		 varchar(08)
	, progressivo_prova_fumi integer
	, tiraggio		 numeric(9,2)
	, temp_fumi              numeric(6,2)
	, temp_ambi              numeric(6,2) 
  	, o2                   	 numeric(6,2)
  	, co2              	 numeric(6,2)
     	, bacharach              numeric(6,2)
     	, co 			 numeric(10,4)
     	, rend_combust           numeric(6,2)
	, rct_rend_min_legge     numeric(10,2)
	, rct_modulo_termico     varchar(08)
	, fr_surrisc             numeric(10,2)
	, fr_sottoraff           numeric(10,2)
	, fr_tcondens            numeric(10,2)
	, fr_tevapor             numeric(10,2) 
     	, fr_t_ing_lato_est      numeric(10,2) 
     	, fr_t_usc_lato_est      numeric(10,2)	
	, fr_t_ing_lato_ute      numeric(10,2) 
    	, fr_t_usc_lato_ute      numeric(10,2)
	, fr_nr_circuito         numeric(10,0));

create unique index coimdimp_prfumi_00
    on coimdimp_prfumi
     ( cod_prfumi
     );

create unique index coimdimp_prfumi_01
    on coimdimp_prfumi
     ( cod_dimp
     , progressivo_prova_fumi
     );	
