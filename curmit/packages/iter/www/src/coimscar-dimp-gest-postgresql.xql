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

    <fullquery name="sel_auto">
       <querytext>
  select
      d.cod_impianto_est
    , a.data_controllo 
    , a.gen_prog
    , k.nome as nome_veri	
    , k.cognome as cognome_veri
    , f.cognome as cognome_manu
    , f.nome as nome_manu
    , f.indirizzo as indirizzo_manu
    , f.comune as comune_manu
    , f.telefono as telefono_manu
    , f.cap as cap_manu
    , f.cod_fiscale as cod_fiscale_manu
    , b.nome as nome_resp
    , b.cognome as cognome_resp
    , b.indirizzo as indirizzo_resp
    , b.comune as comune_resp
    , b.provincia as provincia_resp
    , b.natura_giuridica as natura_giuridica_resp
    , b.cap as cap_resp
    , b.cod_fiscale as cod_fiscale_resp
    , b.telefono as telefono_resp
    , o.nome as nome_occu
    , o.cognome as cognome_occu
    , o.indirizzo as indirizzo_occu
    , o.comune as comune_occu
    , o.provincia as provincia_occu
    , o.natura_giuridica as natura_giuridica_occu
    , o.cap as cap_occu
    , o.cod_fiscale as cod_fiscale_occu
    , o.telefono
    , a.garanzia
    , a.conformita 
    , a.lib_impianto
    , a.lib_uso_man
    , a.inst_in_out
    , a.rapp_contr
    , a.certificaz
    , a.libretto_bruc
    , a.ispesl
    , a.prev_incendi
    , a.esami_vis_l_elet
    , a.funz_corr_bruc
    , a.idoneita_locale
    , a.ap_ventilaz
    , a.ap_vent_ostruz
    , a.pendenza 
    , a.sezioni 
    , a.curve 
    , a.lunghezza
    , a.conservazione 
    , a.scar_ca_si
    , a.scar_parete
    , a.riflussi_locale 
    , a.assenza_perdite
    , a.pulizia_ugelli
    , a.antivento 
    , a.scambiatore
    , a.accens_reg
    , a.disp_comando
    , a.ass_perdite
    , a.valvola_sicur
    , a.vaso_esp
    , a.disp_sic_manom
    , a.organi_integri  
    , a.circ_aria
    , a.guarn_accop
    , a.assenza_fughe
    , a.coibentazione 
    , a.eff_evac_fum 
    , a.cont_rend  
    , a.pot_focolare_mis
    , a.portata_comb_mis
    , a.temp_fumi
    , a.temp_ambi 
    , a.o2
    , a.co2
    , a.bacharach
    , a.co 
    , a.rend_combust
    , a.osservazioni
    , a.raccomandazioni 
    , a.prescrizioni
    , a.data_utile_inter
    , a.n_prot
    , a.data_prot
    , a.delega_resp
    , a.delega_manut
    , a.num_bollo          
    , a.costo              
    , a.tipologia_costo    
    , a.riferimento_pag    
    , a.potenza            
    , a.flag_tracciato     
    , a.ora_inizio         
    , a.ora_fine           
    , a.data_scadenza      
    , a.num_autocert       
    , a.volimetria_risc    
    , a.consumo_annuo      
    , a.tiraggio
  from 
      coimdimp a
left outer join coimmanu f on  a.cod_manutentore = f.cod_manutentore
left outer join coimcitt o on  a.cod_occupante = o.cod_cittadino 
left outer join coimcitt b on  a.cod_responsabile = b.cod_cittadino
     , coiminco c      
     , coimopve k
     , coimaimp d
  where 1=1
    and a.cod_impianto = c.cod_impianto
    and k.cod_opve = :f_cod_tecn
    and c.cod_opve = :f_cod_tecn
    and a.cod_impianto = d.cod_impianto
  order by 
      a.cod_impianto
    , a.data_controllo 
    , a.gen_prog
    , f.cognome
    , f.nome
    , f.indirizzo
    , f.comune
    , f.telefono
    , f.cap
    , f.cod_fiscale
    , b.nome
    , b.cognome
    , b.indirizzo
    , b.comune
    , b.provincia
    , b.natura_giuridica
    , b.cap
    , b.cod_fiscale
    , b.telefono
    , o.nome
    , o.cognome
    , o.indirizzo
    , o.comune
    , o.provincia
    , o.natura_giuridica
    , o.cap
    , o.cod_fiscale
    , o.telefono
    , a.garanzia
    , a.conformita 
    , a.lib_impianto
    , a.lib_uso_man
    , a.inst_in_out
    , a.rapp_contr
    , a.certificaz
    , a.libretto_bruc
    , a.ispesl
    , a.prev_incendi
    , a.esami_vis_l_elet
    , a.idoneita_locale
    , a.ap_ventilaz
    , a.ap_vent_ostruz
    , a.pendenza 
    , a.sezioni 
    , a.curve 
    , a.lunghezza
    , a.conservazione 
    , a.scar_ca_si
    , a.scar_parete
    , a.riflussi_locale 
    , a.assenza_perdite
    , a.pulizia_ugelli
    , a.antivento 
    , a.scambiatore
    , a.accens_reg
    , a.disp_comando
    , a.ass_perdite
    , a.valvola_sicur
    , a.vaso_esp
    , a.disp_sic_manom
    , a.organi_integri  
    , a.circ_aria
    , a.guarn_accop
    , a.assenza_fughe
    , a.coibentazione 
    , a.eff_evac_fum 
    , a.cont_rend  
    , a.pot_focolare_mis
    , a.portata_comb_mis
    , a.temp_fumi
    , a.temp_ambi 
    , a.o2
    , a.co2
    , a.bacharach
    , a.co 
    , a.rend_combust
    , a.osservazioni
    , a.raccomandazioni 
    , a.prescrizioni
    , a.data_utile_inter
    , a.n_prot
    , a.data_prot
    , a.delega_resp
    , a.delega_manut
    , a.num_bollo          
    , a.costo              
    , a.tipologia_costo    
    , a.riferimento_pag    
    , a.potenza            
    , a.flag_tracciato     
    , a.ora_inizio         
    , a.ora_fine           
    , a.data_scadenza      
    , a.num_autocert       
    , a.volimetria_risc    
    , a.consumo_annuo
    , a.tiraggio
       </querytext>
    </fullquery>

    <fullquery name="list_anom">
       <querytext>
       select cod_tanom 
         from coimanom a
	    , coimcimp b
	    , coimaimp c
        where c.cod_impianto_est = :cod_impianto_est
          and c.cod_impianto = b.cod_impianto
          and b.cod_cimp = a.cod_cimp_dimp;
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

