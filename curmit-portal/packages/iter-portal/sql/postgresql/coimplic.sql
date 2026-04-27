
/*==============================================================*/
/* table coimlott: tebella dei plichi                           */
/*==============================================================*/

create table coimplic
	( plico_id		integer		not null primary key
	, lotto_id		integer 	not null -- references coimlott(lotto_id)
	, matrice_fissa		varchar(14)	not null
	, matrice_da		varchar(2) 	not null
	, matrice_a		varchar(2) 	not null
	, data_consegna 	date
	, maintainer_id		integer
	, ordtarg_id		integer
        );

create index coimplic_00
    on coimplic
     ( lotto_id
     );

create index coimplic_01
    on coimplic
     ( maintainer_id
     );

create index coimplic_02
    on coimplic
     ( ordtarg_id
     );

create index coimplic_03
    on coimplic
     ( matrice_fissa
     );

create sequence coimplic_s start 1;
