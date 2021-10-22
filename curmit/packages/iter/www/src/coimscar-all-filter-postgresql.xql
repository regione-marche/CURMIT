<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_tecn">
       <querytext>
             select cognome as f_cog_tecn
                  , nome    as f_nom_tecn
               from coimopve
              where cod_opve = :f_cod_tecn
       </querytext>
    </fullquery>

    <fullquery name="sel_tecn_nom">
       <querytext>
             select cod_opve as cod_tecn_db
               from coimopve
              where cod_enve       = :f_cod_enve
                and upper(nome)    = upper(:f_nom_tecn)
                and upper(cognome) = upper(:f_cog_tecn)
       </querytext>
    </fullquery>

    <fullquery name="sel_nome_tecn">
       <querytext>
             select cognome
                  , nome
               from coimopve
              where cod_opve = :f_cod_tecn
       </querytext>
    </fullquery>

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
select a.cod_impianto_est
     , a.cod_impianto
     , p.nome as nome_prop
     , p.cognome as cognome_prop
     , p.indirizzo as indirizzo_prop
     , p.numero as numero_prop
     , p.comune as comune_prop
     , p.provincia        as provincia_prop
     , p.natura_giuridica as natura_prop
     , p.cap    as cap_prop
     , p.cod_fiscale      as cfisc_prop
     , p.telefono         as telefono_prop
     , p.localita as localita_prop
     , o.nome   as nome_occu
     , o.cognome as cognome_occu
     , o.natura_giuridica as natura_occu
     , o.cod_fiscale      as cfisc_occu
     , o.telefono         as telefono_occu
     , f.nome as nome_manu
     , f.cognome as cognome_manu
     , f.indirizzo as indirizzo_manu
     , f.comune as comune_manu
     , f.telefono as telefono_manu
     , f.cap as cap_manu
     , f.cod_fiscale as cfisc_manu
     , f.localita as localita_manu
     , f.provincia as provincia_manu
     , f.flag_convenzionato as convenzionato
     , r.nome as nome_intestatario
     , r.cognome as cognome_intestatario
     , r.indirizzo as indirizzo_intestatario
     , r.numero as numero_intestatario
     , r.comune as comune_intestatario
     , r.provincia        as provincia_intestatario
     , r.natura_giuridica as natura_intestatario
     , r.cap    as cap_intestatario
     , r.cod_fiscale      as cfisc_intestatario
     , r.telefono         as telefono_intestatario
     , r.localita as localita_intestatario
     , q.nome as nome_terzi
     , q.cognome as cognome_terzi
     , q.indirizzo as indirizzo_terzi
     , q.numero as numero_terzi
     , q.comune as comune_terzi
     , q.provincia        as provincia_terzi
     , q.natura_giuridica as natura_terzi
     , q.cap    as cap_terzi
     , q.cod_fiscale      as cfisc_terzi
     , q.telefono         as telefono_terzi
     , q.localita as localita_terzi
     , d.denominazione    as comune
     , a.localita
     , a.cap
     , g.descr_topo as toponimo
     , g.descrizione as indirizzo
     , a.numero
     , a.esponente
     , z.sigla as provincia
     , a.flag_dpr412
     , a.cod_tpim as tipo_impianto
     , a.flag_resp
     , a.potenza
     , a.potenza_utile
     , a.cod_potenza
     , a.data_installaz
    , case
         when e.descr_comb is null then 'NON NOTO'
         else e.descr_comb
       end as descr_comb
     , m.nome as nome_amm
     , m.cognome as cognome_amm
     , m.indirizzo as indirizzo_amm
     , m.numero as numero_amm
     , m.comune as comune_amm
     , m.provincia        as provincia_amm
     , m.natura_giuridica as natura_amm
     , m.cap    as cap_amm
     , m.cod_fiscale      as cfisc_amm
     , m.telefono         as telefono_amm
     , m.localita as localita_amm
     , a.n_generatori
     , a.data_installaz
     , a.data_attivaz
     , a.data_rottamaz
     , a.stato
     , a.flag_dichiarato
     , a.data_prima_dich
     , a.data_ultim_dich
     , a.consumo_annuo
     , a.stato_conformita
     , a.cod_cted
     , a.tariffa
     , a.cod_amag
     , a.scala
     , a.piano
     , a.interno
     , a.cod_tpdu
     , a.cod_qua
     , a.cod_urb
     , a.data_ins
     , a.data_mod
     , a.utente
     , a.cod_impianto_dest
     , a.anno_costruzione
     , a.marc_effic_energ
     , a.volimetria_risc
     , a.gb_x
     , a.gb_y
     , a.provenienza_dati
     , a.note as note_impianto
     , a.data_scad_dich
     , h.descrizione
     , h.matricola
     , h.modello
     , h.matricola_bruc
     , h.modello_bruc
     , h.tipo_foco
     , h.mod_funz
     , h.cod_utgi
     , h.tipo_bruciatore
     , h.tiraggio
     , h.locale
     , h.cod_emissione
     , h.data_installaz as data_installaz_gend
     , h.pot_focolare_lib
     , h.pot_utile_lib
     , h.pot_focolare_nom
     , h.pot_utile_nom
     , h.note
     , h.gen_prog
     , h.flag_attivo
     , h.campo_funzion_min
     , h.campo_funzion_max
     , h.data_costruz_gen
     , h.data_rottamaz as data_rottamaz_gen
     , i.descr_cost as costruttore_gen
     , l.descr_cost as costruttore_bruc
     , n.descr_comb as comb_gen
     , k.nome as nome_prog
     , k.cognome as cognome_prog
     , k.indirizzo as indirizzo_prog
     , k.localita  as localita_prog
     , k.comune as comune_prog
     , k.telefono as telefono_prog
     , k.cap as cap_prog
     , k.cod_fiscale as cfisc_prog
     , k.provincia as provincia_prog
  from coimaimp a
 left outer join coimcitt p on  a.cod_proprietario = p.cod_cittadino
 left outer join coimcitt o on  a.cod_occupante = o.cod_cittadino
 left outer join coimcitt m on  a.cod_amministratore = m.cod_cittadino
 left outer join coimcitt r on  a.cod_intestatario = r.cod_cittadino
 left outer join coimcitt q on  a.cod_responsabile = q.cod_cittadino
 left outer join coimcomu d on  a.cod_comune    = d.cod_comune
 left outer join coimcomb e on  a.cod_combustibile = e.cod_combustibile
 left outer join coimmanu f on  a.cod_manutentore = f.cod_manutentore
 left outer join coimprog k on  a.cod_progettista = k.cod_progettista
 left outer join coimprov z on  a.cod_provincia = z.cod_provincia
 left outer join coimviae g on  a.cod_via = g.cod_via and a.cod_comune = g.cod_comune,
      coimgend h  left outer join coimcost i on  h.cod_cost = i.cod_cost 
 left outer join coimcost l on  h.cod_cost_bruc = l.cod_cost 
 left outer join coimcomb n on  h.cod_combustibile = n.cod_combustibile 
 where a.cod_impianto = h.cod_impianto
   $where_cout_im
   and a.stato in ('A', 'D', 'N' , 'R', 'L', 'V')
   and a.cod_impianto_est is not null 
 order by a.cod_impianto_est
        , h.gen_prog
       </querytext>
    </fullquery>


    <fullquery name="sel_cimp">
       <querytext>
select
  a.cod_cimp as codice_verifica
, e.cod_impianto_est
, a.gen_prog              
, a.data_controllo
, a.cod_cimp as numero_rapporto        
, c.nome as nome_veri
, c.cognome as cognome_veri
, a.presenza_libretto     
, a.libretto_manutenz     
, a.stato_coiben          
, a.verifica_areaz        
, a.rend_comb_conv        
, a.rend_comb_min         
, a.indic_fumosita_1a     
, a.indic_fumosita_2a     
, a.indic_fumosita_3a     
, a.indic_fumosita_md     
, a.temp_h2o_out_1a       
, a.temp_h2o_out_2a       
, a.temp_h2o_out_3a       
, a.temp_h2o_out_md       
, a.t_aria_comb_1a        
, a.t_aria_comb_2a        
, a.t_aria_comb_3a        
, a.t_aria_comb_md        
, a.temp_fumi_1a          
, a.temp_fumi_2a          
, a.temp_fumi_3a          
, a.temp_fumi_md          
, a.co_1a                
, a.co_2a                
, a.co_3a                
, a.co_md                
, a.co2_1a                
, a.co2_2a                
, a.co2_3a                
, a.co2_md                
, a.o2_1a                 
, a.o2_2a                 
, a.o2_3a                 
, a.o2_md                 
, a.temp_mant_1a          
, a.temp_mant_2a          
, a.temp_mant_3a          
, a.temp_mant_md          
, a.note_conf             
, f.descr_comb as cod_combustibile      
, a.verb_n 
, a.data_verb             
, a.libretto_corretto     
, a.mis_pot_focolare      
, a.stato_canna_fum       
, a.eccesso_aria_perc     
, a.eccesso_aria_perc_2a  
, a.eccesso_aria_perc_3a  
, a.eccesso_aria_perc_md  
, a.perdita_ai_fumi       
, a.manutenzione_8a       
, a.co_fumi_secchi_8b     
, a.indic_fumosita_8c     
, a.rend_comb_8d          
, a.esito_verifica        
, a.note_verificatore     
, a.note_resp             
, a.pot_utile_nom         
, a.pot_focolare_nom      
, b.nome as nome_resp
, b.cognome as cognome_resp
, b.indirizzo as indirizzo_resp
, b.comune as comune_resp
, b.provincia as provincia_resp
, b.natura_giuridica as natura_giuridica_resp
, b.cap as cap_resp
, b.cod_fiscale as cod_fiscale_resp
, b.telefono as telefono_resp
, a.new1_data_dimp        
, a.new1_data_paga_dimp   
, a.new1_conf_locale      
, a.new1_conf_accesso     
, a.new1_pres_intercet    
, a.new1_pres_interrut    
, a.new1_asse_mate_estr   
, a.new1_pres_mezzi       
, a.new1_pres_cartell     
, a.new1_disp_regolaz     
, a.new1_foro_presente    
, a.new1_foro_corretto    
, a.new1_foro_accessibile 
, a.new1_canali_a_norma   
, a.new1_lavoro_nom_iniz  
, a.new1_lavoro_nom_fine  
, a.new1_data_ultima_manu 
, a.new1_data_ultima_anal 
, a.new1_co_rilevato      
, a.costo                 
, a.nominativo_pres       
, a.dich_conformita       
, a.mis_port_combust      
, a.strumento             
, a.marca_strum           
, a.modello_strum         
, a.matr_strum            
, a.dt_tar_strum          
, a.tipologia_costo       
, a.riferimento_pag       
, a.utente                
, a.data_ins
, a.data_mod              
, a.flag_pericolosita     
, a.flag_tracciato        
, a.new1_note_manu        
, a.new1_dimp_pres        
, a.new1_dimp_prescriz    
, a.new1_manu_prec_8a     
, a.new1_flag_peri_8p     
, a.pendenza              
, a.ventilaz_lib_ostruz   
, a.disp_reg_cont_pre     
, a.disp_reg_cont_funz    
, a.disp_reg_clim_funz    
, a.volumetria            
, a.comsumi_ultima_stag   
, a.data_prot             
, a.n_prot
, a.effic_evac
, a.doc_prev_incendi
, a.conf_imp_elettrico
, a.libr_manut_bruc
, a.new1_asse_mate_estr
, a.new1_pres_interrut
, a.new1_pres_cartell
, a.new1_pres_intercet
, a.new1_pres_mezzi
, a.new1_conf_accesso
, a.disp_reg_cont_pre
, a.ora_inizio
, a.ora_fine
, e.stato
 ,a.potenza_effettiva_nom     
 ,a.potenza_effettiva_util 
 ,a.interna_locale_idoneo  
 ,a.esterna_generatore_idoneo
 ,a.canale_fumo_idoneo  
 ,a.ventilazione_locali 
 ,a.areazione_locali 
 ,a.ventilazione_locali_mis 
 ,a.verifica_disp_regolazione 
 ,a.frequenza_manut 
 ,a.rcee_osservazioni  
 ,a.rcee_raccomandazioni 
 ,a.misurazione_rendimento 
 ,a.check_valvole  
 ,a.check_isolamento 
 ,a.check_trattamento
 ,a.check_regolazione 
 ,a.dimensionamento_gen
 ,a.frequenza_manut_altro 
 ,a.potenza_nom_tot_foc 
 ,a.potenza_nom_tot_util
 ,a.tratt_in_risc  
 ,a.tratt_in_acs 
 ,a.norm_7a  
 ,a.norm_9a 
 ,a.norm_9b 
 ,a.norm_9c  
 ,a.ass_perdite_comb     
from 
  coimcimp a
  left outer join coimcitt b on a.cod_responsabile =  b.cod_cittadino
  left outer join coimcomb f on a.cod_combustibile = f.cod_combustibile,
  coimopve c,
  coimaimp e
 where 1=1
   $where_cout_ri
   and a.cod_opve = c.cod_opve
   and a.cod_impianto = e.cod_impianto
   and e.stato in ('A', 'D', 'N' , 'R', 'L', 'V')
   and e.cod_impianto_est is not null 
order by
  e.cod_impianto_est
, a.gen_prog              
, a.data_controllo

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

    <fullquery name="sel_auto">
       <querytext>
  select
      a.cod_dimp as codice_verifica
    , d.cod_impianto_est
    , a.data_controllo 
    , a.gen_prog
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
    , a.esame_vis_l_elet
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
    , a.flag_status
    , a.flag_co_perc
    , a.data_ins
    , a.data_mod
    , a.utente
    , d.stato
    , a.rct_dur_acqua
    , a.rct_tratt_in_risc
    , a.rct_tratt_in_acs
    , a.rct_install_interna
    , a.rct_install_esterna
    , a.rct_canale_fumo_idoneo
    , a.rct_sistema_reg_temp_amb
    , a.rct_assenza_per_comb
    , a.rct_idonea_tenuta
    , a.rct_scambiatore_lato_fumi
    , a.rct_riflussi_comb
    , a.rct_uni_10389
    , a.rct_rend_min_legge
    , a.rct_check_list_1
    , a.rct_check_list_2
    , a.rct_check_list_3
    , a.rct_check_list_4
    , a.rct_gruppo_termico
    , a.rct_valv_sicurezza
    , a.rct_lib_uso_man_comp
    , c.descr_comb
    , g.data_installaz as data_installaz_gend
    , g.tiraggio as tiraggio_gend
     from coimdimp a
left join coimmanu f on f.cod_manutentore = a.cod_manutentore
left join coimcitt o on o.cod_cittadino   = a.cod_occupante
left join coimcitt b on b.cod_cittadino   = a.cod_responsabile
        , coimaimp d
        , coimgend g
left join coimcomb c on c.cod_combustibile = g.cod_combustibile
    where 1 = 1
     $where_cout_au
      and d.cod_impianto      = a.cod_impianto
      and d.stato            in ('A', 'D', 'N' , 'R', 'L', 'V')
      and d.cod_impianto_est is not null 
      and g.cod_impianto      = a.cod_impianto
      and g.gen_prog          = a.gen_prog
  order by a.cod_impianto
         , a.data_controllo 
         , a.gen_prog
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
