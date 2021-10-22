/*====================================================================*/
/* table coim_d_anom:                                                 */
/*====================================================================*/

create table coim_d_anom
     ( cod_cimp_dimp      varchar2(08)
     , prog_anom	  varchar2(08)
     , tipo_anom          varchar2(08)
     , cod_tanom	  varchar2(08)
     , dat_utile_inter	  date
     , flag_origine	  varchar2(02)
     ) tablespace &ts_dat;


create unique index coim_d_anom_00
    on coim_d_anom
     ( cod_cimp_dimp
     , prog_anom
     , flag_origine
     ) tablespace &ts_idx;

