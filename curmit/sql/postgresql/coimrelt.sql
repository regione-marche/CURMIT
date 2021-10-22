/*========================================================================*/
/* table coimrelt : RELazione biennale regione lombardia: scheda Tecnica  */
/*========================================================================*/

create table coimrelt
     ( cod_relg               numeric(08)  not null
     , cod_relt               numeric(08)  not null
     , sezione                char(01)     not null
     , id_clsnc               numeric(01)  not null
     , id_stclsnc             numeric(02)  not null
     , obj_refer              char(01)     not null
     , id_pot                 numeric(02)  not null
     , id_per                 numeric(02)  not null
     , id_comb                numeric(02)  not null
     , n                      numeric(06)
     , data_ins               date
     , data_mod               date
     , utente                 varchar(10)
     );

create unique index coimrelt_00
    on coimrelt
     ( cod_relg
     , cod_relt
     );

create unique index coimrelt_01
    on coimrelt
     ( cod_relg
     , sezione
     , id_clsnc
     , id_stclsnc
     , obj_refer
     , id_pot
     , id_per
     , id_comb
     );
