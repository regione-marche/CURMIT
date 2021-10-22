<?xml version="1.0"?>
<!--
USER  DATA       MODIFICHE
===== ========== ==================================================================================
rom01 03/12/2020 Corretto errore sulla modifica: Le Marche possono avere piu' sistemi di regolazione
rom01            e valvole di regolazione e gestiscono il tutto con delle liste apposite.
rom01            Guardare programma .tcl
-->
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_rego">
       <querytext>
	      select regol_on_off                                           
	           , regol_curva_integrata                         
	           , regol_curva_indipendente                   
	           , iter_edit_data(regol_curva_ind_iniz_data_inst)    as regol_curva_ind_iniz_data_inst   
	           , iter_edit_data(regol_curva_ind_iniz_data_dism)    as regol_curva_ind_iniz_data_dism   
	           , regol_curva_ind_iniz_fabbricante   
	           , regol_curva_ind_iniz_modello           
	           , regol_curva_ind_iniz_n_punti_reg   
	           , regol_curva_ind_iniz_n_liv_temp     
	           , regol_valv_regolazione                       
	           , iter_edit_data(regol_valv_ind_iniz_data_inst)     as regol_valv_ind_iniz_data_inst    
	           , iter_edit_data(regol_valv_ind_iniz_data_dism)     as regol_valv_ind_iniz_data_dism    
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
	           , iter_edit_data(regol_data_sost_sistema)           as regol_data_sost_sistema          
	           , regol_desc_sistema_sost                     
	           , contab_si_no                                           
	           , contab_tipo_contabiliz                       
	           , contab_tipo_sistema                             
	           , contab_desc_sistema_iniz                   
	           , iter_edit_data(contab_data_sost_sistema)          as contab_data_sost_sistema         
	           , contab_desc_sistema_sost           
              from coimaimp
              where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <partialquery name="upd_rego">
       <querytext>
                update coimaimp
		set regol_on_off                         = :regol_on_off                     
		     , regol_curva_integrata             = :regol_curva_integrata            
		     , regol_curva_indipendente          = :regol_curva_indipendente
		     , regol_valv_regolazione            = :regol_valv_regolazione
 		       $upd_sis_e_val_reg	--rom01	   
		     , regol_sist_multigradino           = :regol_sist_multigradino          
		     , regol_sist_inverter               = :regol_sist_inverter              
		     , regol_altri_flag                  = :regol_altri_flag                 
		     , regol_altri_desc_sistema          = :regol_altri_desc_sistema         
		     , regol_cod_tprg                    = :regol_cod_tprg                   
		     , regol_valv_termostatiche          = :regol_valv_termostatiche         
		     , regol_valv_due_vie                = :regol_valv_due_vie               
		     , regol_valv_tre_vie                = :regol_valv_tre_vie               
		     , regol_valv_note                   = :regol_valv_note                  
		     , regol_telettura                   = :regol_telettura                  
		     , regol_telegestione                = :regol_telegestione               
		     , regol_desc_sistema_iniz           = :regol_desc_sistema_iniz          
		     , regol_data_sost_sistema           = :regol_data_sost_sistema          
		     , regol_desc_sistema_sost           = :regol_desc_sistema_sost          
		     , contab_si_no                      = :contab_si_no                     
		     , contab_tipo_contabiliz            = :contab_tipo_contabiliz           
		     , contab_tipo_sistema               = :contab_tipo_sistema              
		     , contab_desc_sistema_iniz          = :contab_desc_sistema_iniz         
	      	     , contab_data_sost_sistema          = :contab_data_sost_sistema         
                     , contab_desc_sistema_sost          = :contab_desc_sistema_sost
                 where cod_impianto = :cod_impianto
       </querytext>
    </partialquery>

    <fullquery name="sel_sist_circ_aimp">--rom01 aggiunta query	"sel_sist_circ_aimp"
           <querytext>
		select a.regol_curva_ind_iniz_num_sr                    as num_sr
                     , case a.regol_curva_ind_iniz_flag_sostituito
                       when 't' then 'S&igrave;'
		       when 'f' then 'No'
		       else ''
		       end                                              as flag_sostituito_sr_edit
		     , a.regol_curva_ind_iniz_flag_sostituito           as flag_sostituito_sr
                     , iter_edit_data(a.regol_curva_ind_iniz_data_inst) as data_installazione_sr_edit
                     , iter_edit_data(a.regol_curva_ind_iniz_data_dism) as data_dismissione_sr_edit
		     , a.regol_curva_ind_iniz_data_inst                 as data_installazione_sr
                     , a.regol_curva_ind_iniz_data_dism                 as data_dismissione_sr
	             , a.regol_curva_ind_iniz_n_punti_reg               as num_punti_regolaz_sr
	             , a.regol_curva_ind_iniz_n_liv_temp                as num_lvl_temp_sr
	             , a.regol_curva_ind_iniz_fabbricante               as fabbricante_sr
	             , a.regol_curva_ind_iniz_modello                   as modello_sr
	          from coimaimp a
	         where a.cod_impianto = :cod_impianto
		   and a.regol_curva_ind_iniz_num_sr is not null
	         union all
	        select a.numero_sistema_regolazione           as num_sr
	             , case a.flag_sostituito
		       when  't' then 'S&igrave;'
                       when 'f' then 'No'
                       else ''
		        end                                  as flag_sostituito_sr_edit
	             , a.flag_sostituito                     as flag_sostituito_sr
	             , iter_edit_data(a.data_installazione)  as data_installazione_sr_edit
	             , iter_edit_data(a.data_dismissione)    as data_dismissione_sr_edit
	             , a.data_installazione                  as data_installazione_sr
	             , a.data_dismissione                    as data_dismissione_sr
	             , a.numero_punti_regolazione            as num_punti_regolaz_sr
	             , a.numero_lvl_temperatura              as num_lvl_temp_sr
	             , a.fabbricante                         as fabbricante_sr
	             , a.modello                             as modello_sr
	          from coimaimp_sistemi_regolazione a
	         where a.cod_impianto = :cod_impianto
	         order by num_sr
       </querytext>
           </fullquery>

    <fullquery name="sel_valv_rego_aimp">--rom01 aggiunta query "sel_valv_rego_aimp"
               <querytext>
       	       select a.regol_valv_ind_num_vr                         as num_vr
                    , iter_edit_data(a.regol_valv_ind_iniz_data_inst) as data_installazione_vr_edit
		    , iter_edit_data(a.regol_valv_ind_iniz_data_dism) as data_dismissione_vr_edit
		    , case a.regol_valv_ind_flag_sostituito
		      when 't' then 'S&igrave;'
		      when 'f' then 'No'
		      else ''
		       end                                            as flag_sostituito_vr_edit
                    , a.regol_valv_ind_iniz_data_inst                 as data_installazione_vr
		    , a.regol_valv_ind_iniz_data_dism                 as data_dismissione_vr
		    , a.regol_valv_ind_flag_sostituito                as flag_sostituito_vr
                    , a.regol_valv_ind_iniz_fabbricante               as fabbricante_vr
	            , a.regol_valv_ind_iniz_modello                   as modello_vr
     		    , a.regol_valv_ind_iniz_n_vie                     as num_vie_vr
     		    , a.regol_valv_ind_iniz_servo_motore              as servomotore_vr
  		 from coimaimp a
 		where a.cod_impianto = :cod_impianto
                  and a.regol_valv_ind_num_vr is not null
                union all
	       select a.numero_valvola_regolazione         as num_vr
     		    , iter_edit_data(a.data_installazione) as data_dismissione_vr_edit
     		    , iter_edit_data(a.data_dismissione)   as flag_sostituito_vr_edit
                    , case a.flag_sostituito
                      when 't' then 'S&igrave;'
		      when 'f' then 'No'
		      else ''
		       end                                 as data_installazione_vr_edit
     		    , a.data_installazione                 as data_dismissione_vr
     		    , a.data_dismissione                   as flag_sostituito_vr
                    , a.flag_sostituito                    as data_installazione_vr
      		    , a.fabbricante                        as fabbricante_vr
     		    , a.modello                            as modello_vr
     		    , a.numero_vie                         as num_vie_vr
     		    , a.servomotore                        as servomotore_vr
        	 from coimaimp_valvole_regolazione a
 	        where a.cod_impianto = :cod_impianto
 		order by num_vr
               </querytext>
    </fullquery>

</queryset>
