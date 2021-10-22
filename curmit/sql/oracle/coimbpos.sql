/*==============================================================*/
/* table coimbpos: Bollettini postali                           */
/*==============================================================*/

create table coimbpos
( cod_bpos		integer		not null
, cod_inco		varchar2(08)	not null
, quinto_campo		varchar2(16)	not null
, data_emissione	date		not null default current_date
, importo_emesso	number(10,2)	not null
, importo_pagato	number(10,2)	not null default 0
, data_pagamento	date
, protocollo		varchar2(20)	-- non servono ma non si sa mai
, data_protocollo	date		-- non servono ma non si sa mai
, stato			char(01)	not null default 'A' -- 'A'=Attivo, 'N'=Annullato (cioè cancellato)
, data_ins		date	   	not null default current_date
, utente_ins		varchar2(10)
, data_mod		date
, utente_mod		varchar2(10)
, data_scarico          date            -- data accredito su c/c postale
) tablespace &ts_dat;

create unique index coimbpos_00
    on coimbpos
     ( cod_bpos
     ) tablespace &ts_idx;

create unique index coimbpos_01
    on coimbpos
     ( cod_inco
     ) tablespace &ts_idx;

create unique index coimbpos_02
    on coimbpos
     ( quinto_campo
     ) tablespace &ts_idx;
