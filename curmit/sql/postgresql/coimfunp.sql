/*==============================================================*/
/* table coimfunz:  funzioni menu' fittizia                     */
/*==============================================================*/

create table coimfunp
     ( nome_funz      varchar(50)  not null
     , desc_funz      varchar(60)
     );

create unique index coimfunp_00
    on coimfunp
     ( nome_funz
     );
