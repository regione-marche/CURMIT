/*=========================================================================*/
/* table coimereg: tabella contente gli enti della Regione Lombardia       */
/*=========================================================================*/

create table coimereg
(
	cod_ente varchar(8) not null,
	cod_ente_est varchar(8) not null,
	cod_istat varchar(8),
	flag_ente varchar(1),
	denominazione_ente varchar(50),
	url_ente varchar(50),
	logo_ente varchar(50),
	database_ente varchar(50),
	host_ente varchar(50),
	ordinamento integer
	
);

create unique index coimereg_00 
	on coimereg
	( cod_ente
	);
