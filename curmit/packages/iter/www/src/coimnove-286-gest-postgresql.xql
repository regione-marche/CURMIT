<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="ins_noveb">
       <querytext>
                insert
                  into coimnoveb
                     ( cod_noveb
                     , cod_impianto
		     , cod_manutentore
                     , data_consegna
                     , luogo_consegna
                     , flag_art_3
                     , flag_art_11
                     , flag_patente_abil
                     , flag_art_11_comma_3     
		     , flag_installatore
                     , flag_responsabile
                     , n_generatori
                     , dich_conformita_nr
                     , data_dich_conform
                     , flag_libretto_centr
                     , firma_dichiarante
                     , data_dichiarazione
                     , firma_responsabile
                     , data_ricevuta
		     , regolamenti_locali
                     , flag_verif_emis_286
		     , data_verif_emiss
		     , risultato_mg_nmc_h
                     , flag_risult_conforme
		     , data_alleg_libretto
                     , combustibili
  		     , flag_consegnato		    
 		     , pot_term_tot_mw
 		     , manu_ord_1
 		     , manu_ord_2
 		     , manu_ord_3
 		     , manu_ord_4
 		     , manu_ord_5
 		     , manu_ord_6
 		     , manu_ord_7
                     , manu_flag_1
                     , manu_flag_2
                     , manu_flag_3
                     , manu_flag_4
                     , manu_flag_5
                     , manu_flag_6
                     , manu_flag_7
                     , manu_stra_1
                     , n_prot
                     , dat_prot
                     , flag_manutentore
		     , flag_dichiarante      --gac01
		     , flag_rispetta_val_min --gac01
		     , cognome_dichiarante   --gac01
		     , nome_dichiarante      --gac01
                     , flag_tracciato
		     , polveri_totali
		     , monossido_carbonio
		     , ossidi_azoto
		     , ossidi_zolfo
		     , carbonio_organico_totale
		     , composti_inorganici_cloro
		     , flag_uni_13284
		     , flag_uni_14792
		     , flag_uni_15058
		     , flag_uni_10393
		     , flag_uni_12619
		     , flag_uni_1911    
                     , flag_elettrochimico
		     , flag_normativa_previgente
		     )
                values
                     ( :cod_noveb
		     , :cod_impianto
                     , :cod_manutentore
                     , :data_consegna
                     , :luogo_consegna
                     , :flag_art_3
                     , :flag_art_11
                     , :flag_patente_abil
                     , :flag_art_11_comma_3
                     , :flag_installatore
                     , :flag_responsabile
                     , :n_generatori
                     , :dich_conformita_nr
                     , :data_dich_conform
                     , :flag_libretto_centr
                     , :firma_dichiarante
                     , :data_dichiarazione
                     , :firma_responsabile
                     , :data_ricevuta
                     , :regolamenti_locali
                     , :flag_verif_emis_286
                     , :data_verif_emiss
                     , :risultato_mg_nmc_h
                     , :flag_risult_conforme
                     , :data_alleg_libretto
                     , :combustibili
                     , :flag_consegnato
                     , :pot_term_tot_mw
 		     , :manu_ord_1
 		     , :manu_ord_2
 		     , :manu_ord_3
 		     , :manu_ord_4
 		     , :manu_ord_5
 		     , :manu_ord_6
 		     , :manu_ord_7
                     , :manu_flag_1
                     , :manu_flag_2
                     , :manu_flag_3
                     , :manu_flag_4
                     , :manu_flag_5
                     , :manu_flag_6
                     , :manu_flag_7
                     , :manu_stra_1
                     , :n_prot
                     , :dat_prot
                     , :flag_manutentore
		     , :flag_dichiarante      --gac01
		     , :flag_rispetta_val_min --gac01
		     , :cognome_dichiarante   --gac01
		     , :nome_dichiarante      --gac01
                     , '286'
		     , :polveri_totali
		     , :monossido_carbonio
		     , :ossidi_azoto
		     , :ossidi_zolfo
		     , :carbonio_organico_totale
		     , :composti_inorganici_cloro
		     , :flag_uni_13284
		     , :flag_uni_14792
		     , :flag_uni_15058
		     , :flag_uni_10393
		     , :flag_uni_12619
		     , :flag_uni_1911
		     , :flag_elettrochimico
		     , :flag_normativa_previgente
		     )
       </querytext>
    </fullquery>

    <fullquery name="upd_noveb">
       <querytext>
                update coimnoveb
                   set cod_manutentore      = :cod_manutentore
                     , data_consegna        = :data_consegna
                     , luogo_consegna       = :luogo_consegna
                     , flag_art_3           = :flag_art_3
                     , flag_art_11          = :flag_art_11
                     , flag_patente_abil    = :flag_patente_abil
                     , flag_art_11_comma_3  = :flag_art_11_comma_3
                     , flag_installatore    = :flag_installatore
                     , flag_responsabile    = :flag_responsabile
                     , n_generatori         = :n_generatori
                     , dich_conformita_nr   = :dich_conformita_nr
                     , data_dich_conform    = :data_dich_conform
                     , flag_libretto_centr  = :flag_libretto_centr
                     , firma_dichiarante    = :firma_dichiarante
                     , data_dichiarazione   = :data_dichiarazione
                     , firma_responsabile   = :firma_responsabile
                     , data_ricevuta        = :data_ricevuta
                     , regolamenti_locali   = :regolamenti_locali
                     , flag_verif_emis_286  = :flag_verif_emis_286
                     , data_verif_emiss     = :data_verif_emiss
                     , risultato_mg_nmc_h   = :risultato_mg_nmc_h
                     , flag_risult_conforme = :flag_risult_conforme
                     , data_alleg_libretto  = :data_alleg_libretto	
		     , combustibili         = :combustibili
                     , flag_consegnato      = :flag_consegnato
                     , pot_term_tot_mw      = :pot_term_tot_mw
                     , manu_ord_1           = :manu_ord_1
                     , manu_ord_2           = :manu_ord_2
                     , manu_ord_3           = :manu_ord_3
                     , manu_ord_4           = :manu_ord_4
                     , manu_ord_5           = :manu_ord_5
                     , manu_ord_6           = :manu_ord_6
                     , manu_ord_7           = :manu_ord_7
                     , manu_flag_1          = :manu_flag_1
                     , manu_flag_2          = :manu_flag_2
                     , manu_flag_3          = :manu_flag_3
                     , manu_flag_4          = :manu_flag_4
                     , manu_flag_5          = :manu_flag_5
                     , manu_flag_6          = :manu_flag_6
                     , manu_flag_7          = :manu_flag_7
                     , manu_stra_1          = :manu_stra_1
                     , flag_manutentore     = :flag_manutentore
		     , flag_dichiarante     = :flag_dichiarante       --gac01
		     , flag_rispetta_val_min = :flag_rispetta_val_min --gac01
		     , cognome_dichiarante  = :cognome_dichiarante    --gac01
		     , nome_dichiarante     = :nome_dichiarante       --gac01
		     , polveri_totali            = :polveri_totali
		     , monossido_carbonio        = :monossido_carbonio
		     , ossidi_azoto              = :ossidi_azoto
		     , ossidi_zolfo              = :ossidi_zolfo
		     , carbonio_organico_totale  = :carbonio_organico_totale
		     , composti_inorganici_cloro = :composti_inorganici_cloro
		     , flag_uni_13284            = :flag_uni_13284
		     , flag_uni_14792            = :flag_uni_14792
		     , flag_uni_15058            = :flag_uni_15058
		     , flag_uni_10393            = :flag_uni_10393
		     , flag_uni_12619            = :flag_uni_12619
		     , flag_uni_1911             = :flag_uni_1911
		     , flag_elettrochimico       = :flag_elettrochimico
		     , flag_normativa_previgente = :flag_normativa_previgente
		     where cod_noveb = :cod_noveb
       </querytext>
    </fullquery>

    <fullquery name="del_noveb">
       <querytext>
                delete
                  from coimnoveb
                 where cod_noveb = :cod_noveb
       </querytext>
    </fullquery>

    <fullquery name="sel_noveb">
       <querytext>
                select a.cod_manutentore
                     , cod_impianto
                     , cod_manutentore
                     , iter_edit_data(data_consegna) as data_consegna
                     , luogo_consegna
                     , flag_art_3
                     , flag_art_11
                     , flag_patente_abil
                     , flag_art_11_comma_3
                     , flag_installatore
                     , flag_responsabile
                     , iter_edit_num(n_generatori, 0) as n_generatori
                     , iter_edit_num(dich_conformita_nr, 0) as dich_conformita_nr       
                     , iter_edit_data(data_dich_conform) as data_dich_conform
                     , flag_libretto_centr
                     , firma_dichiarante
                     , iter_edit_data(data_dichiarazione) as data_dichiarazione
                     , firma_responsabile
                     , iter_edit_data(data_ricevuta) as data_ricevuta
                     , regolamenti_locali
                     , flag_verif_emis_286
                     , iter_edit_data(data_verif_emiss) as data_verif_emiss
                     , iter_edit_num(risultato_mg_nmc_h, 0) as risultato_mg_nmc_h
                     , flag_risult_conforme
                     , iter_edit_data(data_alleg_libretto) as data_alleg_libretto
                     , combustibili
                     , flag_consegnato
                     , iter_edit_num(pot_term_tot_mw, 4) as pot_term_tot_mw
 		     , manu_ord_1
 		     , manu_ord_2
 		     , manu_ord_3
 		     , manu_ord_4
 		     , manu_ord_5
 		     , manu_ord_6
 		     , manu_ord_7
                     , manu_flag_1
                     , manu_flag_2
                     , manu_flag_3
                     , manu_flag_4
                     , manu_flag_5
                     , manu_flag_6
                     , manu_flag_7
                     , manu_stra_1
                     , n_prot
                     , coalesce(iter_edit_data(dat_prot), '') as dat_prot
                     , flag_manutentore
		     , flag_dichiarante      --gac01
		     , flag_rispetta_val_min --gac01
		     , cognome_dichiarante   --gac01
		     , nome_dichiarante      --gac01
                     , flag_tracciato
                     , iter_edit_num(polveri_totali,2)            as polveri_totali
		     , iter_edit_num(monossido_carbonio,2)        as monossido_carbonio
		     , iter_edit_num(ossidi_azoto,2)              as ossidi_azoto
		     , iter_edit_num(ossidi_zolfo,2)              as ossidi_zolfo
		     , iter_edit_num(carbonio_organico_totale,2)  as carbonio_organico_totale
		     , iter_edit_num(composti_inorganici_cloro,2) as composti_inorganici_cloro
		     , flag_uni_13284
		     , flag_uni_14792
		     , flag_uni_15058
		     , flag_uni_10393
		     , flag_uni_12619
		     , flag_uni_1911
		     , flag_elettrochimico
		     , flag_normativa_previgente
		  from coimnoveb a
              where cod_noveb = :cod_noveb
       </querytext>
    </fullquery>

    <fullquery name="sel_dati_manu">
       <querytext>
        select coalesce(cognome, '') as cognome_manu
             , coalesce(nome, '') as nome_manu
	     , reg_imprese      --gac01
	     , localita_reg     --gac01
	     , flag_a           --gac01
	     , flag_c           --gac01
	     , flag_e           --gac01
	     , cod_legale_rapp  --gac01
	     , cod_piva as piva --gac01
             , coalesce(indirizzo, '')||' '||coalesce(localita,'') as indirizzo_manu --gac01
             , coalesce(provincia,'') as provincia_manu --gac01
             , coalesce(comune,'') as comune_manu       --gac01
             , coalesce(telefono,cellulare) as telefono --gac01
	     , fax              --gac01
	     , email            --gac01
	  from coimmanu
         where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_dati_citt">
       <querytext>
        select coalesce(cognome, '') as cognome_manu
             , coalesce(nome, '') as nome_manu
	     , cod_piva as piva --gac01
	     , coalesce(indirizzo, '')||' '||coalesce(localita,'') as indirizzo_manu --gac01
	     , coalesce(provincia,'') as provincia_manu --gac01
	     , coalesce(comune,'') as comune_manu       --gac01
	     , coalesce(telefono,cellulare) as telefono --gac01
	     , fax              --gac01
	     , email            --gac01
          from coimcitt
         where cod_cittadino = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_next_noveb">
       <querytext>
        select coalesce(max(to_number(cod_noveb, '99999990') ),0) + 1 as cod_noveb from coimnoveb
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
        select a.cod_manutentore
             , b.nome as nome_manu
             , b.cognome as cognome_manu
	     , b.reg_imprese      --gac01
	     , b.localita_reg     --gac01
             , b.flag_a           --gac01
	     , b.flag_c           --gac01
	     , b.flag_e           --gac01
	     , b.cod_legale_rapp  --gac01
	     , b.cod_piva as piva --gac01
             , coalesce(b.indirizzo, '')||' '||coalesce(b.localita,'') as indirizzo_manu --gac01
             , coalesce(b.provincia,'') as provincia_manu --gac01
             , coalesce(b.comune,'') as comune_manu       --gac01
             , coalesce(b.telefono,b.cellulare) as telefono --gac01
             , b.fax                --gac01
             , b.email              --gac01
	  from coimaimp a
             , coimmanu b
         where a.cod_impianto = :cod_impianto
           and a.cod_manutentore = b.cod_manutentore
</querytext>
    </fullquery>

    <fullquery name="sel_manu_cont">
       <querytext>
           select cod_manutentore as cod_manu_db
             from coimmanu
            where cognome $eq_cognome
              and nome    $eq_nome
       </querytext>
    </fullquery>

    <fullquery name="sel_cod_check">
       <querytext>
           select '1'
             from coimnoveb
            where cod_noveb = :cod_noveb
       </querytext>
    </fullquery>

    <fullquery name="sel_data_inst">
       <querytext>
           select iter_edit_data(data_installaz) as data_installaz
             from coimaimp
            where cod_impianto = :cod_impianto
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

    <fullquery name="sel_aimp_indir">
       <querytext>
   select coalesce(b.descr_topo,'')||' '||coalesce(b.descrizione,'')||' '||coalesce(a.numero,'')||' '||coalesce(a.esponente,'')||' '||coalesce(a.scala,'')||' '||coalesce(a.piano,'')||' '||coalesce(a.interno,'')||' '||coalesce(c.denominazione,'')||' '||coalesce(d.sigla,'')||' '||coalesce(a.cap,'') as indirizzo_impianto
         , a.cap
         , c.denominazione as nome_comu
         , a.localita
         , d.sigla
         , a.cod_impianto_est
         , coalesce(b.descr_topo,'')||' '||coalesce(b.descrizione,'') as via_imp
         , coalesce(a.numero,'')||' '||coalesce(a.esponente,'') as num_imp
         , a.scala as scala_imp
         , a.piano as piano_imp
         , a.interno as interno_imp
         , d.denominazione as prov
         , e.descr_comb as combustibile --gac01
	 , a.n_generatori as n_generatori_marche --gac01
	 , iter_edit_num(a.potenza_utile,2) as potenza_utile --gac01
      from coimaimp a
           left outer join coimviae b on b.cod_via       = a.cod_via
                                     and b.cod_comune    = a.cod_comune
           left outer join coimcomu c on c.cod_comune    = a.cod_comune
           left outer join coimprov d on d.cod_provincia = a.cod_provincia
         , coimcomb e
     where a.cod_impianto = :cod_impianto
       and e.cod_combustibile = a.cod_combustibile
</querytext>
    </fullquery>

  <fullquery name="upd_tppt">
       <querytext>
            update coimtppt
               set progressivo = progressivo + 1
             where cod_tppt = 'XU'
       </querytext>
    </fullquery>



</queryset>
