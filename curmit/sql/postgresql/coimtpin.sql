/*==============================================================*/
/* table coimtpin : tipologia istallazioni                      */
/*==============================================================*/

create table coimtpin
           ( cod_coimtpin integer     not null
           , codice       varchar(50)
           , descrizione  varchar(250)
           );

create unique index coimtpin_00
          on coimtpin
             ( cod_coimtpin
             );

