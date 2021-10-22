<?xml version="1.0"?>
<!--
    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    sim01  10/09/2014 Aggiunto nuovo campo cod_impianto_princ
-->

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="get_cod_impianto_est">
       <querytext>
       select coimaimp_est_s.nextval as cod_impianto_est
         from dual
       </querytext>
    </fullquery>

   <partialquery name="upd_aimp_est">
       <querytext>
	, cod_impianto_est = :cod_impianto_est
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp">
       <querytext>
                update coimaimp
                   set cod_impianto_prov = :cod_impianto_prov
		     $cod_aimp_est
                     , provenienza_dati  = :provenienza_dati
                     , cod_combustibile  = :cod_combustibile
                     , cod_potenza       = :cod_potenza
                     , potenza           = :potenza
                     , potenza_utile     = :potenza_utile
                     , data_installaz    = :data_installaz
                     , data_attivaz      = :data_attivaz
                     , data_rottamaz     = :data_rottamaz
                     , note              = :note
                     , stato             = :stato
                     , flag_dichiarato   = :flag_dichiarato   
                     , data_prima_dich   = :data_prima_dich
                     , data_ultim_dich   = :data_ultim_dich
                     , data_scad_dich    = :data_scad_dich 
                     , cod_tpim          = :cod_tpim
                     , consumo_annuo     = :consumo_annuo
                     , n_generatori      = :n_generatori
                     , stato_conformita  = :stato_conformita
                     , cod_cted          = :cod_cted
                     , tariffa           = :tariffa
                     , data_mod          =  sysdate
                     , utente            = :id_utente  
                     , flag_dpr412       = :flag_dpr412
                     , anno_costruzione  = :anno_costruzione
                     , marc_effic_energ  = :marc_effic_energ
                     , volimetria_risc   = :volimetria_risc
		     , dati_scheda       = :dati_scheda
		     , data_scheda       = :data_scheda
                     , cod_impianto_princ  = :cod_impianto_princ --sim01
                     , pres_certificazione = :pres_certificazione
                     , certificazione      = :certificazione
                 where cod_impianto = :cod_impianto
       </querytext>
    </partialquery>

    <partialquery name="del_aimp">
       <querytext>
                delete
                  from coimaimp
                 where cod_impianto = :cod_impianto
       </querytext>
    </partialquery>

    <fullquery name="sel_aimp">
       <querytext>
          select a.cod_impianto
               , a.cod_impianto_est
               , a.cod_impianto_prov
               , a.provenienza_dati
               , a.stato
               , a.cod_potenza
               , a.cod_combustibile
               , iter_edit.num(a.potenza, 2)       as potenza
               , iter_edit.num(a.potenza_utile, 2) as potenza_utile
               , a.cod_tpim
               , a.tariffa
               , a.cod_cted  
               , a.stato_conformita
               , iter_edit.num(a.n_generatori, 0)  as n_generatori
               , iter_edit.num(a.consumo_annuo, 2) as consumo_annuo
               , iter_edit.data(a.data_installaz)  as data_installaz
               , iter_edit.data(a.data_rottamaz)   as data_rottamaz
               , iter_edit.data(a.data_attivaz)    as data_attivaz
               , a.flag_dichiarato
               , iter_edit.data(a.data_prima_dich) as data_prima_dich
               , iter_edit.data(a.data_ultim_dich) as data_ultim_dich
               , iter_edit.data(a.data_scad_dich) as data_scad_dich
               , a.data_prima_dich as dt_prima_dich
               , a.data_ultim_dich as dt_ultim_dich
               , a.note
               , b.descr_potenza                   as descr_potenza
               , a.flag_dpr412
               , iter_edit.data(a.anno_costruzione)as anno_costruzione
               , a.marc_effic_energ
               , iter_edit.num(a.volimetria_risc) as volimetria_risc
               , dati_scheda
               , iter_edit_data(a.data_scheda)      as data_scheda
               , a.flag_tipo_impianto -- dpr74
               , d.cod_impianto_est                 as cod_impianto_princ -- sim01
               , a.pres_certificazione
               , a.certificazione
               from coimaimp a
                  , coimpote b 
          left join coimaimp d on d.cod_impianto = a.cod_impianto_princ --sim01
              where a.cod_impianto    = :cod_impianto
                and b.cod_potenza (+) = a.cod_potenza
       </querytext>
    </fullquery>

    <fullquery name="check_aimp">
       <querytext>
          select '1'
            from coimaimp 
           where cod_impianto_est  =  upper(:cod_impianto_est)
             and cod_impianto     <> :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="check_fascia_pote">
       <querytext>
          select '1'
            from coimpote 
           where :potenza_tot between potenza_min and potenza_max
       </querytext>
    </fullquery>

    <fullquery name="check_fascia_pote2">
       <querytext>
          select '1'
            from coimpote 
           where :potenza_tot between potenza_min and potenza_max
             and cod_potenza = :cod_potenza
       </querytext>
    </fullquery>

    <fullquery name="assegna_fascia">
       <querytext>
          select cod_potenza
            from coimpote 
           where :potenza_tot between potenza_min and potenza_max
       </querytext>
    </fullquery>

    <fullquery name="sel_pote">
       <querytext>
          select potenza_min as potenza
            from coimpote
           where cod_potenza = :cod_potenza
       </querytext>
    </fullquery>

    <fullquery name="sel_count_dimp">
       <querytext>
          select count(*) as count_dimp
            from coimdimp 
           where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_count_cimp">
       <querytext>
          select count(*) as count_cimp
            from coimcimp 
           where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_count_gend">
       <querytext>
          select count(*) as count_gend
            from coimgend 
           where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_count_prvv">
       <querytext>
          select count(*) as count_prvv
            from coimprvv 
           where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_count_movi">
       <querytext>
          select count(*) as count_movi
            from coimmovi 
           where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_count_inco">
       <querytext>
          select count(*) as count_inco
            from coiminco 
           where cod_impianto = :cod_impianto
             and stato        = 0
       </querytext>
    </fullquery>

    <fullquery name="sel_count_todo">
       <querytext>
          select count(*) as count_todo
            from coimtodo 
           where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_count_docu">
       <querytext>
          select count(*) as count_docu
            from coimdocu
           where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_cod_aimp_est">
       <querytext>
          select ltrim(to_char(nvl(max(to_number(cod_impianto_est, '9999999990') ),0) + 1, '0000000000')) as cod_impianto_est
           from  coimaimp
          where cod_impianto_est < 'A'
       </querytext>
    </fullquery>

    <fullquery name="check_aimp_prov">
       <querytext>
       select cod_impianto as cod_impianto_prov
         from coimaimp 
        where cod_impianto_est = :cod_impianto_est_prov
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_prov">
       <querytext>
          select cod_impianto_est as cod_impianto_est_prov
            from coimaimp
           where cod_impianto = :cod_impianto_prov
       </querytext>
    </fullquery>

    <!-- sim01 Aggiunta questa query -->
    <partialquery name="sel_aimp_princ">
      <querytext>
        select cod_impianto     as cod_impianto_princ
          from coimaimp
         where cod_impianto_est = :cod_impianto_princ
      </querytext>
    </partialquery>

    <fullquery name="sel_cod_aimp">
       <querytext>
          select coimaimp_s.nextval as cod_aimp
            from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_gend">
       <querytext>
	 insert into coimgend
                ( cod_impianto
                , gen_prog
                , descrizione
                , matricola
                , modello
                , cod_cost
                , matricola_bruc
                , modello_bruc
                , cod_cost_bruc
                , tipo_foco
                , mod_funz
                , cod_utgi
                , tipo_bruciatore
                , tiraggio
                , locale
                , cod_emissione
                , cod_combustibile
                , data_installaz
                , data_rottamaz
                , pot_focolare_lib
                , pot_utile_lib
                , pot_focolare_nom
                , pot_utile_nom
                , flag_attivo
                , note
                , data_ins
                , data_mod
                , utente 
                , gen_prog_est
                , data_costruz_gen
                , data_costruz_bruc
                , data_installaz_bruc
                , data_rottamaz_bruc
                , marc_effic_energ
                , campo_funzion_min
                , campo_funzion_max
                , dpr_660_96
                , utente_ins
                , igni_progressivo
                , portata_comb
                , portata_termica
                , cod_tpco            -- dpr74
                , cod_flre            -- dpr74
                , carica_refrigerante -- dpr74
                , sigillatura_carica  -- dpr74
		, cod_mode            -- 2014-05-16
		, cod_mode_bruc       -- 2014-05-16
		, cod_grup_term
                )	
        (select :cod_aimp
              , gen_prog         
              , descrizione      
              , matricola        
              , modello          
              , cod_cost         
              , matricola_bruc   
              , modello_bruc     
              , cod_cost_bruc    
              , tipo_foco        
              , mod_funz         
              , cod_utgi         
              , tipo_bruciatore  
              , tiraggio         
              , locale           
              , cod_emissione    
              , cod_combustibile 
              , data_installaz   
              , data_rottamaz    
              , pot_focolare_lib 
              , pot_utile_lib    
              , pot_focolare_nom 
              , pot_utile_nom    
              , flag_attivo      
              , note             
              , sysdate
              , null        
              , :id_utente
              , gen_prog_est
              , data_costruz_gen
              , data_costruz_bruc
              , data_installaz_bruc
              , data_rottamaz_bruc
              , marc_effic_energ   
              , campo_funzion_min 
              , campo_funzion_max
	      , cod_grup_term
           from coimgend
          where cod_impianto = :cod_impianto)       
       </querytext>
    </partialquery>


    <partialquery name="ins_aimp">
       <querytext>
           insert into coimaimp 
	         ( cod_impianto                         
                 , cod_impianto_est                     
                 , cod_impianto_prov                    
                 , descrizione                          
                 , provenienza_dati                     
                 , cod_combustibile                     
                 , cod_potenza                          
                 , potenza                              
                 , potenza_utile                        
                 , data_installaz                       
                 , data_attivaz                         
                 , data_rottamaz                        
                 , note                                 
                 , stato                                
                 , flag_dichiarato                      
                 , data_prima_dich                      
                 , data_ultim_dich                      
                 , cod_tpim                             
                 , consumo_annuo                        
                 , n_generatori                         
                 , stato_conformita                     
                 , cod_cted                             
                 , tariffa                              
                 , cod_responsabile                     
                 , flag_resp                            
                 , cod_intestatario                     
                 , flag_intestatario                    
                 , cod_proprietario                     
                 , cod_occupante                        
                 , cod_amministratore                   
                 , cod_manutentore                      
                 , cod_installatore                     
                 , cod_distributore                     
                 , cod_progettista                      
                 , cod_ubicazione                       
                 , localita                             
                 , cod_via                              
                 , toponimo                             
                 , indirizzo                            
                 , numero                               
                 , esponente                            
                 , scala                                
                 , piano                                
                 , interno                              
                 , cod_comune                           
                 , cod_provincia                        
                 , cap                                  
                 , foglio                               
                 , cod_tpdu                             
                 , cod_qua                              
                 , cod_urb                              
                 , data_ins                             
                 , data_mod                             
                 , utente                               
                 , flag_dpr412                          
                 , cod_impianto_dest                    
                 , anno_costruzione                     
                 , marc_effic_energ                     
                 , volimetria_risc                      
                 , gb_x                                 
                 , gb_y                                 
                 , data_scad_dich                       
                 , flag_coordinate                      
                 , flag_targa_stampata                  
                 , cod_impianto_old                     
                 , portata                              
                 , palazzo                              
                 , n_unita_immob                        
                 , cod_tipo_attivita                    
                 , adibito_a                            
                 , utente_ins                           
                 , igni_progressivo                     
                 , cod_iterman                          
                 , circuito_primario                    
                 , distr_calore                         
                 , n_scambiatori                        
                 , potenza_scamb_tot                    
                 , nome_rete                            
                 , cod_alim                             
                 , cod_fdc                              
                 , note_dest                            
                 , cop                                  
                 , per                                  
                 , cod_amag                             
                 , dati_scheda                          
                 , data_scheda                          
                 , flag_tipo_impianto                   
                 , mappale                              
                 , denominatore                         
                 , subalterno                           
                 , cod_distributore_el                  
                 , pdr                                  
                 , pod                                  
                 , cod_impianto_princ                   
                 , cat_catastale                        
                 , pres_certificazione                  
                 , certificazione                       
                 , tratt_acqua_contenuto                
                 , tratt_acqua_durezza                  
                 , tratt_acqua_clima_tipo               
                 , tratt_acqua_clima_addolc             
                 , tratt_acqua_clima_prot_gelo          
                 , tratt_acqua_clima_prot_gelo_eti      
                 , tratt_acqua_clima_prot_gelo_eti_perc 
                 , tratt_acqua_clima_prot_gelo_pro      
                 , tratt_acqua_clima_prot_gelo_pro_perc 
                 , tratt_acqua_calda_sanit_tipo         
                 , tratt_acqua_calda_sanit_addolc       
                 , tratt_acqua_raff_assente             
                 , tratt_acqua_raff_tipo_circuito       
                 , tratt_acqua_raff_origine             
                 , tratt_acqua_raff_filtraz_flag        
                 , tratt_acqua_raff_filtraz_1           
                 , tratt_acqua_raff_filtraz_2           
                 , tratt_acqua_raff_filtraz_3           
                 , tratt_acqua_raff_filtraz_4           
                 , tratt_acqua_raff_tratt_flag          
                 , tratt_acqua_raff_tratt_1             
                 , tratt_acqua_raff_tratt_2             
                 , tratt_acqua_raff_tratt_3             
                 , tratt_acqua_raff_tratt_4             
                 , tratt_acqua_raff_tratt_5             
                 , tratt_acqua_raff_cond_flag           
                 , tratt_acqua_raff_cond_1              
                 , tratt_acqua_raff_cond_2              
                 , tratt_acqua_raff_cond_3              
                 , tratt_acqua_raff_cond_4              
                 , tratt_acqua_raff_cond_5              
                 , tratt_acqua_raff_cond_6              
                 , tratt_acqua_raff_spurgo_flag         
                 , tratt_acqua_raff_spurgo_cond_ing     
                 , tratt_acqua_raff_spurgo_tara_cond
		 , regol_curva_integrata            
                 , regol_curva_indipendente         
                 , regol_curva_ind_iniz_data_inst   
                 , regol_curva_ind_iniz_data_dism   
                 , regol_curva_ind_iniz_fabbricante 
                 , regol_curva_ind_iniz_modello     
                 , regol_curva_ind_iniz_n_punti_reg 
                 , regol_curva_ind_iniz_n_liv_temp  
                 , regol_valv_regolazione           
                 , regol_valv_ind_iniz_data_inst    
                 , regol_valv_ind_iniz_data_dism    
                 , regol_valv_ind_iniz_fabbricante  
                 , regol_valv_ind_iniz_modello      
                 , regol_valv_ind_iniz_n_vie        
                 , regol_valv_ind_iniz_servo_motore 
                 , regol_sist_multigradino          
                 , regol_sist_inverter              
                 , regol_altri_flag                 
                 , regol_altri_desc_sistema         
                 , regol_cod_tprg                   
                 , regol_valv_termostatiche         
                 , regol_valv_due_vie               
                 , regol_valv_tre_vie               
                 , regol_valv_note                  
                 , regol_telettura                  
                 , regol_telegestione               
                 , regol_desc_sistema_iniz          
                 , regol_data_sost_sistema          
                 , regol_desc_sistema_sost          
                 , contab_si_no                     
                 , contab_tipo_contabiliz           
                 , contab_tipo_sistema              
                 , contab_desc_sistema_iniz         
                 , contab_data_sost_sistema         
                 , contab_desc_sistema_sost
		 )
           (select :cod_aimp
                 , :cod_impianto_est
                 , :cod_impianto_prov
                 , descrizione       
                 , :provenienza_dati  
                 , :cod_combustibile  
                 , :cod_potenza       
                 , :potenza           
                 , :potenza_utile     
                 , :data_installaz    
                 , :data_attivaz      
                 , :data_rottamaz     
                 , :note              
                 , :stato             
                 , :flag_dichiarato   
                 , :data_prima_dich   
                 , :data_ultim_dich   
                 , :cod_tpim          
                 , :consumo_annuo     
                 , :n_generatori      
                 , :stato_conformita  
                 , :cod_cted          
                 , :tariffa           
                 , cod_responsabile  
                 , flag_resp         
                 , cod_intestatario  
                 , flag_intestatario  
                 , cod_proprietario   
                 , cod_occupante      
                 , cod_amministratore 
                 , cod_manutentore    
                 , cod_installatore   
                 , cod_distributore   
                 , cod_progettista
		 , null
                 , cod_ubicazione     
                 , localita           
                 , cod_via            
                 , toponimo           
                 , indirizzo          
                 , numero             
                 , esponente          
                 , scala              
                 , piano              
                 , interno            
                 , cod_comune         
                 , cod_provincia      
                 , cap                
      -- dpr74   , cod_catasto
                 , foglio        -- dpr74        
                 , cod_tpdu           
                 , cod_qua            
                 , cod_urb            
                 , sysdate       
                 , null           
                 , :id_utente
                 , :flag_dpr412
                 , null
                 , :anno_costruzione
                 , :marc_effic_energ
                 , :volimetria_risc
                 , null
                 , null
                 , :data_scad_dich
                 , flag_coordinate                      
                 , flag_targa_stampata                  
                 , cod_impianto_old                     
                 , portata                              
                 , palazzo                              
                 , n_unita_immob                        
                 , cod_tipo_attivita                    
                 , adibito_a                            
                 , :id_utente                           
                 , igni_progressivo                     
                 , cod_iterman                          
                 , circuito_primario                    
                 , distr_calore                         
                 , n_scambiatori                        
                 , potenza_scamb_tot                    
                 , nome_rete                            
                 , cod_alim                             
                 , cod_fdc                              
                 , note_dest                            
                 , cop                                  
                 , per                                  
                 , cod_amag                             
                 , dati_scheda                          
                 , data_scheda                          
                 , flag_tipo_impianto                   
                 , mappale                              
                 , denominatore                         
                 , subalterno                           
                 , cod_distributore_el                  
                 , pdr                                  
                 , pod                                  
                 , cod_impianto_princ                   
                 , cat_catastale                        
                 , :pres_certificazione                  
                 , :certificazione                       
                 , tratt_acqua_contenuto                
                 , tratt_acqua_durezza                  
                 , tratt_acqua_clima_tipo               
                 , tratt_acqua_clima_addolc             
                 , tratt_acqua_clima_prot_gelo          
                 , tratt_acqua_clima_prot_gelo_eti      
                 , tratt_acqua_clima_prot_gelo_eti_perc 
                 , tratt_acqua_clima_prot_gelo_pro      
                 , tratt_acqua_clima_prot_gelo_pro_perc 
                 , tratt_acqua_calda_sanit_tipo         
                 , tratt_acqua_calda_sanit_addolc       
                 , tratt_acqua_raff_assente             
                 , tratt_acqua_raff_tipo_circuito       
                 , tratt_acqua_raff_origine             
                 , tratt_acqua_raff_filtraz_flag        
                 , tratt_acqua_raff_filtraz_1           
                 , tratt_acqua_raff_filtraz_2           
                 , tratt_acqua_raff_filtraz_3           
                 , tratt_acqua_raff_filtraz_4           
                 , tratt_acqua_raff_tratt_flag          
                 , tratt_acqua_raff_tratt_1             
                 , tratt_acqua_raff_tratt_2             
                 , tratt_acqua_raff_tratt_3             
                 , tratt_acqua_raff_tratt_4             
                 , tratt_acqua_raff_tratt_5             
                 , tratt_acqua_raff_cond_flag           
                 , tratt_acqua_raff_cond_1              
                 , tratt_acqua_raff_cond_2              
                 , tratt_acqua_raff_cond_3              
                 , tratt_acqua_raff_cond_4              
                 , tratt_acqua_raff_cond_5              
                 , tratt_acqua_raff_cond_6              
                 , tratt_acqua_raff_spurgo_flag         
                 , tratt_acqua_raff_spurgo_cond_ing     
                 , tratt_acqua_raff_spurgo_tara_cond
		 , regol_curva_integrata            
                 , regol_curva_indipendente         
                 , regol_curva_ind_iniz_data_inst   
                 , regol_curva_ind_iniz_data_dism   
                 , regol_curva_ind_iniz_fabbricante 
                 , regol_curva_ind_iniz_modello     
                 , regol_curva_ind_iniz_n_punti_reg 
                 , regol_curva_ind_iniz_n_liv_temp  
                 , regol_valv_regolazione           
                 , regol_valv_ind_iniz_data_inst    
                 , regol_valv_ind_iniz_data_dism    
                 , regol_valv_ind_iniz_fabbricante  
                 , regol_valv_ind_iniz_modello      
                 , regol_valv_ind_iniz_n_vie        
                 , regol_valv_ind_iniz_servo_motore 
                 , regol_sist_multigradino          
                 , regol_sist_inverter              
                 , regol_altri_flag                 
                 , regol_altri_desc_sistema         
                 , regol_cod_tprg                   
                 , regol_valv_termostatiche         
                 , regol_valv_due_vie               
                 , regol_valv_tre_vie               
                 , regol_valv_note                  
                 , regol_telettura                  
                 , regol_telegestione               
                 , regol_desc_sistema_iniz          
                 , regol_data_sost_sistema          
                 , regol_desc_sistema_sost          
                 , contab_si_no                     
                 , contab_tipo_contabiliz           
                 , contab_tipo_sistema              
                 , contab_desc_sistema_iniz         
                 , contab_data_sost_sistema         
                 , contab_desc_sistema_sost
              from coimaimp
             where cod_impianto = :cod_impianto)             
       </querytext>
    </partialquery>

    <fullquery name="sel_count_generatori">
       <querytext>
           select count(*) as count_generatori
	        , sum(pot_focolare_nom) as tot_pot_focolare_nom
                , sum(pot_utile_nom) as tot_pot_utile_nom
             from coimgend
            where cod_impianto = :cod_impianto
              and flag_attivo  = 'S'
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_stato">
       <querytext>
           select stato
             from coimaimp
            where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

</queryset>
