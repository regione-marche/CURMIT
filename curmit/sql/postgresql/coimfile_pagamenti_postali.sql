/*===================================================================================*/
/* table coimfile_pagamenti_postali: File dei pagamenti postali ricevuti dalle poste */
/*===================================================================================*/

create table coimfile_pagamenti_postali
( cod_file              integer       not null
, data_caricamento      date          not null default current_date
, nome_file             varchar(200)
, record_caricati       integer
, importo_caricati      numeric(11,2)
, record_scartati       integer
, importo_scartati      numeric(11,2)
, file_caricamento      oid
, file_caricati         oid
, file_scartati         oid
, data_ins              date          not null default current_date
, utente_ins            varchar(10)
);

create unique index coimfile_pagamenti_postali_00
    on coimfile_pagamenti_postali
     ( cod_file
     );
