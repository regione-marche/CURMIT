<?xml version="1.0"?>
<!--
USER  DATA       MODIFICHE
===== ========== ==========================================================================
sim04 19/09/2918 Aggiunto dichiarazione cogenerazione

sim03 06/04/2017 Aggiunto dichiarazione teleriscaldamento

sim02 29/06/2016 Aggiunte colonne flag_tariffa_impianti_vecchi, anni_fine_tariffa_base e
sim02            tariffa_impianti_vecchi per gestire le tariffe della Regione Calabria
-->
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_tari">
       <querytext>
select iter_edit_num(a.tipo_costo, 0) as tipo_costo_edit
     , a.tipo_costo
     , case tipo_costo
        when '1' then 'Dichiarazione'
        when '2' then 'Verifica'
        when '3' then 'Verifica generatore aggiuntivo'
        when '4' then 'Sanzioni per inadempienze tecniche'
        when '5' then 'Mancata verifica'
        when '6' then 'Tariffa verificatore'
        when '7' then 'Contributo Regionale'
	when '8' then 'Dichiarazione fr' --sim01
        when '9' then 'Dichiarazione te' --sim03
        when '10' then 'Dichiarazione cg'--sim04
       end as tipo_costo_edit
     , b.descr_potenza
     , a.cod_potenza
     , a.data_inizio
     , iter_edit_num(a.importo, 2) as importo_edit
     , iter_edit_data(a.data_inizio) as data_inizio_edit

     , case when a.flag_tariffa_impianti_vecchi = 't' then                        -- sim02
            'S&igrave;'                                                           -- sim02
       else 
            'No'
       end                                        as flag_tariffa_impianti_vecchi -- sim02

     , a.anni_fine_tariffa_base                                                   -- sim02
     , iter_edit_num(a.tariffa_impianti_vecchi,2) as tariffa_impianti_vecchi_edit -- sim02

  from coimtari a  
     , coimpote b
 where 1 = 1
   and cod_listino = :cod_listino
   and b.cod_potenza = a.cod_potenza
 $where_last
order by tipo_costo, potenza_min, cod_potenza, data_inizio
       </querytext>
    </partialquery>

</queryset>
