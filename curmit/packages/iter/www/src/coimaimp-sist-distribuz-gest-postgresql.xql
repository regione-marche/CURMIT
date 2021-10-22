<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_vasi_espa_aimp">
       <querytext>
select a.cod_vasi_espa_aimp
     , a.cod_impianto
     , a.num_vx
     , iter_edit_num(a.capacita, 2) as capacita
     , case
       when flag_aperto = 'A' then
            'Aperto'
       when flag_aperto = 'C' then
            'Chiuso'
       end                          as flag_aperto
     , iter_edit_num(a.pressione, 2) as pressione
     , a.data_ins
     , a.utente_ins
     , a.data_mod
     , a.utente_mod
  from coimvasi_espa_aimp a
 where a.cod_impianto = :cod_impianto
order by a.num_vx
       </querytext>
    </fullquery>

    <fullquery name="sel_pomp_circ_aimp">
       <querytext>
select a.cod_pomp_circ_aimp
     , a.cod_impianto
     , a.num_po
     , iter_edit_data(a.data_installaz) as data_installaz
     , iter_edit_data(a.data_dismissione) as data_dismissione
     , case a.flag_sostituito 
       when 'f' then 'No'
       when 't' then 'S&igrave;'
        end as flag_sostituito --rom01
     , a.cod_cost
     , a.modello
     , case flag_giri_variabili
                   when 'S' then 'Si'
                   when 'N' then 'No'
                   end as flag_giri_variabili
     , iter_edit_num(a.pot_nom, 2) as pot_nom
     , a.data_ins
     , a.utente_ins
     , a.data_mod
     , a.utente_mod
     , b.descr_cost
  from coimpomp_circ_aimp a left outer join coimcost b on a.cod_cost = b.cod_cost
 where a.cod_impianto = :cod_impianto
order by a.num_po
       </querytext>
    </fullquery>
</queryset>
