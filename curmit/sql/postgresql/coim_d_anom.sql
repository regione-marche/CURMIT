/*====================================================================*/
/* table coim_d_anom:                                                 */
/*====================================================================*/

create table coim_d_anom
     ( cod_cimp_dimp      varchar(08)
     , prog_anom	  varchar(08)
     , tipo_anom          varchar(08)
     , cod_tanom	  varchar(08)
     , dat_utile_inter	  date
     , flag_origine	  varchar(02)
     );

create unique index coim_d_anom_00
    on coim_d_anom
     ( cod_cimp_dimp
     , prog_anom
     , flag_origine
     );
