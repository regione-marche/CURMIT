<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_aimp_no_viae">
       <querytext>
    select coalesce(a.toponimo,'')||' '||coalesce(a.indirizzo,'')||' ,'||coalesce(a.numero,'')||' esp:'||coalesce(a.esponente,'')||' scala:'||coalesce(a.scala,'')||' piano:'||coalesce(a.piano,'')||' int:'||coalesce(a.interno,'')||' - Comune:'||coalesce(c.denominazione,'')||' ('||coalesce(d.sigla,'')||') CAP:'||coalesce(a.cap,'') as indir
         , a.cap
         , a.localita
         , c.denominazione as nome_comu
         , d.sigla
         , a.cod_impianto_est
         , coalesce(a.toponimo,'')||' '||coalesce(a.indirizzo,'') as via_imp
         , coalesce(a.numero,'')||' '||coalesce(a.esponente,'') as num_imp
         , a.scala as scala_imp
         , a.piano as piano_imp
         , a.interno as interno_imp
         , d.denominazione as prov
         , e.descr_comb as combustibile --gac01
	 , a.n_generatori as n_generatori_marche --gac01
	 , iter_edit_num(a.potenza_utile,2) as potenza_utile --gac01
      from coimaimp a
           left outer join coimcomu c on c.cod_comune    = a.cod_comune
           left outer join coimprov d on d.cod_provincia = a.cod_provincia
         , coimcomb e
     where a.cod_impianto = :cod_impianto
       and e.cod_combustibile = a.cod_combustibile
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_si_viae">
       <querytext>
    select coalesce(b.descr_topo,'')||' '||coalesce(b.descrizione,'')||' ,'||coalesce(a.numero,'')||' esp:'||coalesce(a.esponente,'')||' scala:'||coalesce(a.scala,'')||' piano:'||coalesce(a.piano,'')||' int:'||coalesce(a.interno,'')||' - Comune:'||coalesce(c.denominazione,'')||' ('||coalesce(d.sigla,'')||') CAP:'||coalesce(a.cap,'') as indir
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

    <fullquery name="sel_noveb">
       <querytext>
                select a.cod_impianto
                     , a.cod_manutentore
                     , coalesce(iter_edit_data(data_consegna), '&nbsp;') as data_consegna
                     , coalesce(luogo_consegna, '&nbsp;') as luogo_consegna
                     , flag_art_3
                     , flag_art_11
                     , flag_patente_abil
		     , flag_art_11_comma_3
		     , flag_installatore
                     , flag_responsabile
                     , n_generatori
                     , dich_conformita_nr
                     , coalesce(iter_edit_data(data_dich_conform), '&nbsp;') as data_dich_conform
                     , flag_libretto_centr
                     , coalesce(firma_dichiarante, '&nbsp;') as firma_dichiarante
                     , coalesce(iter_edit_data(data_dichiarazione), '&nbsp;') as data_dichiarazione
                     , coalesce(firma_responsabile, '&nbsp;') as firma_responsabile
                     , coalesce(iter_edit_data(data_ricevuta), '&nbsp;') as data_ricevuta
		     , regolamenti_locali
                     , flag_verif_emis_286
                     , coalesce(iter_edit_data(data_verif_emiss), '&nbsp;') as data_verif_emiss
		     , risultato_mg_nmc_h
                     , flag_risult_conforme
	             , coalesce(iter_edit_data(data_alleg_libretto), '&nbsp;') as data_alleg_libretto 
		     , coalesce(combustibili, '&nbsp;') as combustibili
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
                     , coalesce(iter_edit_data(dat_prot), '&nbsp;') as dat_prot
                     , flag_manutentore
		     , flag_dichiarante --gac01
		     , flag_rispetta_val_min --gac01
		     , nome_dichiarante    --gac01
		     , cognome_dichiarante --gac01
               from coimnoveb a
              where cod_noveb = :cod_noveb
	      </querytext>
    </fullquery>

    <fullquery name="sel_dati_manu">
       <querytext>
        select coalesce(cognome, '') as cognome_manu
             , coalesce(nome, '')    as nome_manu
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

</queryset>
