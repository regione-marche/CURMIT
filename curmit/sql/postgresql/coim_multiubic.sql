/*====================================================================*/
/* table coim_multiubic:                                                 */
/*====================================================================*/

create table coim_multiubic
     ( cod_ubicazione	   varchar(08)	not null
     , cod_impianto        varchar(08)	not null
     , cod_via		   varchar(08)
     , cod_comune	   varchar(08)
     , toponimo		   varchar(20)
     , indirizzo	   varchar(100)
     , numero		   varchar(08)
     , esponente	   varchar(03)
     , scala		   varchar(05)
     , piano		   varchar(05)
     , interno		   varchar(03)
     , localita		   varchar(40)
     , cap		   varchar(05)
     , utente		   varchar(10)
     , data_ins		   date
     , data_mod		   date
     );

create unique index coim_multiubic_00
    on coim_multiubic
     ( cod_ubicazione
     );
