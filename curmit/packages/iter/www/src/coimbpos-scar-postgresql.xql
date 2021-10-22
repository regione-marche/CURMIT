<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_bpos">
       <querytext>
   select coimbpos.cod_bpos
        , iter_edit_data(coimbpos.data_emissione) as data_emissione_edit
        , coimbpos.quinto_campo
        , coimaimp.cod_impianto_est
        , coalesce(coimcitt.cognome,'')||' '||coalesce(coimcitt.nome,'') as nominativo_resp
        , coimcitt.indirizzo
        , coimcitt.cap
        , coimcitt.comune
        , iter_edit_data(coiminco.data_verifica)  as data_verifica_edit
        , iter_edit_num(coimbpos.importo_emesso,2)  as importo_emesso_edit
        , iter_edit_num(coimbpos.importo_pagato,2)  as importo_pagato_edit
        , iter_edit_data(coimbpos.data_pagamento) as data_pagamento_edit
        , case
          when coimbpos.stato = 'A' then 'Attivo'
          when coimbpos.stato = 'N' then 'Annullato'
          end                                       as stato
     from coimbpos
     join coiminco on coimbpos.cod_inco = coiminco.cod_inco
     join coimaimp on coimaimp.cod_impianto  = coiminco.cod_impianto
left join coimcitt on coimcitt.cod_cittadino = coimaimp.cod_responsabile
    where 1 = 1
   $where_word
   $where_nome
   $where_data_controllo
   $where_data_emissione
   $where_data_scarico
   $where_data_pagamento
   $where_pagati
   $where_quinto_campo
   $where_codimp_est
   $where_stato
 order by coimbpos.data_emissione desc
        , coimbpos.quinto_campo   desc
       </querytext>
    </partialquery>

</queryset>
