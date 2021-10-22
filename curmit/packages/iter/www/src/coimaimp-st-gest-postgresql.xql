<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="get_cod_impianto_est_old">
       <querytext>
           select coalesce('ITER25'||lpad((max(to_number(substr(cod_impianto_est, 7, 14), '99999999999999999990') ) + 1), 14, '0'), 'ITER2500000000000001') as cod_impianto_est from coimaimp
       </querytext>
    </fullquery>

    <fullquery name="sel_dati_codifica">
       <querytext>
           select coalesce(lpad((a.progressivo + 1), 7, '0'), '0000001') as progressivo
                , a.cod_istat
                , b.potenza
                , b.cod_potenza
                , a.cod_comune
             from coimcomu a
                , coimaimp b
            where a.cod_comune = b.cod_comune
              and b.cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

   <partialquery name="upd_prog_comu">
       <querytext>
                update coimcomu
                   set progressivo = :progressivo
                 where cod_comune  = :cod_comune
       </querytext>
    </partialquery>

    <fullquery name="get_cod_impianto_est">
       <querytext>
          select nextval('coimaimp_est_s') as cod_impianto_est
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
                     , portata           = :portata
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
                     , data_mod          = current_date
                     , utente            = :id_utente  
		     , flag_dpr412       = :flag_dpr412
                     , anno_costruzione  = :anno_costruzione
                     , marc_effic_energ  = :marc_effic_energ
                     , volimetria_risc   = :volimetria_risc
		     , flag_targa_stampata = :flag_targa_stampata
		     , adibito_a         = :adibito_a
		     , cod_tipo_attivita = :cod_tipo_attivita
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

    <fullquery name="sel_aimp_st">
       <querytext>
          select a.cod_impianto
               , a.cod_impianto_est
               , a.cod_impianto_prov
               , a.provenienza_dati
               , a.stato
               , a.cod_potenza
               , a.cod_combustibile
               , iter_edit_num(a.potenza, 2)       as potenza
               , iter_edit_num(a.potenza_utile, 2) as potenza_utile
               , iter_edit_num(a.portata, 2) as portata
               , a.cod_tpim
               , a.tariffa
               , a.cod_cted  
               , a.stato_conformita
               , iter_edit_num(a.n_generatori, 0)  as n_generatori
               , iter_edit_num(a.consumo_annuo, 2) as consumo_annuo
               , iter_edit_data(a.data_installaz)  as data_installaz
               , iter_edit_data(a.data_rottamaz)   as data_rottamaz
               , iter_edit_data(a.data_attivaz)    as data_attivaz
               , a.flag_dichiarato
               , iter_edit_data(a.data_prima_dich) as data_prima_dich
               , iter_edit_data(a.data_ultim_dich) as data_ultim_dich
               , iter_edit_data(a.data_scad_dich) as data_scad_dich
               , a.data_prima_dich as dt_prima_dich
               , a.data_ultim_dich as dt_ultim_dich
               , a.note
               , b.descr_potenza                   as descr_potenza
	       , a.flag_dpr412
               , iter_edit_data(a.anno_costruzione) as anno_costruzione
               , a.marc_effic_energ
               , iter_edit_num(a.volimetria_risc,2) as volimetria_risc
	       , a.flag_targa_stampata as flag_targa_stampata
	       , a.adibito_a as adibito_a
	       , a.cod_tipo_attivita as cod_tipo_attivita
               , a.st_data_validita
               from coimaimp_st a
               left outer join coimpote b on  b.cod_potenza = a.cod_potenza
              where a.cod_impianto = :cod_impianto
                and a.st_progressivo = :st_progressivo
                
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
          select ltrim(to_char(coalesce(max(to_number(cod_impianto_est, '9999999990') ),0) + 1, '0000000000')) as cod_impianto_est
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

    <fullquery name="sel_cod_aimp">
       <querytext>
          select nextval('coimaimp_s') as cod_aimp
       </querytext>
    </fullquery>

    <partialquery name="ins_gend">
       <querytext>
        insert into coimgend
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
              , current_date        
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
           from coimgend
          where cod_impianto = :cod_impianto)       
       </querytext>
    </partialquery>


    <partialquery name="ins_aimp">
       <querytext>
           insert into coimaimp 
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
                 , cod_catasto        
                 , cod_tpdu           
                 , cod_qua            
                 , cod_urb            
                 , null      
                 , null           
                 , :id_utente
                 , :flag_dpr412
                 , null
                 ,:anno_costruzione
                 ,:marc_effic_energ
                 ,:volimetria_risc
                 , null
                 , null
                 ,:data_scad_dich
		 ,'F'
                 , null
                 , null
                 , :portata
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
             from coimaimp_st
            where cod_impianto = :cod_impianto
              and st_progressivo = :st_progressivo
       </querytext>
    </fullquery>

</queryset>
