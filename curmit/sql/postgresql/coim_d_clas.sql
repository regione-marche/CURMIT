/*====================================================================*/
/* table coim_d_clas:                                                 */
/*====================================================================*/

create table coim_d_clas
     ( clas_funz	  varchar(08)
     , descrizione	  varchar(50)
     );

create unique index coim_d_clas_00
    on coim_d_clas
     ( clas_funz
     );
