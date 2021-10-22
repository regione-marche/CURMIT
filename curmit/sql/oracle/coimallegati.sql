/*====================================================================*/
/* table coimallegati:                                                */
/*====================================================================*/

create table coimallegati
     ( alle_id		  integer	not null primary key
     , tabella		  varchar2(50)
     , codice		  varchar2(08)
     ,allegato		  varchar2(100)	  
     ) tablespace &ts_dat;
