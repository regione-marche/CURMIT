/*====================================================================*/
/* table coimcaup:                                                 */
/*====================================================================*/

create table coimcaup
     ( causale		varchar2(08)	not null primary key
     , desc_causale	varchar2(100)	
     ) tablespace &ts_dat;