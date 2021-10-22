<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_bpos">
       <querytext>
             select a.cod_bpos
                  , a.quinto_campo
                  , iter_edit_data(a.data_emissione)  as data_emissione
                  , iter_edit_num(a.importo_emesso,2) as importo_emesso
                  , iter_edit_num(a.importo_pagato,2) as importo_pagato
                  , iter_edit_data(a.data_pagamento)  as data_pagamento
                  , iter_edit_data(a.data_scarico)    as data_scarico
                  , a.stato
                  , iter_edit_data(b.data_verifica)   as data_verifica
                  , c.cod_impianto_est
                  , coalesce(d.cognome,'')||' '||coalesce(d.nome,'')
                                                      as responsabile
               from coimbpos a
               join coiminco b on b.cod_inco      = a.cod_inco
               join coimaimp c on c.cod_impianto  = b.cod_impianto
          left join coimcitt d on d.cod_cittadino = c.cod_responsabile
              where cod_bpos = :cod_bpos
       </querytext>
    </fullquery>

    <partialquery name="upd_bpos">
       <querytext>
                update coimbpos
                   set importo_pagato = :importo_pagato
                     , data_pagamento = :data_pagamento
                     , data_scarico   = :data_scarico
                     , stato          = :stato
		     , utente_mod     = :id_utente
		     , data_mod       = current_date
                 where cod_bpos       = :cod_bpos
       </querytext>
    </partialquery>

</queryset>
