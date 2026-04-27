
/*==============================================================*/
/* table mpay_paymentdata: tebella che traccia la risposta di MPAY. Usata solo per le Marche */
/*==============================================================*/

create table mpay_paymentdata (
  data_input              timestamp             --data in cui MPAY chiama il mio programma di verifica
, buffer_input            text                  --buffer con cui creare il buffer di notifica
, data_notifica           timestamp             --data in cui rimando il buffer di notifica a MPAy
, buffer_notifica         text                  --buffer con cui richiamo MPAy per ricevere i dati del pagamento 
, data_response           timestamp             --data in cui MPAY mi restituisce il buffer con i dati del pagamento
, buffer_response         text                  --buffer contenente i dati del pagamento
, portaleid               varchar(250)
, numerooperazione        varchar(250)

, codiceutente            varchar(250)
, codiceente              varchar(250)
, tipoufficio             varchar(250)
, codiceufficio           varchar(250)
, tipologiaservizio       varchar(250)
, numerodocumento         varchar(250)

, idordine                varchar(250)
, dataoraordine           varchar(250)
, idtransazione           varchar(250)
, dataoratransazione      varchar(250)
, sistemapagamento        varchar(250)
, sistemapagamentod       varchar(250)
, circuitoautorizzativo   varchar(250)
, circuitoautorizzativod  varchar(250)
, importotransato         decimal(18,2)
, importocommissioni      decimal(18,2)
, importocommissioniente  decimal(18,2)
, esito	                  varchar(250)					
, esitod                  varchar(250)
, autorizzazione          varchar(250)
, motivo_scarto           text
, creation_program        varchar(250)
);

