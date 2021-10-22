/*==============================================================*/
/* table coimfunz:  funzioni menu' fittizia                     */
/*==============================================================*/

create table coimfunp
     ( nome_funz      varchar2(50)  not null
     , desc_funz      varchar2(60)
     ) tablespace &ts_dat;

create unique index coimfunp_00
    on coimfunp
     ( nome_funz
     ) tablespace &ts_idx;
