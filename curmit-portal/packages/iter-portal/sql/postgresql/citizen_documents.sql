/*==============================================================*/
/* table citizen_documents                                      */
/*==============================================================*/

create table citizen_documents 
( document_id                  integer    not null
, cod_impianto                 varchar(8) not null
, citizen_id                   integer    not null
, cod_responsabile             varchar(8)
, flag_type_document           char(3) -- CCR (Comunicazione cambio responsabile), DAA (Dichiarazione avvenuto adeguamento)
, note_intervento_manutenzione text
, data_adeguamento             date
, data_inserimento             date
, data_ultima_modifica         date
, utente_inserimento           integer
, utente_modifica              integer
);
