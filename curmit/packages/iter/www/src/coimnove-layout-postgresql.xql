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
      from coimaimp a
           left outer join coimcomu c on c.cod_comune    = a.cod_comune
           left outer join coimprov d on d.cod_provincia = a.cod_provincia
     where a.cod_impianto = :cod_impianto
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
      from coimaimp a
           left outer join coimviae b on b.cod_via       = a.cod_via
                                     and b.cod_comune    = a.cod_comune
           left outer join coimcomu c on c.cod_comune    = a.cod_comune
           left outer join coimprov d on d.cod_provincia = a.cod_provincia
     where a.cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_nove">
       <querytext>
                select a.cod_manutentore
                     , coalesce(iter_edit_data(data_consegna), '&nbsp;') as data_consegna
                     , coalesce(luogo_consegna, '&nbsp;') as luogo_consegna
                     , flag_art_109
                     , flag_art_11
                     , flag_installatore
                     , flag_manutentore
                     , iter_edit_num(pot_termica_mw, 2) as pot_termica_mw
                     , coalesce(combustibili, '&nbsp;') as combustibili
                     , n_focolari
                     , coalesce(pot_focolari_mw, '&nbsp;') as pot_focolari_mw
                     , n_bruciatori
                     , coalesce(pot_tipi_bruc, '&nbsp;') as pot_tipi_bruc
                     , coalesce(apparecchi_acc, '&nbsp;') as apparecchi_acc
                     , n_canali_fumo
                     , iter_edit_num(sez_min_canali, 2) as sez_min_canali
                     , iter_edit_num(svil_totale, 2) as svil_totale
                     , coalesce(aperture_ispez, '&nbsp;') as aperture_ispez
                     , n_camini
                     , iter_edit_num(sez_min_camini, 2) as sez_min_camini
                     , coalesce(altezze_bocche, '&nbsp;') as altezze_bocche
                     , coalesce(durata_impianto, '&nbsp;') as durata_impianto
                     , coalesce(manut_ordinarie, '&nbsp;') as manut_ordinarie
                     , coalesce(manut_straord, '&nbsp;') as manut_straord
                     , coalesce(varie, '&nbsp;') as varie
                     , coalesce(firma, '&nbsp;') as firma
               from coimnove a
              where cod_nove = :cod_nove
       </querytext>
    </fullquery>

    <fullquery name="sel_dati_manu">
       <querytext>
        select coalesce(cognome, '') as cognome_manu
             , coalesce(nome, '') as nome_manu
          from coimmanu
         where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_dati_citt">
       <querytext>
        select coalesce(cognome, '') as cognome_manu
             , coalesce(nome, '') as nome_manu
          from coimcitt
         where cod_cittadino = :cod_manutentore
       </querytext>
    </fullquery>

</queryset>
