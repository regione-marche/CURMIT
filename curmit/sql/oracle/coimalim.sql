/*====================================================================*/
/* table coimalim:                                                 */
/*====================================================================*/

create table coimalim
     ( cod_alim		  char(01)     not null
     , descr_alim	  varchar2(30)
     ) tablespace &ts_dat;

create unique index coimalim_00
    on coimalim
     ( cod_alim
     ) tablespace &ts_idx;
