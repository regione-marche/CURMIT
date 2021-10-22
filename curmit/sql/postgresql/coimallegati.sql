/*====================================================================*/
/* table coimallegati:                                                */
/*====================================================================*/

create table coimallegati
     ( alle_id		  integer	not null primary key
     , tabella		  varchar(50)
     , codice		  varchar(08)
     ,allegato		  varchar(100)	  
     );
