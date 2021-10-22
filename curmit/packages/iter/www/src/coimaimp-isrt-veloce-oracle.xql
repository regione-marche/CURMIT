<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>


    <partialquery name="ins_aimp">
       <querytext>
                insert
                  into coimaimp 
                     ( cod_impianto
                     , cod_impianto_est
                     , cod_potenza
                     , potenza
                     , potenza_utile
                     , note
                     , stato
                     , flag_dichiarato
                     , n_generatori
                     , cod_responsabile
                     , flag_resp
                     , cod_intestatario
                     , cod_proprietario   
                     , cod_occupante      
                     , cod_amministratore 
                     , cod_manutentore    
                     , cod_installatore   
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
                     , data_ins           
                     , utente
                     , flag_dpr412
                     , cod_cted
                     , provenienza_dati
                     , cod_combustibile
                     , cod_tpim
		     , data_installaz
		     , anno_costruzione
                     , cod_tpdu
                     , volimetria_risc
                     , cod_progettista
                     )             
                values
                     (:cod_impianto
                     ,:cod_impianto_est
                     ,:cod_potenza
                     ,:potenza
                     ,:potenza_utile
                     ,:note
                     ,:stato
                     ,'S'
                     ,:n_generatori
                     ,:cod_citt_resp
                     ,:flag_responsabile
                     ,:cod_citt_inte
                     ,:cod_citt_prop   
                     ,:cod_citt_occ      
                     ,:cod_citt_amm 
                     ,:cod_manu_manu    
                     ,:cod_manu_inst   
                     ,:localita
                     ,:cod_via
                     ,:descr_topo
                     ,:descr_via
                     ,:numero
                     ,:esponente
                     ,:scala
                     ,:piano 
                     ,:interno
                     ,:cod_comune
                     ,:cod_provincia
                     ,:cap
                     ,sysdate
                     ,:id_utente
                     ,:flag_dpr412
                     ,:cod_cted
                     ,:provenienza_dati
                     ,:cod_combustibile
                     ,:cod_tpim
		     ,:data_installaz
		     ,:anno_costruzione
                     ,:cod_tpdu
                     ,:volimetria_risc
                     ,:cod_progettista
		     )   
       </querytext>
    </partialquery>

    <fullquery name="sel_dual_aimp">
       <querytext>
        select coimaimp_s.nextval as cod_impianto
          from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_gend">
       <querytext>
                insert
                  into coimgend 
                     ( cod_impianto
                     , gen_prog
		     , data_installaz
		     , data_costruz_gen
                     , pot_focolare_nom
                     , pot_utile_nom
                     , flag_attivo
                     , data_ins
                     , utente
		     , gen_prog_est
                     , matricola
                     , modello
                     , cod_cost
                     , cod_combustibile
                     , tipo_foco
                     , tiraggio
                     , cod_emissione
                     , cod_mode -- 2014-05-16
		     )
                values
                     (:cod_impianto
                     ,:gen_prog
		     ,:data_installaz
		     ,:anno_costruzione
                     ,:potenza
                     ,:potenza_utile
                     ,'S'
                     ,sysdate        
                     ,:id_utente
		     ,'1'
                     ,:matricola
                     ,:modello
                     ,:cod_cost
                     ,:cod_combustibile
                     ,:tipo_foco
                     ,:tiraggio
                     ,:cod_emissione
                     ,:cod_mode -- 2014-05-16
		     )
       </querytext>
    </partialquery>


    <fullquery name="sel_viae">
       <querytext>
             select cod_via 
               from coimviae
              where cod_comune  = :cod_comune
                and descrizione = upper(:descr_via)
                and descr_topo  = upper(:descr_topo)
       </querytext>
    </fullquery>

    <fullquery name="sel_citt">
       <querytext>
             select cod_cittadino
               from coimcitt
              where cognome   $eq_cognome
                and nome      $eq_nome
       </querytext>
    </fullquery>

    <fullquery name="sel_manu_nome">
       <querytext>
             select cognome  as cognome_manu
                  , nome     as nome_manu
               from coimmanu
              where cod_manutentore = :cod_manu_manu
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
             select cod_manutentore
               from coimmanu
              where cognome   $eq_cognome
                and nome      $eq_nome
       </querytext>
    </fullquery>

    <fullquery name="sel_prog">
       <querytext>
             select cod_progettista
               from coimprog
              where cognome   $eq_cognome
                and nome      $eq_nome
       </querytext>
    </fullquery>

    <fullquery name="check_aimp">
       <querytext>
          select '1'
            from coimaimp 
           where cod_impianto_est = upper(:cod_impianto_est)
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

    <fullquery name="check_aimp_prov">
       <querytext>
       select cod_impianto as cod_aimp_proven
         from coimaimp 
        where cod_impianto_est = :cod_aimp_prov
       </querytext>
    </fullquery>

    <fullquery name="get_cod_imipanto_est">
       <querytext>
        select coimaimp_est_s.nextval as cod_impianto_est
          from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_citt">
       <querytext>
              insert
                into coimcitt 
                   ( cod_cittadino
                   , natura_giuridica
                   , cognome
                   , nome
                   , indirizzo
                   , numero
                   , cap
                   , localita
                   , comune
                   , provincia
                   , data_ins
                   , utente)
                values 
                   (:cod_cittadino
                   ,null
                   ,upper(:cognome_occ)
                   ,upper(:nome_occ)
                   ,upper(:descr_via)
                   ,:numero
                   ,:cap
                   ,upper(:localita)
                   ,upper(:desc_comune)
                   ,upper(:provincia)
                   ,sysdate
                   ,:id_utente)
       </querytext>
    </partialquery>

    <fullquery name="sel_cod_citt">
        <querytext>
           select coimcitt_s.nextval as cod_cittadino
             from dual
       </querytext>
    </fullquery>

    <fullquery name="sel_comu_desc">
        <querytext>
           select denominazione as desc_comune
             from coimcomu
            where cod_comune = :cod_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_comu_cap">
        <querytext>
           select cap
             from coimcomu
            where cod_comune = :cod_comune
       </querytext>
    </fullquery>

</queryset>
