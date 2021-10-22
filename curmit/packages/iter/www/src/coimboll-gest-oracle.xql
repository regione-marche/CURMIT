<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="ins_boll">
       <querytext>
                insert
                  into coimboll 
                     ( cod_bollini
                     , cod_manutentore
                     , data_consegna
                     , nr_bollini
                     , nr_bollini_resi
                     , matricola_da
                     , matricola_a
                     , pagati
                     , costo_unitario
                     , note
                     , data_ins
                     , utente
                     , data_scadenza
                     , cod_tpbo
                     , imp_pagato
                     , imp_sconto
                     , mod_pag
                     , data_pag -- 2014-06-07
                     )
                values 
                     (:cod_bollini
                     ,:cod_manutentore
                     ,:data_consegna
                     ,:nr_bollini
                     ,:nr_bollini_resi
                     ,:matricola_da
                     ,:matricola_a
                     ,:pagati
                     ,:costo_unitario
                     ,:note
                     , sysdate
                     ,:id_utente
                     ,:data_scadenza
                     ,:cod_tpbo
                     ,:imp_pagato
                     ,:imp_sconto
                     ,:mod_pag
                     ,:data_pag -- 2014-06-07
                     )
       </querytext>
    </partialquery>

    <partialquery name="upd_boll">
       <querytext>
                update coimboll
                   set data_consegna   = :data_consegna
                     , nr_bollini      = :nr_bollini
                     , nr_bollini_resi = :nr_bollini_resi
                     , matricola_da    = :matricola_da
                     , matricola_a     = :matricola_a
                     , pagati          = :pagati
                     , costo_unitario  = :costo_unitario
                     , note            = :note
                     , data_mod        = sysdate
                     , utente          = :id_utente
                     , data_scadenza   = :data_scadenza
                     , cod_tpbo        = :cod_tpbo
                     , imp_pagato      = :imp_pagato
                     , imp_sconto      = :imp_sconto
                     , mod_pag         = :mod_pag
                     , data_pag        = :data_pag
                 where cod_bollini     = :cod_bollini
       </querytext>
    </partialquery>

    <partialquery name="del_boll">
       <querytext>
                delete
                  from coimboll
                 where cod_bollini = :cod_bollini
       </querytext>
    </partialquery>

    <fullquery name="sel_boll">
       <querytext>
             select cod_bollini
                  , iter_edit.data(a.data_consegna)     as data_consegna
                  , iter_edit.num(a.nr_bollini, 0)      as nr_bollini
                  , iter_edit.num(a.nr_bollini_resi, 0) as nr_bollini_resi
                  , iter_edit.num(a.imp_pagato, 2) as imp_pagato
                  , a.matricola_da
                  , a.matricola_a
                  , a.pagati
                  , iter_edit.num(a.costo_unitario, 2)  as costo_unitario
                  , a.note
                  , iter_edit.data(a.data_scadenza)     as data_scadenza
                  , b.cognome||' '||nvl(b.nome,'') as descr_manutentore
                  , a.cod_tpbo
                  , iter_edit.num (((nvl(a.nr_bollini, 0) - nvl(a.nr_bollini_resi, 0)) * nvl(a.costo_unitario, 0)) - nvl(a.imp_pagato,0) , 2) as imp_dovuto
                  , iter_edit.num(a.imp_sconto, 2) as imp_sconto
                  , b.flag_attivo
                  , b.nome as f_manu_nome
                  , b.cognome as f_manu_cogn
                  , b.cod_manutentore
                  , a.mod_pag
                  , iter_edit_data(a.data_pag)     as data_pag -- 2014-06-07
               from coimboll a
                  , coimmanu b
              where a.cod_bollini      = :cod_bollini
                and b.cod_manutentore  = a.cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_boll_check">
       <querytext>
        select '1'
          from coimboll
         where cod_bollini = :cod_bollini
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
        select cognome
              ,nome
          from coimmanu
         where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_dual_boll">
       <querytext>
        select coimboll_s.nextval  as cod_bollini
          from dual
       </querytext>
    </fullquery>

    <fullquery name="sel_pote_cod_min_35">
       <querytext>
        select max(a.cod_potenza)
          from coimpote a
         where a.potenza_max = (select max(b.potenza_max)
                                  from coimpote b
                                 where b.potenza_max < 35)
       </querytext>
    </fullquery>

    <fullquery name="sel_tari">
       <querytext>
        select iter_edit.num(importo ,2) as importo
          from coimtari 
         where tipo_costo  = :tipo_costo
           and cod_potenza = :cod_potenza
           and data_inizio = (select max(data_inizio) 
                                from coimtari 
                               where tipo_costo   = :tipo_costo
                                 and cod_potenza  = :cod_potenza
                                 and data_inizio <= :current_date)
       </querytext>
    </fullquery>

    <partialquery name="cognome_nome">
       <querytext>
             substr(nvl(cognome,'')||' '||nvl(nome,''),1,50)
       </querytext>
    </partialquery>

    <fullquery name="sel_boll_count">
       <querytext>
           select count(*)
             from coimboll
            where matricola_da <= :matricola_a
              and matricola_a  >= :matricola_da
             $and_cod_bollini
       </querytext>
    </fullquery>

    <fullquery name="sel_boll_max">
       <querytext>
           select nvl(max(matricola_a),'?')
             from coimboll 
           $where_cod_tpbo
             $and_cod_bollini
       </querytext>
    </fullquery>

    <fullquery name="sel_manu_convenzionati">
       <querytext>
          select substr(coalesce(cognome,'')||' '||coalesce(nome,''),1,50) as nominativo_manu
               , cod_manutentore as cod_manu
            from coimmanu
           where flag_convenzionato = 'S'
           order by cognome, nome
       </querytext>
    </fullquery>

</queryset>
