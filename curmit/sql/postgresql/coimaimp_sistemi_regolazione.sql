/*==============================================================*/
/* table coimaimp_sistmi_regolazione: Sistemi di Regolazione    */
/*==============================================================*/


create table coimaimp_sistemi_regolazione (
             cod_sistema_regolazione_aimp integer    not null
           , numero_sistema_regolazione   integer    not null
           , cod_impianto                 varchar(8) not null
           , flag_sostituito              boolean    default false
           , data_installazione           date
	   , data_dismissione             date
	   , numero_punti_regolazione     varchar(20)
	   , numero_lvl_temperatura       varchar(20)
	   , fabbricante                  varchar(30)
	   , modello                      varchar(30)
	   );


