/*====================================================================*/
/* table coimfdc:                                                 */
/*====================================================================*/

create table coimfdc
     ( cod_fdc		  integer      not null
     , descr_fdc	  varchar2(30)
     ) tablespace &ts_dat;

create unique index coimfdc_00
    on coimfdc
     ( cod_fdc
     ) tablespace &ts_idx;
