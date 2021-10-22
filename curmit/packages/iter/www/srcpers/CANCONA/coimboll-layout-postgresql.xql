<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_manu">
       <querytext>
           select coalesce (cognome, ' ') ||' '||
                  coalesce (nome, ' ')            as manutentore
                , indirizzo                       as manu_indirizzo
                , comune                          as manu_comune
                , telefono                        as manu_tel
             from coimmanu
            where cod_manutentore = :cod_manu_per_sel_manu
       </querytext>
    </fullquery>

    <fullquery name="sel_boll_cod_manu">
       <querytext>
           select cod_manutentore as boll_cod_manu
             from coimboll
            where cod_bollini = :cod_bollini
       </querytext>
    </fullquery>

    <fullquery name="sel_boll">
       <querytext>
           select coalesce (b.cognome, ' ') ||' '||
                  coalesce (b.nome, ' ')              as manutentore
                , iter_edit_data(a.data_consegna)     as data_consegna_edit
                , a.nr_bollini
                , a.nr_bollini_resi
                , a.matricola_da
                , a.matricola_a
                , a.costo_unitario
                , a.pagati
                , iter_edit_data(a.data_scadenza)     as data_scadenza_edit
                , iter_edit_num(a.imp_sconto, 2)      as imp_sconto
                , a.note
                , c.descrizione as tipologia
                , iter_edit_num(imp_pagato, 2) as imp_pagato
                , coalesce(d.cognome, '')||' '||coalesce(d.nome, '') as utente
             from coimboll a
  left outer join coimtpbl c on c.cod_tipo_bol = a.cod_tpbl
  left outer join coimuten d on d.id_utente    = a.utente
                , coimmanu b
            where b.cod_manutentore = a.cod_manutentore
           $where_manu
           $where_data_da
           $where_data_a
           $where_code
         order by a.data_consegna
                , a.cod_bollini
       </querytext>
    </fullquery>

    <fullquery name="get_desc_prov">
       <querytext>
           select initcap(denominazione) as desc_prov
             from coimprov
            where cod_provincia = :cod_prov
       </querytext>
    </fullquery>

</queryset>
