/*====================================================================*/
/* table coim_d_clas:                                                 */
/*====================================================================*/

create table coim_d_clas
     ( clas_funz	  varchar2(08)
     , descrizione	  varchar2(50)
     ) tablespace &ts_dat;

create unique index coim_d_clas_00
    on coim_d_clas
     ( clas_funz
     ) tablespace &ts_idx;

