<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_tab_fields">
       <querytext>
       select nome_colonna
             ,denominazione as nome_colonna_decodificata
	 from coimtabs
	      where nome_tabella = :table_name
	      order by ordinamento
	</querytext>    
    </fullquery>

    <fullquery name="sel_scar">
       <querytext>
select 
   -- cod_ente
    a.cod_impianto
   ,a.cod_impianto_est
   ,a.potenza
   ,a.potenza_utile
   ,a.cod_potenza
   ,a.cod_tpim as tipo_impianto
   ,a.n_generatori
   ,a.flag_dpr412
   ,a.cod_combustibile
   ,a.stato
   ,a.cod_via
   ,a.localita
   ,a.toponimo
   ,a.indirizzo
   ,a.numero
   ,a.esponente
   ,a.scala
   ,a.piano
   ,a.interno
   ,a.cod_qua
   ,a.cod_urb
   ,a.cod_comune
   ,a.cod_provincia
   ,a.cap
   ,a.flag_dichiarato
   ,a.anno_costruzione
   ,a.data_installaz
   ,a.data_attivaz
   ,a.data_rottamaz
   ,a.stato_conformita
   ,a.cod_cted
   ,a.cod_tpdu
   ,a.marc_effic_energ
   ,a.volimetria_risc
   ,a.consumo_annuo
   ,b.um as funz_consumo_um
   ,a.data_ins
   ,a.data_mod
   ,a.utente
   ,a.gb_x
   ,a.gb_y
   ,a.flag_coordinate
from coimaimp a
   , coimcomb b
where 
     a.cod_combustibile = b.cod_combustibile
order by 
     cod_impianto
   , cod_impianto_est
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp">
       <querytext>
select
     d.data_controllo
    ,a.data_prima_dich
    ,a.data_ultim_dich
    ,a.data_scad_dich
    ,d.osservazioni
    ,d.raccomandazioni
    ,d.prescrizioni
from coimaimp a
   , coimdimp d
where 
     a.cod_impianto = d.cod_impianto
 and a.cod_impianto = :cod_impianto
group by
     data_controllo
    ,data_prima_dich
    ,data_ultim_dich
    ,data_scad_dich
    ,osservazioni
    ,raccomandazioni
    ,prescrizioni
order by data_controllo asc
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp">
       <querytext>
select
   data_controllo  
  ,note_conf
  ,esito_verifica
from coimcimp 
where cod_impianto = :cod_impianto
group by 
   data_controllo  
  ,note_conf
  ,esito_verifica
order by data_controllo asc
       </querytext>
    </fullquery>

    <fullquery name="sel_anom_dimp">
       <querytext>
       select count(*) as f_anomalie_autocert
         from coimanom a
            , coimdimp d
        where a.cod_cimp_dimp = d.cod_dimp
          and d.cod_impianto = :cod_impianto            
	  and a.flag_origine = :flag_orig
       </querytext>
    </fullquery>

    <fullquery name="sel_anom_cimp">
       <querytext>
       select count(*) as f_anomalie_rapporto
         from coimanom a
            , coimcimp d
        where a.cod_cimp_dimp = d.cod_cimp
          and d.cod_impianto = :cod_impianto            
	  and a.flag_origine = :flag_orig
       </querytext>
    </fullquery>

    <fullquery name="list_anom">
       <querytext>
       select cod_tanom 
         from coimanom a
        where a.cod_cimp_dimp = :codice_verifica 
	      and a.flag_origine = :flag_orig
       </querytext>
    </fullquery>

    <fullquery name="sel_database_ente">
	<querytext>
	select database_ente
	from coimereg
	where cod_iter = :codice_ente
	</querytext>
    </fullquery>

    <fullquery name="sel_opve">
       <querytext>
          select cognome
               , nome
            from coimopve
           where cod_opve = :f_cod_tecn
       </querytext>
    </fullquery>

</queryset>

