/*=====================================*/
/* table coimtarg_log: Log sui cambi di targa degli impianti*/
/*=====================================*/

create table coimtarg_log
     ( id_log                integer       not null primary key
     , cod_impianto          varchar(8)    not null
     , targa_precedente      varchar(16)
     , targa_nuova           varchar(16)
     , utente_modifica       varchar(10)
     , data_modifica         timestamp
);


