/*====================================================================*/
/* table coimfdc:                                                 */
/*====================================================================*/

create table coimfdc
     ( cod_fdc		  integer     not null
     , descr_fdc	  varchar(30)
     );

create unique index coimfdc_00
    on coimfdc
     ( cod_fdc
     );
