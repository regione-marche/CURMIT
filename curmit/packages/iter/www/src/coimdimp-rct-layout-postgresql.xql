<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom02 08/02/2020 In fase di stapma il campo marc_effic_energ in poteva contenere i 
    rom02            caratteri < e > che venivano considerati come apertura o chiusura dei
    rom02            tag html. In questi casi la stampa veniva visualizzata solo parzialmente.
    rom02            Per risolvere abbiamo usato il replace.

    gac05 17/12/2018 Aggiunta targa

    gac04 05/12/2018 Aggiunto campo cod_grup_term che varrà solo per Regione Marche

    gac03 15/11/2018 Aggiunto campi come richiesto nel documento inviatoci dalla Regione
    gac03            Marche. (Campi visibili solo da Regione Marche)
    
    gac02 08/06/2018 Aggiunti campi elettricità

    rom01 07/06/2018 Aggiunto campo co _fumi_secchi_ppm

    gac01 08/05/2018 Aggiunti campi

    sim05 30/07/2018 Nell'indirizzo del manutentore deve essere visualizzato il comune e non la 
    sim05            località a meno che il comune non sia vuoto

    sim03 13/05/2018 Se presente la tariffa regionale va aggiunta all'importo del bollino nella stampa

    sim02 17/10/2016 In caso di bollino virtuale visualizzo il prezzo.

    nic01 23/05/2014 Ora il generatore si desume dalla coimdimp perche' viene scelto 
    nic01            dall'utente in fase di inserimento
-->

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_dimp_si_vie">
       <querytext>
                      select
                        a.cod_potenza
                       ,substr(a.data_installaz,1,4) as anno_costruzione
                       ,iter_edit_data(b.data_installaz) as data_installaz
                       ,iter_edit_num(a.potenza,2)       as pot_ter_nom_tot_max
                       ,iter_edit_num(j.potenza,2)       as potenza
		       ,a.cod_combustibile
                       ,b.cod_cost
                       ,c.descr_cost
                       ,b.modello
                       ,b.matricola
                       ,j.cod_manutentore
                       ,a.cod_proprietario
                       ,coalesce(k.cognome, '')||' '||
                        coalesce(k.nome, '') as nominativo_prop
                       ,d.cognome as cognome_resp
                       ,d.nome as nome_resp
		       ,d.cod_fiscale --gac03
                       ,d.indirizzo as indirizzo_resp
		       ,d.numero    as numero_resp
                       ,d.localita as localita_resp
                       ,d.comune as comune_resp
                       ,d.provincia as provincia_resp
                       ,d.cap as cap_resp
                       ,d.telefono as telefono_resp
		       ,a.cod_occupante
                       ,e.cognome as cognome_util
		       ,e.nome as nome_util
                       ,e.indirizzo as indirizzo_util
		       ,e.numero    as numero_util
                       ,e.localita as localita_util
                       ,e.comune as comune_util
                       ,e.provincia as provincia_util
                       ,e.cap as cap_util
                       ,coalesce(g.descr_topo,'')||' '||
                        coalesce(g.descr_estesa,'')||' '||
                        coalesce(a.numero, '')||' '||
                        coalesce(a.esponente,'') as indirizzo_ubic
                       ,a.localita as localita_ubic
                       ,h.denominazione as comune_ubic
                       ,i.denominazione as provincia_ubic
                       ,a.cap as cap_ubic
                       ,j.garanzia
                       ,j.conformita
                       ,j.lib_impianto
                       ,j.lib_uso_man
                       ,j.inst_in_out
                       ,j.idoneita_locale
                       ,j.ap_ventilaz
                       ,j.ap_vent_ostruz
                       ,j.pendenza
                       ,j.sezioni
                       ,j.curve
                       ,j.lunghezza
                       ,j.conservazione
                       ,j.scar_ca_si
                       ,j.scar_can_fu
                       ,j.scar_parete
                       ,j.riflussi_locale
                       ,j.assenza_perdite
                       ,j.pulizia_ugelli
                       ,j.antivento
                       ,j.scambiatore
                       ,j.accens_reg
                       ,j.disp_comando
                       ,j.ass_perdite
                       ,j.valvola_sicur
                       ,j.vaso_esp
                       ,j.disp_sic_manom
                       ,j.organi_integri
                       ,j.circ_aria
                       ,j.guarn_accop
                       ,j.assenza_fughe
                       ,j.coibentazione
                       ,j.eff_evac_fum
                       ,j.cont_rend
                       ,iter_edit_data(j.data_controllo) as data_controllo
                       ,iter_edit_num(j.temp_fumi,2) as temp_fumi
                       ,iter_edit_num(j.temp_ambi,2) as temp_ambi
                       ,iter_edit_num(j.o2,2) as o2
                       ,iter_edit_num(j.co2,2) as co2
                       ,iter_edit_num(j.bacharach,0) as bacharach
                       ,iter_edit_num(j.co,2) as co
                       ,iter_edit_num(j.co_fumi_secchi_ppm,2) as co_fumi_secchi_ppm --rom01
                       ,iter_edit_num(j.rend_combust,2) as rend_combust
                       ,j.osservazioni
                       ,j.raccomandazioni
                       ,j.prescrizioni
                       ,j.data_utile_inter
                       ,j.n_prot
                       ,j.data_prot
                       ,j.delega_resp as firma_resp
                       ,j.delega_manut as firma_manut
                       ,j.tipologia_costo
                       ,j.riferimento_pag
                       ,j.cod_documento
                       ,j.flag_co_perc
                       ,a.cod_responsabile
                       ,j.data_controllo as data_controllo_db

                       ,iter_edit_num(j.tiraggio,2) as tiraggio_fumi
                       ,iter_edit_time(j.ora_inizio) as ora_inizio
                       ,iter_edit_time(j.ora_fine) as ora_fine
                       ,j.rapp_contr
                       ,j.rapp_contr_note
                       ,j.certificaz
                       ,j.certificaz_note
                       ,j.dich_conf
                       ,j.dich_conf_note
                       ,j.libretto_bruc
                       ,j.libretto_bruc_note
                       ,j.prev_incendi
                       ,j.prev_incendi_note
                       ,j.lib_impianto_note
                       ,j.ispesl
                       ,j.ispesl_note
                       ,iter_edit_data(j.data_scadenza) as data_scadenza_autocert
                       ,j.num_autocert
                       ,j.esame_vis_l_elet
                       ,j.funz_corr_bruc
                       ,j.lib_uso_man_note
                       ,b.locale
                       ,iter_edit_data(b.data_costruz_gen) as data_costruz_gen
                       ,iter_edit_data(b.data_costruz_bruc) as data_costruz_bruc
                       ,replace(replace(b.marc_effic_energ,'>','&gt;'),'<','&lt;') as marc_effic_energ --rom02 b.marc_effic_energ
                       ,iter_edit_num(j.volimetria_risc,2) as volimetria_risc
                       ,iter_edit_num(j.consumo_annuo,2) as consumo_annuo
                       ,iter_edit_num(b.pot_focolare_nom,2) as pot_focolare_nom
                       ,b.mod_funz
                       ,b.tipo_bruciatore
                       ,iter_edit_num(b.campo_funzion_max,2) as campo_funzion_max
                       ,b.matricola_bruc
                       ,b.modello_bruc
                       ,l.descr_cost as costruttore_bruc
                       ,a.cod_impianto_est
                       ,m.sigla as prov_ubic
                       ,a.flag_resp
                       ,n.descr_utgi as destinazione
                       ,j.flag_status
                       ,j.flag_status
                       ,j.rct_dur_acqua    
                       ,j.rct_tratt_in_risc       
                       ,j.rct_tratt_in_acs       
                       ,j.rct_install_interna      
                       ,j.rct_install_esterna     
                       ,j.rct_canale_fumo_idoneo  
                       ,j.rct_sistema_reg_temp_amb 
                       ,j.rct_assenza_per_comb     
                       ,j.rct_idonea_tenuta         
                       ,j.rct_valv_sicurezza      
                       ,j.rct_scambiatore_lato_fumi 
                       ,j.rct_riflussi_comb         
                       ,j.rct_uni_10389             
                       ,iter_edit_num(j.rct_rend_min_legge,2) as rct_rend_min_legge
                       ,j.rct_modulo_termico
                       ,j.rct_check_list_1          
                       ,j.rct_check_list_2          
                       ,j.rct_check_list_3         
                       ,j.rct_check_list_4          
                       ,j.rct_gruppo_termico  
                       ,j.rct_lib_uso_man_comp
                       ,j.cod_opmanu_new
                       ,iter_edit_data(j.data_prox_manut) as data_prox_manut
		       -- sim03 iter_edit_num(j.costo,2)  as costo_pretty --sim02
                       ,iter_edit_num(j.costo + coalesce(j.importo_tariffa,0),2)  as costo_pretty --sim03
		       ,iter_edit_num(j.consumo_annuo2,2) as consumo_annuo2          --gac01
		       ,j.stagione_risc                                              --gac01
		       ,j.stagione_risc2                                             --gac01
		       ,iter_edit_num(j.acquisti,2) as acquisti                      --gac01
		       ,iter_edit_num(j.acquisti2,2) as acquisti2                    --gac01
		       ,iter_edit_num(j.scorta_o_lett_iniz,2) as scorta_o_lett_iniz  --gac01
		       ,iter_edit_num(j.scorta_o_lett_iniz2,2) as scorta_o_lett_iniz2 --gac01
		       ,iter_edit_num(j.scorta_o_lett_fin,2) as scorta_o_lett_fin    --gac01
		       ,iter_edit_num(j.scorta_o_lett_fin2,2) as scorta_o_lett_fin2  --gac01
		       ,iter_edit_num(j.bacharach2,0) as bacharach2                  --gac01
		       ,iter_edit_num(j.bacharach3,0) as bacharach3                  --gac01
		       ,iter_edit_num(j.portata_comb,2) as portata_comb              --gac01
		       ,case when j.rispetta_indice_bacharach = 'S' then 'SI'        --gac01
		             when j.rispetta_indice_bacharach = 'N' then 'NO'        --gac01
			     end as rispetta_indice_bacharach                        --gac01
		       ,case when j.co_fumi_secchi = 'S' then 'SI'                   --gac01
                             when j.co_fumi_secchi = 'N' then 'NO'                   --gac01
                             end as co_fumi_secchi                                   --gac01
		       ,case when j.rend_magg_o_ugua_rend_min = 'S' then 'SI'        --gac01
                             when j.rend_magg_o_ugua_rend_min = 'N' then 'NO'        --gac01
                             end as rend_magg_o_ugua_rend_min                        --gac01
                       ,j.elet_esercizio_1            --gac02
		       ,j.elet_esercizio_2            --gac02
		       ,j.elet_esercizio_3            --gac02
		       ,j.elet_esercizio_4            --gac02
                       ,iter_edit_num(j.elet_lettura_iniziale, 2)   as elet_lettura_iniziale    --gac02
                       ,iter_edit_num(j.elet_lettura_finale, 2)     as elet_lettura_finale      --gac02
                       ,iter_edit_num(j.elet_consumo_totale, 2)     as elet_consumo_totale      --gac02
                       ,iter_edit_num(j.elet_lettura_iniziale_2, 2) as elet_lettura_iniziale_2  --gac02
                       ,iter_edit_num(j.elet_lettura_finale_2, 2)   as elet_lettura_finale_2    --gac02
                       ,iter_edit_num(j.elet_consumo_totale_2, 2)   as elet_consumo_totale_2    --gac02
                       ,a.scala   --gac03
                       ,a.interno --gac03
                       ,b.flag_clima_invernale --gac03
		       ,b.flag_prod_acqua_calda --gac03
       		       ,b.cod_grup_term  --gac04
                       ,o.descr_tprc     --gac04
		       ,a.targa          --gac05
		  from coimdimp j
                  left outer join coimgend b on b.cod_impianto = j.cod_impianto
                                            and b.gen_prog     =  :gen_progg
                  left outer join coimcost c on c.cod_cost     = b.cod_cost 
                       inner join coimaimp a on a.cod_impianto = j.cod_impianto
                  left outer join coimcitt d on d.cod_cittadino = a.cod_responsabile
                  left outer join coimcitt e on e.cod_cittadino = a.cod_occupante     
                  left outer join coimcitt k on k.cod_cittadino = a.cod_proprietario
                  left outer join coimviae g on  g.cod_comune    = a.cod_comune
                                             and g.cod_via       = a.cod_via
                  left outer join coimcomu h on  h.cod_comune    = a.cod_comune
                  left outer join coimprov i on  i.cod_provincia = a.cod_provincia
                  left outer join coimcost l on l.cod_cost       = b.cod_cost_bruc
                  left outer join coimprov m on m.cod_provincia  = a.cod_provincia
                  left outer join coimutgi n on n.cod_utgi       = b.cod_utgi
                  left outer join coimtprc o on o.cod_tprc       = j.cod_tprc --gac04
                 where j.cod_dimp     = :cod_dimp
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_no_vie">
       <querytext>
                      select
                        a.cod_potenza
                       ,substr(a.data_installaz,1,4) as anno_costruzione
                       ,iter_edit_data(a.data_installaz) as data_installaz
                       ,iter_edit_num(a.potenza,2)       as pot_ter_nom_tot_max
                       ,iter_edit_num(j.potenza,2)       as potenza
		       ,a.cod_combustibile
                       ,b.cod_cost
                       ,c.descr_cost
                       ,b.modello
                       ,b.matricola
                       ,j.cod_manutentore
                       ,a.cod_proprietario
                       ,coalesce(k.cognome, '')||' '||
                        coalesce(k.nome, '') as nominativo_prop
                       ,d.cognome as cognome_resp
                       ,d.nome as nome_resp
                       ,d.indirizzo as indirizzo_resp
		       ,d.numero    as numero_resp
                       ,d.localita as localita_resp
                       ,d.comune as comune_resp
                       ,d.provincia as provincia_resp
                       ,d.cap as cap_resp
                       ,d.telefono as telefono_resp
		       ,a.cod_occupante
                       ,e.cognome as cognome_util
		       ,e.nome as nome_util
                       ,e.indirizzo as indirizzo_util
		       ,e.numero    as numero_util
                       ,e.localita as localita_util
                       ,e.comune as comune_util
                       ,e.provincia as provincia_util
                       ,e.cap as cap_util
                       ,coalesce(a.toponimo,'')||' '||
                        coalesce(a.indirizzo,'')||' '||
                        coalesce(a.numero, '')||' '||
                        coalesce(a.esponente,'') as indirizzo_ubic
                       ,a.localita as localita_ubic
                       ,h.denominazione as comune_ubic
                       ,i.denominazione as provincia_ubic
                       ,a.cap as cap_ubic
                       ,j.garanzia
                       ,j.conformita
                       ,j.lib_impianto
                       ,j.lib_uso_man
                       ,j.inst_in_out
                       ,j.idoneita_locale
                       ,j.ap_ventilaz
                       ,j.ap_vent_ostruz
                       ,j.pendenza
                       ,j.sezioni
                       ,j.curve
                       ,j.lunghezza
                       ,j.conservazione
                       ,j.scar_ca_si
                       ,j.scar_can_fu
                       ,j.scar_parete
                       ,j.riflussi_locale
                       ,j.assenza_perdite
                       ,j.pulizia_ugelli
                       ,j.antivento
                       ,j.scambiatore
                       ,j.accens_reg
                       ,j.disp_comando
                       ,j.ass_perdite
                       ,j.valvola_sicur
                       ,j.vaso_esp
                       ,j.disp_sic_manom
                       ,j.organi_integri
                       ,j.circ_aria
                       ,j.guarn_accop
                       ,j.assenza_fughe
                       ,j.coibentazione
                       ,j.eff_evac_fum
                       ,j.cont_rend
                       ,iter_edit_data(j.data_controllo) as data_controllo
                       ,iter_edit_num(j.temp_fumi,2) as temp_fumi
                       ,iter_edit_num(j.temp_ambi,2) as temp_ambi
                       ,iter_edit_num(j.o2,2) as o2
                       ,iter_edit_num(j.co2,2) as co2
                       ,iter_edit_num(j.bacharach,0) as bacharach
                       ,iter_edit_num(j.co,2) as co
                       ,iter_edit_num(j.co_fumi_secchi_ppm,2) as co_fumi_secchi_ppm --rom01
                       ,iter_edit_num(j.rend_combust,2) as rend_combust
                       ,j.osservazioni
                       ,j.raccomandazioni
                       ,j.prescrizioni
                       ,j.data_utile_inter
                       ,j.n_prot
                       ,j.data_prot
                       ,j.delega_resp as firma_resp
                       ,j.delega_manut as firma_manut
                       ,j.tipologia_costo
                       ,j.riferimento_pag
                       ,j.cod_documento
                       ,j.flag_co_perc
                       ,a.cod_responsabile
                       ,j.data_controllo as data_controllo_db

                       ,iter_edit_num(j.tiraggio,2) as tiraggio_fumi
                       ,iter_edit_time(j.ora_inizio) as ora_inizio
                       ,iter_edit_time(j.ora_fine) as ora_fine
                       ,j.rapp_contr
                       ,j.rapp_contr_note
                       ,j.certificaz
                       ,j.certificaz_note
                       ,j.dich_conf
                       ,j.dich_conf_note
                       ,j.libretto_bruc
                       ,j.libretto_bruc_note
                       ,j.prev_incendi
                       ,j.prev_incendi_note
                       ,j.lib_impianto_note
                       ,j.ispesl
                       ,j.ispesl_note
                       ,iter_edit_data(j.data_scadenza) as data_scadenza_autocert
                       ,j.num_autocert
                       ,j.esame_vis_l_elet
                       ,j.funz_corr_bruc
                       ,j.lib_uso_man_note
                       ,b.locale
                       ,iter_edit_data(b.data_costruz_gen) as data_costruz_gen
                       ,iter_edit_data(b.data_costruz_bruc) as data_costruz_bruc
                       ,replace(replace(b.marc_effic_energ,'>','&gt;'),'<','&lt;') as marc_effic_energ --rom02 b.marc_effic_energ  
                       ,iter_edit_num(j.volimetria_risc,2) as volimetria_risc
                       ,iter_edit_num(j.consumo_annuo,2) as consumo_annuo
                       ,iter_edit_num(b.pot_focolare_nom,2) as pot_focolare_nom
                       ,b.mod_funz
                       ,b.tipo_bruciatore
                       ,iter_edit_num(b.campo_funzion_max,2) as campo_funzion_max
                       ,b.matricola_bruc
                       ,b.modello_bruc
                       ,l.descr_cost as costruttore_bruc
                       ,a.cod_impianto_est
                       ,m.sigla as prov_ubic
                       ,a.flag_resp
                       ,n.descr_utgi as destinazione
                       ,j.flag_status
                       ,j.rct_dur_acqua    
                       ,j.rct_tratt_in_risc       
                       ,j.rct_tratt_in_acs       
                       ,j.rct_install_interna      
                       ,j.rct_install_esterna     
                       ,j.rct_canale_fumo_idoneo  
                       ,j.rct_sistema_reg_temp_amb 
                       ,j.rct_assenza_per_comb     
                       ,j.rct_idonea_tenuta         
                       ,j.rct_valv_sicurezza      
                       ,j.rct_scambiatore_lato_fumi 
                       ,j.rct_riflussi_comb         
                       ,j.rct_uni_10389             
                       ,iter_edit_num(j.rct_rend_min_legge,2) as rct_rend_min_legge
                       ,j.rct_modulo_termico
                       ,j.rct_check_list_1          
                       ,j.rct_check_list_2          
                       ,j.rct_check_list_3         
                       ,j.rct_check_list_4          
                       ,j.rct_gruppo_termico  
                       ,j.rct_lib_uso_man_comp
                       ,j.cod_opmanu_new
                       ,iter_edit_data(j.data_prox_manut) as data_prox_manut
                       ,iter_edit_num(j.costo,2)  as costo_pretty --sim02
		       ,iter_edit_num(j.consumo_annuo2,2) as consumo_annuo2          --gac01
		       ,j.stagione_risc                                              --gac01
		       ,j.stagione_risc2                                             --gac01
		       ,iter_edit_num(j.acquisti,2) as acquisti                      --gac01
		       ,iter_edit_num(j.acquisti2,2) as acquisti2                    --gac01
		       ,iter_edit_num(j.scorta_o_lett_iniz,2) as scorta_o_lett_iniz  --gac01
		       ,iter_edit_num(j.scorta_o_lett_iniz,2) as scorta_o_lett_iniz2 --gac01
		       ,iter_edit_num(j.scorta_o_lett_fin,2) as scorta_o_lett_fin    --gac01
		       ,iter_edit_num(j.scorta_o_lett_fin2,2) as scorta_o_lett_fin2  --gac01
		       ,iter_edit_num(j.bacharach2,0) as bacharach2                  --gac01
		       ,iter_edit_num(j.bacharach3,0) as bacharach3                  --gac01
		       ,iter_edit_num(j.portata_comb,2) as portata_comb              --gac01
		       ,case when j.rispetta_indice_bacharach = 'S' then 'SI'        --gac01
		             when j.rispetta_indice_bacharach = 'N' then 'NO'        --gac01
			     end as rispetta_indice_bacharach                        --gac01
		       ,case when j.co_fumi_secchi = 'S' then 'SI'                   --gac01
                             when j.co_fumi_secchi = 'N' then 'NO'                   --gac01
                             end as co_fumi_secchi                                   --gac01
		       ,case when j.rend_magg_o_ugua_rend_min = 'S' then 'SI'        --gac01
                             when j.rend_magg_o_ugua_rend_min = 'N' then 'NO'        --gac01
                             end as rend_magg_o_ugua_rend_min                        --gac01
                       ,j.elet_esercizio_1            --gac02
		       ,j.elet_esercizio_2            --gac02
		       ,j.elet_esercizio_3            --gac02
		       ,j.elet_esercizio_4            --gac02
		       ,iter_edit_num(j.elet_lettura_iniziale, 2)   as elet_lettura_iniziale    --gac02
                       ,iter_edit_num(j.elet_lettura_finale, 2)     as elet_lettura_finale      --gac02
                       ,iter_edit_num(j.elet_consumo_totale, 2)     as elet_consumo_totale      --gac02
                       ,iter_edit_num(j.elet_lettura_iniziale_2, 2) as elet_lettura_iniziale_2  --gac02
                       ,iter_edit_num(j.elet_lettura_finale_2, 2)   as elet_lettura_finale_2    --gac02
                       ,iter_edit_num(j.elet_consumo_totale_2, 2)   as elet_consumo_totale_2    --gac02
		       ,a.scala   --gac03
		       ,a.interno --gac03
		       ,b.flag_clima_invernale --gac03
		       ,b.flag_prod_acqua_calda --gac03
		       ,b.cod_grup_term  --gac04
                       ,o.descr_tprc     --gac04
		       ,a.targa          --gac05
                  from coimdimp j
                       left outer join coimgend b on b.cod_impianto = j.cod_impianto
                       and b.gen_prog     =  :gen_progg
                  left outer join coimcost c on c.cod_cost     = b.cod_cost 
                       inner join coimaimp a on a.cod_impianto = j.cod_impianto
                  left outer join coimcitt d on d.cod_cittadino = a.cod_responsabile
                  left outer join coimcitt e on e.cod_cittadino = a.cod_occupante     
                  left outer join coimcitt k on k.cod_cittadino = a.cod_proprietario
                  left outer join coimcomu h on  h.cod_comune    = a.cod_comune
                  left outer join coimprov i on  i.cod_provincia = a.cod_provincia
                  left outer join coimcost l on l.cod_cost       = b.cod_cost_bruc
                  left outer join coimprov m on m.cod_provincia  = a.cod_provincia
                  left outer join coimutgi n on n.cod_utgi       = b.cod_utgi
                  left outer join coimtprc o on o.cod_tprc       = j.cod_tprc --gac04
                 where j.cod_dimp     = :cod_dimp
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp">
       <querytext>
                   select modello
                        , descrizione
                        , tipo_foco as tipo_gen_foco
                        , tiraggio
                     from coimgend
                    where cod_impianto = :cod_impianto   
                      and gen_prog     = :gen_progg
       </querytext>
    </fullquery>

    <fullquery name="sel_comb">
       <querytext>
                   select descr_comb
                     from coimcomb
                    where cod_combustibile = :cod_combustibile
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
                  select nome
                       , cognome
                       , indirizzo
                    --sim05   , localita
                       , coalesce(comune,localita) as localita --sim05
                       , provincia
                       , telefono
                       , cod_piva --gac03
                       , comune   --gac03
                    from coimmanu
                   where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_opma">
       <querytext>
          select nome    as nome_op
               , cognome as cognome_op
            from coimopma 
           where cod_manutentore = :cod_manutentore
             and cod_opma        = :cod_opmanu_new 
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_next">
        <querytext>
           select nextval('coimdocu_s') as cod_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_docu">
        <querytext>
           select 1
             from coimdocu
            where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <partialquery name="ins_docu">
       <querytext>
                   insert
                     into coimdocu 
                        ( cod_documento
                        , tipo_documento
                        , cod_impianto
                        , data_documento
                        , data_stampa
			, protocollo_02
                        , data_prot_02
                        , tipo_soggetto
                        , cod_soggetto
                        , data_ins
                        , utente)
                   values
                        ( :cod_documento
                        , :tipo_documento
                        , :cod_impianto
                        , :data_controllo_db
                        , current_date
                        , :n_prot
                        , :data_prot
                        , 'C'
                        , :cod_responsabile
                        , current_date
                        , :id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_docu">
       <querytext>
                   update coimdocu
                      set data_documento = current_date
                        , data_mod       = current_date
                        , utente         = :id_utente
                    where cod_documento  = :cod_documento
       </querytext>
    </partialquery>

    <fullquery name="sel_docu_contenuto">
       <querytext>
          select contenuto as docu_contenuto_check
            from coimdocu
           where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <partialquery name="upd_docu_2">
       <querytext>
                   update coimdocu
                      set contenuto     = lo_unlink(coimdocu.contenuto)
                    where cod_documento = :cod_documento
       </querytext>
    </partialquery> 

    <partialquery name="upd_docu_3">
       <querytext>
                   update coimdocu
                   set tipo_contenuto = :tipo_contenuto
                     , contenuto      = lo_import(:contenuto_tmpfile)
                 where cod_documento  = :cod_documento
       </querytext>
    </partialquery> 

    <partialquery name="upd_dimp">
       <querytext>
                   update coimdimp
                      set cod_documento = :cod_documento
                    where cod_dimp      = :cod_dimp
       </querytext>
    </partialquery> 

    <fullquery name="sel_anom">
        <querytext>
           select cod_tanom
             from coimanom
            where cod_cimp_dimp = :cod_dimp
              and tipo_anom     = '1'
       </querytext>
    </fullquery>

    <fullquery name="sel_cod_gend">
       <querytext>
   -- nic01   select a.gen_prog as gen_progg 
   -- nic01     from coimgend a
   -- nic01        , coimdimp b
              select b.gen_prog as gen_progg -- nic01
                from coimdimp b              -- nic01
               where b.cod_dimp     =  :cod_dimp
   -- nic01      and a.cod_impianto = b.cod_impianto
   -- nic01      and a.flag_attivo  =  'S'
   -- nic01    order by a.gen_prog_est
   -- nic01    limit 1
      </querytext>
    </fullquery>

</queryset>
