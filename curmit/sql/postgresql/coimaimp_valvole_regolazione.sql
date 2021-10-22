/*==============================================================*/
/* table coimaimp_valvole_regolazione: Valvole di Regolazione   */
/*==============================================================*/


create table coimaimp_valvole_regolazione (
             cod_valvola_regolazione_aimp integer    not null
           , numero_valvola_regolazione   integer    not null
           , cod_impianto                 varchar(8) not null
           , flag_sostituito              boolean    default false
           , data_installazione           date
           , data_dismissione             date
           , fabbricante                  varchar(30)
           , modello                      varchar(30)
           , numero_vie	                  varchar(20)
           , servomotore	          varchar(20)
           );
														
