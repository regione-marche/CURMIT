<?xml version="1.0"?>
<!--
USER  DATA       MODIFICHE
===== ========== ==========================================================================
sim02 27/06/2016 Aggiunte colonne flag_tariffa_impianti_vecchi, anni_fine_tariffa_base e
sim02            tariffa_impianti_vecchi per gestire le tariffe della Regione Calabria

-->
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_tari">
       <querytext>
                insert
                  into coimtari 
                     ( tipo_costo
                     , cod_potenza
                     , data_inizio
                     , importo
                     , cod_listino
                     , flag_tariffa_impianti_vecchi --sim02
                     , anni_fine_tariffa_base       --sim02
                     , tariffa_impianti_vecchi      --sim02
                     )
                values 
                     (:tipo_costo
                     ,:cod_potenza
                     ,:data_inizio
                     ,:importo
                     ,:cod_listino
                     ,:flag_tariffa_impianti_vecchi --sim02
                     ,:anni_fine_tariffa_base       --sim02
                     ,:tariffa_impianti_vecchi      --sim02
                     )
       </querytext>
    </partialquery>

    <partialquery name="upd_tari">
       <querytext>
                update coimtari
                   set importo      = :importo
                     , flag_tariffa_impianti_vecchi = :flag_tariffa_impianti_vecchi --sim02
                     , anni_fine_tariffa_base       = :anni_fine_tariffa_base       --sim02
                     , tariffa_impianti_vecchi      = :tariffa_impianti_vecchi      --sim02
                 where tipo_costo = :tipo_costo
                   and cod_potenza = :cod_potenza
                   and data_inizio = :data_inizio
       </querytext>
    </partialquery>

    <partialquery name="del_tari">
       <querytext>
                delete
                  from coimtari
                 where tipo_costo = :tipo_costo
                   and cod_potenza = :cod_potenza
                   and data_inizio = :data_inizio
       </querytext>
    </partialquery>

    <fullquery name="sel_tari">
       <querytext>
             select a.tipo_costo
                  , a.cod_potenza
                  , iter_edit_data(a.data_inizio) as data_inizio
                  , iter_edit_num(a.importo, 2) as importo
		  , case a.tipo_costo
                      when '1' then 'Autocertificazione'
                      when '2' then 'Verifica'
                      when '3' then 'Verifica generatore aggiuntivo'
                      when '4' then 'Sanzioni per inadempienze tecniche'
                      when '5' then 'Mancata verifica'
                      when '8' then 'Autocertificazione fr' --sim01
                      when '9' then 'Autocertificazione te'
                      when '10' then 'Autocertificazione cg'
                    end as tipo_costo_dett
                  , b.descr_potenza as cod_potenza_dett
                  , a.flag_tariffa_impianti_vecchi          --sim02
                  , a.anni_fine_tariffa_base                --sim02
                  , iter_edit_num(a.tariffa_impianti_vecchi,2) as tariffa_impianti_vecchi --sim02
               from coimtari a
                  , coimpote b
              where a.tipo_costo = :tipo_costo
                and a.cod_potenza = :cod_potenza
                and a.data_inizio = :data_inizio
                and b.cod_potenza = a.cod_potenza
       </querytext>
    </fullquery>

    <fullquery name="sel_tari_check">
       <querytext>
        select '1'
          from coimtari
         where tipo_costo = :tipo_costo
           and cod_potenza = :cod_potenza
           and data_inizio = :data_inizio
       </querytext>
    </fullquery>

</queryset>
