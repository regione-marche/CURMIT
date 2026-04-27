
/*==============================================================*/
/* table mpay_paymentrequest: tebella che traccia la chiamata a MPAY. Usata solo per le Marche */
/*==============================================================*/

create table mpay_paymentrequest (
  portaleid               varchar(250) not null
, numerooperazione        varchar(250) not null
, numerodocumento         varchar(250) not null
, numerodocumento_reg     varchar(250) not null
, funzione                varchar(250) not null
, urldiritorno            varchar(250)
, urldinotifica           varchar(250)
, urlback                 varchar(250)
, commitnotifica          varchar(250)
, emailutente             varchar(250)
, identificativoutente    varchar(250)
, codiceutente            varchar(250)
, codiceente              varchar(250)
, tipoufficio             varchar(250)
, codiceufficio           varchar(250)
, tipologiaservizio       varchar(250)
, annodocumento           varchar(250)
, valuta                  varchar(250)
, importo                 integer
, datispecifici           varchar(500)
, codiceutente_reg        varchar(250)
, codiceente_reg          varchar(250)
, tipoufficio_reg         varchar(250)
, codiceufficio_reg       varchar(250)
, tipologiaservizio_reg   varchar(250)
, annodocumento_reg       varchar(250)
, valuta_reg              varchar(250)
, importo_reg             integer
, datispecifici_reg       varchar(500)
, id_utente               integer
, data_invio_richiesta    timestamp
, bufferdati_richiesta    text
, buffer_richiesta        text
, data_ricezione_pid      timestamp
, responce_pid            text
, stato                   varchar(250)
, tran_id                 integer
, maintainer_id           integer 
, ente_portafoglio        varchar(250)
);

create index mpay_paymentrequest_00
    on mpay_paymentrequest
     ( numerooperazione
     );

create sequence mpay_paymentrequest_s start 1;
