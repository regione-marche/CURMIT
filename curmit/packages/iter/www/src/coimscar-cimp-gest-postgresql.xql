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

    <fullquery name="sel_cimp">
       <querytext>
select
  e.cod_impianto_est
, a.gen_prog              
, a.data_controllo        
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
, a.cod_combustibile      
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
from 
  coimcimp a
  left outer join coimcitt b on  b.cod_cittadino = a.cod_responsabile,
  coimopve c,
  coimaimp e
 where 1=1
   and c.cod_opve = :f_cod_tecn
   and a.cod_opve = c.cod_opve
   and a.cod_impianto = e.cod_impianto
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
	    , coimcimp b
	    , coimaimp c
        where c.cod_impianto_est = :cod_impianto_est
          and c.cod_impianto = b.cod_impianto
          and b.cod_cimp = a.cod_cimp_dimp
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

