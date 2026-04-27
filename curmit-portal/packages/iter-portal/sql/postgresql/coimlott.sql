
/*==============================================================*/
/* table coimlott: tebella lotti                                */
/*==============================================================*/

create table coimlott
	( lotto_id		integer		not null primary key
        , num_targhe		integer 	not null 
        , timestamp_ins		timestamp 	not null default current_timestamp
        , user_id		integer -- references users(user_id)
        );

create sequence coimlott_s start 1;
