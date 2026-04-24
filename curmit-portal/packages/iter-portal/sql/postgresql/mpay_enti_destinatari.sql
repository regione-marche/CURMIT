
/*==============================================================*/
/* table mpay_enti_destinatari: tabella che decodifica tutti i possibili destinatari di MPAY*/
/*==============================================================*/

create table mpay_enti_destinatari (
  codiceutente            varchar(250)
, codiceente              varchar(250)
, tipoufficio             varchar(250)
, codiceufficio           varchar(250)
, tipologiaservizio       varchar(250)
, instance_name           varchar(250)
, flag_regione            boolean       default false
, perc_regione            decimal(18,2)
, datispecifici           varchar(500)
);

