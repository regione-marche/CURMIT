<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    gab01 17/08/2016 Gestite nuove pagine del libretto (8.1, 9.1, 9.2, 9.3, 9.4 ).
-->

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_recu_cond_aimp">
       <querytext>
select a.cod_recu_cond_aimp
     , a.cod_impianto
     , a.num_rc
     , iter_edit_data(a.data_installaz) as data_installaz
     , iter_edit_data(a.data_dismissione) as data_dismissione
     , a.cod_cost
     , a.modello
     , a.matricola
     , iter_edit_num(a.portata_term_max, 2) as portata_term_max
     , iter_edit_num(a.portata_term_min, 2) as portata_term_min
     , b.descr_cost
  from coimrecu_cond_aimp a left outer join coimcost b on a.cod_cost = b.cod_cost
 where a.cod_impianto = :cod_impianto
order by a.num_rc
       </querytext>
    </fullquery>

    <fullquery name="sel_camp_sola_aimp">
       <querytext>
select a.cod_camp_sola_aimp
     , a.cod_impianto
     , a.num_cs
     , iter_edit_data(a.data_installaz) as data_installaz
     , a.cod_cost
     , a.collettori
     , iter_edit_num(a.sup_totale, 2) as sup_totale
     , b.descr_cost
  from coimcamp_sola_aimp a left outer join coimcost b on a.cod_cost = b.cod_cost
 where a.cod_impianto = :cod_impianto
order by a.num_cs
       </querytext>
    </fullquery>

    <fullquery name="sel_altr_gend_aimp">
       <querytext>
select a.cod_altr_gend_aimp
     , a.cod_impianto
     , a.num_ag
     , iter_edit_data(a.data_installaz) as data_installaz
     , iter_edit_data(a.data_dismissione) as data_dismissione
     , a.cod_cost
     , a.modello
     , a.matricola
     , a.tipologia
     , iter_edit_num(a.potenza_utile, 2) as potenza_utile
     , b.descr_cost
  from coimaltr_gend_aimp a left outer join coimcost b on a.cod_cost = b.cod_cost
 where a.cod_impianto = :cod_impianto
order by a.num_ag
       </querytext>
    </fullquery>

    <fullquery name="sel_accu_aimp"><!--gab01-->
       <querytext>
select a.cod_accu_aimp
     , a.cod_impianto
     , a.num_ac
     , iter_edit_data(a.data_installaz)   as data_installaz
     , iter_edit_data(a.data_dismissione) as data_dismissione
     , a.cod_cost
     , a.modello
     , a.matricola
     , iter_edit_num(a.capacita,2)        as capacita

     , case utilizzo
            when 'A' then 'Acqua Sanitaria'
            when 'R' then 'Riscaldamento'
            when 'F' then 'Raffreddamento'
            else          ''
       end                                as utilizzo

     , case coibentazione
            when 'S' then 'Si'
            when 'N' then 'No'
            else          ''
       end                                as coibentazione

     , b.descr_cost
  from coimaccu_aimp a left outer join coimcost b on b.cod_cost = a.cod_cost
 where a.cod_impianto = :cod_impianto
order by a.num_ac
       </querytext>
    </fullquery>

    <fullquery name="sel_torr_evap_aimp"><!--gab01-->
       <querytext>
select a.cod_torr_evap_aimp
     , a.cod_impianto
     , a.num_te
     , iter_edit_data(a.data_installaz)   as data_installaz
     , iter_edit_data(a.data_dismissione) as data_dismissione
     , a.cod_cost
     , a.modello
     , a.matricola
     , iter_edit_num(a.capacita,2)        as capacita
     , a.num_ventilatori
     , a.tipi_ventilatori
     , b.descr_cost
  from coimtorr_evap_aimp a left outer join coimcost b on b.cod_cost = a.cod_cost
 where a.cod_impianto = :cod_impianto
order by a.num_te
       </querytext>
    </fullquery>

    <fullquery name="sel_raff_aimp"><!--gab01-->
       <querytext>
select a.cod_raff_aimp
     , a.cod_impianto
     , a.num_rv
     , iter_edit_data(a.data_installaz)   as data_installaz
     , iter_edit_data(a.data_dismissione) as data_dismissione
     , a.cod_cost
     , a.modello
     , a.matricola
     , a.num_ventilatori
     , a.tipi_ventilatori
     , b.descr_cost
  from coimraff_aimp a left outer join coimcost b on b.cod_cost = a.cod_cost
 where a.cod_impianto = :cod_impianto
order by a.num_rv
       </querytext>
    </fullquery>

    <fullquery name="sel_scam_calo_aimp"><!--gab01-->
       <querytext>
select a.cod_scam_calo_aimp
     , a.cod_impianto
     , a.num_sc
     , iter_edit_data(a.data_installaz)   as data_installaz
     , iter_edit_data(a.data_dismissione) as data_dismissione
     , a.cod_cost
     , a.modello
     , b.descr_cost
  from coimscam_calo_aimp a left outer join coimcost b on b.cod_cost = a.cod_cost
 where a.cod_impianto = :cod_impianto
order by a.num_sc
       </querytext>
    </fullquery>

    <fullquery name="sel_circ_inte_aimp"><!--gab01-->
       <querytext>
select a.cod_circ_inte_aimp
     , a.cod_impianto
     , a.num_ci
     , iter_edit_data(a.data_installaz)   as data_installaz
     , iter_edit_data(a.data_dismissione) as data_dismissione
     , iter_edit_num(a.lunghezza,2)       as lunghezza
     , iter_edit_num(a.superficie,2)      as superficie
     , iter_edit_num(a.profondita,2)      as profondita
  from coimcirc_inte_aimp a 
 where a.cod_impianto = :cod_impianto
order by a.num_ci
       </querytext>
    </fullquery>

   <fullquery name="sel_trat_aria_aimp"><!--gab01-->
       <querytext>
select a.cod_trat_aria_aimp
     , a.cod_impianto
     , a.num_ut
     , iter_edit_data(a.data_installaz)   as data_installaz
     , iter_edit_data(a.data_dismissione) as data_dismissione
     , a.modello
     , a.matricola
     , iter_edit_num(a.portata_mandata,2) as portata_mandata
     , iter_edit_num(a.potenza_mandata,2) as potenza_mandata
     , iter_edit_num(a.portata_ripresa,2) as portata_ripresa
     , iter_edit_num(a.potenza_ripresa,2) as potenza_ripresa
     , b.descr_cost
  from coimtrat_aria_aimp a left outer join coimcost b on b.cod_cost = a.cod_cost
 where a.cod_impianto = :cod_impianto
order by a.num_ut
       </querytext>
    </fullquery>

   <fullquery name="sel_recu_calo_aimp"><!--gab01-->
       <querytext>
select a.cod_recu_calo_aimp
     , a.cod_impianto
     , a.num_rc
     , iter_edit_data(a.data_installaz)   as data_installaz
     , iter_edit_data(a.data_dismissione) as data_dismissione
     , a.tipologia
     , a.installato_uta_vmc
     , case installato_uta_vmc
            when 'U' then 'UTA'
            when 'V' then 'VMC'
            else          ''
       end                   as installato_uta_vmc
    
     , case indipendente
            when 'S' then 'Si'
            when 'N' then 'No'
            else          ''
       end                   as indipendente

     , iter_edit_num(a.portata_mandata,2) as portata_mandata
     , iter_edit_num(a.potenza_mandata,2) as potenza_mandata
     , iter_edit_num(a.portata_ripresa,2) as portata_ripresa
     , iter_edit_num(a.potenza_ripresa,2) as potenza_ripresa
  from coimrecu_calo_aimp a
 where a.cod_impianto = :cod_impianto
order by a.num_rc
       </querytext>
    </fullquery>	
	
	<fullquery name="sel_vent_aimp"><!--gab01-->
       <querytext>
select a.cod_vent_aimp
     , a.cod_impianto
     , a.num_vm
     , iter_edit_data(a.data_installaz)   as data_installaz
     , iter_edit_data(a.data_dismissione) as data_dismissione
	 , a.modello
	 , case tipologia
	        when 'S' then 'Sola estrazione'
			when 'I' then 'Flusso doppio con recupero tramite scambiatore a flussi incrociati'
			when 'T' then 'Flusso doppio con recupero termodinamico'
			when 'A' then 'Altro'
	   end                                as tipologia
	 , a.note_tipologia_altro
	 , iter_edit_num(a.portata_aria,2)    as portata_aria
     , iter_edit_num(a.rendimento_rec,2)  as rendimento_rec
	 , b.descr_cost
  from coimvent_aimp a left outer join coimcost b on b.cod_cost = a.cod_cost
 where a.cod_impianto = :cod_impianto
order by a.num_vm
       </querytext>
	   </fullquery>
	
</queryset>
