begin;

drop trigger trig_coimaimp_st on coimaimp;
create or replace function coimaimp_st_tr() returns trigger
as '
declare
st_ope coimaimp_st.st_operazione%TYPE;
prog   coimaimp_st.st_progressivo%TYPE;
begin
IF (TG_OP = ''DELETE'') THEN
	 st_ope := ''C'';
 END IF;
IF (TG_OP = ''UPDATE'') THEN
	 st_ope := ''M'';
 END IF;
IF (TG_OP = ''INSERT'') THEN
	 st_ope = ''I'';
 END IF;
--
IF (TG_OP = ''UPDATE'') or  (TG_OP = ''DELETE'') THEN 
insert into coimaimp_st (
 cod_impianto,        
 cod_impianto_est,   
 cod_impianto_prov,   
 descrizione,         
 provenienza_dati,   
 cod_combustibile,    
 cod_potenza,        
 potenza,           
 potenza_utile,      
 data_installaz,      
 data_attivaz,        
 data_rottamaz,       
 note,                
 stato,               
 flag_dichiarato,     
 data_prima_dich,     
 data_ultim_dich,     
 cod_tpim,            
 consumo_annuo,       
 n_generatori,        
 stato_conformita,    
 cod_cted,           
 tariffa,             
 cod_responsabile,    
 flag_resp,           
 cod_intestatario,    
 flag_intestatario,   
 cod_proprietario,    
 cod_occupante,       
 cod_amministratore,  
 cod_manutentore,     
 cod_installatore,    
 cod_distributore,    
 cod_progettista,     
 cod_amag,            
 cod_ubicazione,      
 localita,            
 cod_via,             
 toponimo,            
 indirizzo,          
 numero,              
 esponente,           
 scala,               
 piano,               
 interno,             
 cod_comune,          
 cod_provincia,       
 cap,                 
-- cod_catasto,         
 cod_tpdu,            
 cod_qua,             
 cod_urb,             
 data_ins,            
 data_mod,            
 utente,              
 flag_dpr412,         
 cod_impianto_dest,   
 anno_costruzione,   
 marc_effic_energ,    
 volimetria_risc,     
 gb_x,                
 gb_y,                
 data_scad_dich,      
 flag_coordinate,     
 flag_targa_stampata, 
 cod_impianto_old,    
 portata,             
 --st_progressivo,
 st_utente,
 st_operazione,
 st_data_validita          
        )  values (
 OLD.cod_impianto,   
 OLD.cod_impianto_est,   
 OLD.cod_impianto_prov,   
 OLD.descrizione,         
 OLD.provenienza_dati,   
 OLD.cod_combustibile,    
 OLD.cod_potenza,        
 OLD.potenza,           
 OLD.potenza_utile,      
 OLD.data_installaz,      
 OLD.data_attivaz,        
 OLD.data_rottamaz,       
 OLD.note,                
 OLD.stato,               
 OLD.flag_dichiarato,     
 OLD.data_prima_dich,     
 OLD.data_ultim_dich,     
 OLD.cod_tpim,            
 OLD.consumo_annuo,       
 OLD.n_generatori,        
 OLD.stato_conformita,    
 OLD.cod_cted,           
 OLD.tariffa,             
 OLD.cod_responsabile,    
 OLD.flag_resp,           
 OLD.cod_intestatario,    
 OLD.flag_intestatario,   
 OLD.cod_proprietario,    
 OLD.cod_occupante,       
 OLD.cod_amministratore,  
 OLD.cod_manutentore,     
 OLD.cod_installatore,    
 OLD.cod_distributore,    
 OLD.cod_progettista,     
 OLD.cod_amag,            
 OLD.cod_ubicazione,      
 OLD.localita,            
 OLD.cod_via,             
 OLD.toponimo,            
 OLD.indirizzo,          
 OLD.numero,              
 OLD.esponente,           
 OLD.scala,               
 OLD.piano,               
 OLD.interno,             
 OLD.cod_comune,          
 OLD.cod_provincia,       
 OLD.cap,                 
-- OLD.cod_catasto,         
 OLD.cod_tpdu,            
 OLD.cod_qua,             
 OLD.cod_urb,             
 OLD.data_ins,            
 OLD.data_mod,            
 OLD.utente,              
 OLD.flag_dpr412,         
 OLD.cod_impianto_dest,   
 OLD.anno_costruzione,   
 OLD.marc_effic_energ,    
 OLD.volimetria_risc,     
 OLD.gb_x,                
 OLD.gb_y,                
 OLD.data_scad_dich,      
 OLD.flag_coordinate,     
 OLD.flag_targa_stampata, 
 OLD.cod_impianto_old,    
 OLD.portata,             
 --null,
 NEW.utente,
 st_ope, 
 current_timestamp
 );

insert into coimgend_st(
cod_impianto        
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
 , cod_tpco            
 , cod_flre            
 , carica_refrigerante 
 , sigillatura_carica  
 , cod_mode            
 , cod_mode_bruc       
 , cod_grup_term       
-- , st_progressivo      
 , st_utente           
 , st_operazione       
 , st_data_validita    
) select 
   cod_impianto        
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
 , cod_tpco            
 , cod_flre            
 , carica_refrigerante 
 , sigillatura_carica  
 , cod_mode            
 , cod_mode_bruc       
 , cod_grup_term       
 ,
	NEW.utente, 
	st_ope, 
	current_timestamp from coimgend 
where cod_impianto = OLD.cod_impianto;


update coimcimp set igni_progressivo = coalesce((select max(st_progressivo) from coimaimp_st where cod_impianto = OLD.cod_impianto),0) where igni_progressivo is null and cod_impianto = OLD.cod_impianto;
update coimdimp set igni_progressivo = coalesce((select max(st_progressivo) from coimaimp_st where cod_impianto = OLD.cod_impianto),0) where igni_progressivo is null and cod_impianto = OLD.cod_impianto;

END IF;
  return new;
end;
' language 'plpgsql';

create trigger trig_coimaimp_st after update  on coimaimp
for each row
execute procedure coimaimp_st_tr ();

end;
