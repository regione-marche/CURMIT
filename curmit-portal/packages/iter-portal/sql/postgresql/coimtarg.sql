
/*==============================================================*/
/* table coimlott: tebella delle targhe                         */
/*==============================================================*/

create table coimtarg
	( targa_id		integer not null primary key
	, plico_id		integer not null
	, targa			varchar(16) not null
	, nome_db_utilizzo	varchar(20) -- db in cui e' stata utilizzata la targa
	, cod_impianto_caldo	varchar(8)
	, cod_impianto_freddo 	varchar(8)
        );

create index coimtarg_00
    on coimtarg
     ( plico_id
     );

create unique index coimtarg_01
    on coimtarg
     ( targa        
     );

create sequence coimtarg_s start 1;
