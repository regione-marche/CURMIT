/*========================================================================*/
/* table coimrelt : RELazione biennale regione lombardia: scheda Tecnica  */
/*========================================================================*/

create table coimrelt
     ( cod_relg               number(08)   not null
     , cod_relt               number(08)   not null
     , sezione                char(01)     not null
     , id_clsnc               number(01)   not null
     , id_stclsnc             number(02)   not null
     , obj_refer              char(01)     not null
     , id_pot                 number(02)   not null
     , id_per                 number(02)   not null
     , id_comb                number(02)   not null
     , n                      number(06)
     , data_ins               date
     , data_mod               date
     , utente                 varchar2(10)
     ) tablespace &ts_dat;

create unique index coimrelt_00
    on coimrelt
     ( cod_relg
     , cod_relt
     ) tablespace &ts_idx;

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
     ) tablespace &ts_idx;
