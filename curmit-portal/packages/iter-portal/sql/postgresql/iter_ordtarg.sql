
/*==============================================================*/
/* table iter_ordtarg: tebella degli ordini delle targhe        */
/*==============================================================*/

create table iter_ordtarg
	( ordtarg_id		integer not null primary key
	, maintainer_id		integer not null
	, num_targhe		integer not null
	, consegna		char(1)           
	, address_ass_posta	varchar(200) 
	, city_ass_posta	varchar(40)  
	, zipcode_ass_posta	varchar(5)   
	, delegato            	varchar(200) 
	, delegato_comune_nas 	varchar(100) 
	, delegato_data_nas	date                   
	, data_prenotazione 	date                   
	, cod_prenotazione    	varchar(20)  
	, creation_user       	integer                
	, creation_date		date                   
	, editing_user        	integer                
	, editing_date        	date                   
	, flag_evaso          	boolean     
        , vettore               varchar(200)
        );

create index iter_ordtarg_00
    on iter_ordtarg
     ( maintainer_id
     );

create sequence ordtarg_seq start 1;
