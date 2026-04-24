
/*==============================================================*/
/* table coimlott: tabella dei plichi selezionati dall'utente   */
/*==============================================================*/

create table ordplic
	( ordplic_id            integer         not null primary key
        , plico_id		integer
	, ordtarg_id		integer
        );

