/*====================================================================*/
/* table coimalim:                                                 */
/*====================================================================*/

create table coimalim
     ( cod_alim		  char(01)     not null
     , descr_alim	  varchar(30)
     );

create unique index coimalim_00
    on coimalim
     ( cod_alim
     );
