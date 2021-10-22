<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_aimp">
       <querytext>
                insert
                  into coimaimp 
                     ( cod_impianto
                     , cod_impianto_est
                     , cod_potenza
                     , potenza
                     , potenza_utile
                     , stato
                     , n_generatori
                     , flag_dichiarato
                     , cod_responsabile
                     , flag_resp
                     , cod_intestatario
                     , cod_proprietario   
                     , cod_occupante      
                     , cod_amministratore 
                     , cod_manutentore    
                     , cod_installatore
                     , cod_progettista   
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
                     , cod_alim
                     , cod_fdc
                     , cop
                     , per 
                     , note_dest
			         , data_installaz
		      		, volimetria_risc
		             , utente_ins
                 )             
                values
                     (:cod_impianto
                     ,:cod_impianto_est
                     ,'0'
                     ,0.00
                     ,0.00
                 	 ,'A'
                 	 ,'1'
                     ,'S'
                     ,:cod_citt_resp
                     ,:flag_responsabile
                     ,:cod_citt_inte
                     ,:cod_citt_prop   
                     ,:cod_citt_occ      
                     ,:cod_citt_amm 
                     ,:cod_manu_manu    
                     ,:cod_manu_inst   
                     ,:cod_prog
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
                     , current_date        
                     ,:id_utente
                     ,'N'
                     ,:cod_cted
                     ,:provenienza_dati
                     ,:cod_combustibile
                     ,'0'
                     ,:cod_alim
                     ,:cod_fdc
                     ,:cop
                     ,:per
                     ,:note_dest
				     ,:data_installaz
				
                     ,:volimetria_risc
	                 ,:id_utente
                   )   
       </querytext>
    </partialquery>

    <fullquery name="sel_dual_aimp">
       <querytext>
        select nextval('coimaimp_s') as cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_dual_aimp_est">
       <querytext>
        select nextval('coimaimp_est_s') as cod_impianto_est
       </querytext>
    </fullquery>

    <partialquery name="ins_gend">
       <querytext>
                insert
                  into coimgend 
                     ( cod_impianto
                     , gen_prog
		     , data_installaz
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
		     , cod_utgi
		     )
                values
                     (:cod_impianto
                     ,:gen_prog
		     ,:data_installaz
	                 ,0.00
                     ,0.00
                     ,'S'
                     , current_date        
                     ,:id_utente
		     ,'1'
                     ,'0'
                     ,'0'
                     ,'0'
                     ,:cod_combustibile
                     ,'0'
                     ,'0'
                     ,'0'
		     ,:cod_utgi
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

    <fullquery name="get_cod_imipanto_est_old">
       <querytext>
           select coalesce('ITER25'||lpad((max(to_number(substr(cod_impianto_est, 7, 14), '99999999999999999990') ) + 1), 14, '0'), 'ITER2500000000000001') as cod_impianto_est from coimaimp
       </querytext>
    </fullquery>

    <fullquery name="get_cod_impianto_est">
       <querytext>
          select nextval('coimaimp_est_s') as cod_impianto_est
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
                   ,current_date
                   ,:id_utente)
       </querytext>
    </partialquery>


    <fullquery name="sel_cod_citt">
        <querytext>
           select nextval('coimcitt_s') as cod_cittadino
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

    <fullquery name="sel_cod_legale">
       <querytext>
             select a.cod_legale_rapp as cod_citt_terzi
                  , b.cognome as cognome_terzi
                  , b.nome as nome_terzi
               from coimmanu a
                  , coimcitt b
              where a.cod_manutentore = :cod_manut
                and a.cod_legale_rapp = b.cod_cittadino
       </querytext>
    </fullquery>

    <fullquery name="sel_dati_comu">
       <querytext>
           select coalesce(progressivo + 1) as progressivo
                 --sim01 coalesce(lpad((progressivo + 1), 7, '0'), '0000001') as progressivo
                , cod_istat
             from coimcomu
            where cod_comune = :cod_comune
       </querytext>
    </fullquery>


   <partialquery name="upd_prog_comu">
       <querytext>
                update coimcomu
                   set progressivo = :progressivo
                 where cod_comune  = :cod_comune
       </querytext>
    </partialquery>

   <partialquery name="upd_as_resp">
       <querytext>
                update coim_as_resp
                   set cod_impianto = :cod_impianto
                 where cod_as_resp  = :cod_as_resp
       </querytext>
    </partialquery>
    
     <partialquery name="upd_aimp">
       <querytext>
                update coimaimp
                set cod_alim=:cod_alim
                     , cod_fdc=:cod_fdc
                     , cop=:cop
                     , per=:per
                where cod_impianto=:cod_impianto 
       </querytext>
    </partialquery>
    
     <fullquery name="sel_aimp_vie">
       <querytext>
 select a.cod_impianto_est
         , case a.flag_dichiarato
           when 'S' then 'SI'
           when 'N' then 'NO'
           when 'C' then 'N.C.'
           else '&nbsp;'
           end as desc_dich
         , coalesce(iter_edit_data(a.data_installaz),'&nbsp;') as data_installaz
         , coalesce(iter_edit_num(a.volimetria_risc, 2),'&nbsp;') as volimetria_risc
         , coalesce(b.descr_cted,'&nbsp;') as descr_cted
         , b.cod_cted
         , coalesce(c.descr_comb,'&nbsp;') as comb
	 
	 , coalesce(e.descr_tppr,'&nbsp;') as descr_prov
         , f.descr_imst as desc_stato
       	 , a.cod_combustibile
      
        , a.cod_cted
        , u.cod_utgi
        , a.note_dest
        , a.cod_alim
        , coalesce(iter_edit_num(a.cop, 2),'&nbsp;') as cop
        , coalesce(iter_edit_num(a.per, 2),'&nbsp;') as per
        , a.cod_fdc
        , a.cod_proprietario
        , a.cod_occupante
        , a.cod_amministratore
        , a.cod_responsabile
        , a.cod_progettista
        , a.flag_resp as flag_responsabile
        , a.cod_intestatario
        , a.cod_installatore 
	, h.cognome as cognome_inst
        , h.nome    as nome_inst
        , i.cognome as cognome_prog
        , i.nome    as nome_prog
        , p.cognome as cognome_prop
        , p.nome    as nome_prop
        , o.cognome as cognome_occ 
        , o.nome    as nome_occ 
        , m.cognome as cognome_amm
        , m.nome    as nome_amm
       	, r.cognome as cognome_resp
        , r.nome    as nome_resp
        , t.cognome as cognome_inte
        , t.nome    as nome_inte
        , a.localita
        , a.numero
        , a.scala
        , a.esponente
        , a.piano
        , a.interno
        , a.cod_comune
        , a.cod_qua
        , a.cod_urb
        , a.cod_provincia
        , a.cap
        , l.descr_topo as toponimo
        , l.descrizione as indirizzo
	, a.cod_via
        , h.cognome as cognome_manu
        , h.nome as nome_manu
      from coimimst f
         , coimaimp a
           	left outer join coimcted b on b.cod_cted        = a.cod_cted
           	left outer join coimcomb c on c.cod_combustibile= a.cod_combustibile
           	left outer join coimtppr e on e.cod_tppr        = a.provenienza_dati
           	left outer join coimmanu h on h.cod_manutentore = a.cod_installatore
           	left outer join coimprog i on i.cod_progettista = a.cod_progettista
			left outer join coimcitt p on p.cod_cittadino 	= a.cod_proprietario
            left outer join coimcitt o on o.cod_cittadino 	= a.cod_occupante
            left outer join coimcitt m on m.cod_cittadino 	= a.cod_amministratore
            left outer join coimcitt r on r.cod_cittadino 	= a.cod_responsabile
            left outer join coimcitt t on t.cod_cittadino 	= a.cod_intestatario
            left outer join coimviae l on l.cod_via			= a.cod_via and l.cod_comune = a.cod_comune
            left outer join coimgend u on u.cod_impianto	= a.cod_impianto
            left outer join coimalim g on g.cod_alim 		= a.cod_alim
            left outer join coimfdc n on n.cod_fdc 			= a.cod_fdc
          where a.cod_impianto = :cod_impianto and f.cod_imst = a.stato
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_no_vie">
       <querytext>
 select a.cod_impianto_est
         , case a.flag_dichiarato
           when 'S' then 'SI'
           when 'N' then 'NO'
           when 'C' then 'N.C.'
           else '&nbsp;'
           end as desc_dich
         , coalesce(iter_edit_data(a.data_installaz),'&nbsp;') as data_installaz
         , coalesce(iter_edit_num(a.volimetria_risc, 2),'&nbsp;') as volimetria_risc
         , coalesce(b.descr_cted,'&nbsp;') as descr_cted
      
         , coalesce(c.descr_comb,'&nbsp;') as comb
	
	 , coalesce(e.descr_tppr,'&nbsp;') as descr_prov
         , f.descr_imst as desc_stato
       	 , a.cod_combustibile
   
        , a.cod_cted
        , u.cod_utgi
        , a.note_dest
        , a.cod_alim
        , coalesce(iter_edit_num(a.cop, 2),'&nbsp;') as cop
        , coalesce(iter_edit_num(a.per, 2),'&nbsp;') as per
        , a.cod_fdc
	 , a.cod_proprietario
        , a.cod_occupante
        , a.cod_amministratore
        , a.cod_responsabile
        , a.cod_progettista
        , a.flag_resp as flag_responsabile
        , a.cod_intestatario
        , a.cod_installatore 
	, h.cognome as cognome_inst
        , h.nome    as nome_inst
        , i.cognome as cognome_prog
        , i.nome    as nome_prog
        , p.cognome as cognome_prop
        , p.nome    as nome_prop
        , o.cognome as cognome_occ 
        , o.nome    as nome_occ 
        , m.cognome as cognome_amm
        , m.nome    as nome_amm
       	, r.cognome as cognome_resp
        , r.nome    as nome_resp
        , t.cognome as cognome_inte
        , t.nome    as nome_inte
        , a.localita
        , a.numero
        , a.scala
        , a.esponente
        , a.piano
        , a.interno
        , a.cod_comune
        , a.cod_qua
        , a.cod_urb
        , a.cod_provincia
        , a.cap
        , a.toponimo
        , a.indirizzo
	, a.cod_via
        , h.cognome as cognome_manu
        , h.nome as nome_manu
      from coimimst f
         , coimaimp a
           	left outer join coimcted b on b.cod_cted        = a.cod_cted
           	left outer join coimcomb c on c.cod_combustibile= a.cod_combustibile
           	left outer join coimtppr e on e.cod_tppr        = a.provenienza_dati
           	left outer join coimmanu h on h.cod_manutentore = a.cod_installatore
           	left outer join coimprog i on i.cod_progettista = a.cod_progettista
			left outer join coimcitt p on p.cod_cittadino 	= a.cod_proprietario
            left outer join coimcitt o on o.cod_cittadino 	= a.cod_occupante
            left outer join coimcitt m on m.cod_cittadino 	= a.cod_amministratore
            left outer join coimcitt r on r.cod_cittadino 	= a.cod_responsabile
            left outer join coimcitt t on t.cod_cittadino 	= a.cod_intestatario
            left outer join coimgend u on u.cod_impianto	= a.cod_impianto
            left outer join coimalim g on g.cod_alim 		= a.cod_alim
            left outer join coimfdc n on n.cod_fdc 			= a.cod_fdc
          where a.cod_impianto = :cod_impianto and f.cod_imst = a.stato
       </querytext>
    </fullquery>
    
</queryset>
