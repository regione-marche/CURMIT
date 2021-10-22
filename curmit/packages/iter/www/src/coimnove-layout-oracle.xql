<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_aimp_no_viae">
       <querytext>
    select nvl(a.toponimo,'')||' '||nvl(a.indirizzo,'')||' '||nvl(a.numero,'')||' '||nvl(a.esponente,'')||' '||nvl(a.scala,'')||' '||nvl(a.piano,'')||' '||nvl(a.interno,'') as indir
         , a.cap
         , a.localita
         , c.denominazione as nome_comu
         , d.sigla
         , a.cod_impianto_est
         , nvl(a.toponimo,'')||' '||nvl(a.indirizzo,'') as via_imp
         , nvl(a.numero,'')||' '||nvl(a.esponente,'') as num_imp
         , a.scala as scala_imp
         , a.piano as piano_imp
         , a.interno as interno_imp
         , d.denominazione as prov
      from coimaimp a
         , coimcomu c
         , coimprov d
     where a.cod_impianto = :cod_impianto
       and c.cod_comune  (+)   = a.cod_comune
       and d.cod_provincia  (+) = a.cod_provincia
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_si_viae">
       <querytext>
    select nvl(b.descr_topo,'')||' '||nvl(b.descrizione,'')||' '||nvl(a.numero,'')||' '||nvl(a.esponente,'')||' '||nvl(a.scala,'')||' '||nvl(a.piano,'')||' '||nvl(a.interno,'') as indir
         , a.cap
         , c.denominazione as nome_comu
         , a.localita
         , d.sigla
         , a.cod_impianto_est
         , nvl(b.descr_topo,'')||' '||nvl(b.descrizione,'') as via_imp
         , nvl(a.numero,'')||' '||nvl(a.esponente,'') as num_imp
         , a.scala as scala_imp
         , a.piano as piano_imp
         , a.interno as interno_imp
         , d.denominazione as prov
      from coimaimp a
         , coimviae b
         , coimcomu c
         , coimprov d
     where a.cod_impianto = :cod_impianto
       and b.cod_via  (+)      = a.cod_via
       and b.cod_comune  (+)   = a.cod_comune
       and c.cod_comune (+)    = a.cod_comune
       and d.cod_provincia (+) = a.cod_provincia
       </querytext>
    </fullquery>

    <fullquery name="sel_nove">
       <querytext>
                select a.cod_manutentore
                     , nvl(iter_edit.data(data_consegna), '&nbsp;') as data_consegna
                     , nvl(luogo_consegna, '&nbsp;') as luogo_consegna
                     , flag_art_109
                     , flag_art_11
                     , flag_installatore
                     , flag_manutentore
                     , iter_edit.num(pot_termica_mw, 2) as pot_termica_mw
                     , nvl(combustibili, '&nbsp;') as combustibili
                     , n_focolari
                     , nvl(pot_focolari_mw, '&nbsp;') as pot_focolari_mw
                     , n_bruciatori
                     , nvl(pot_tipi_bruc, '&nbsp;') as pot_tipi_bruc
                     , nvl(apparecchi_acc, '&nbsp;') as apparecchi_acc
                     , n_canali_fumo
                     , iter_edit.num(sez_min_canali, 2) as sez_min_canali
                     , iter_edit.num(svil_totale, 2) as svil_totale
                     , nvl(aperture_ispez, '&nbsp;') as aperture_ispez
                     , n_camini
                     , iter_edit.num(sez_min_camini, 2) as sez_min_camini
                     , nvl(altezze_bocche, '&nbsp;') as altezze_bocche
                     , nvl(durata_impianto, '&nbsp;') as durata_impianto
                     , nvl(manut_ordinarie, '&nbsp;') as manut_ordinarie
                     , nvl(manut_straord, '&nbsp;') as manut_straord
                     , nvl(varie, '&nbsp;') as varie
                     , nvl(firma, '&nbsp;') as firma
               from coimnove a
              where cod_nove = :cod_nove
       </querytext>
    </fullquery>

    <fullquery name="sel_dati_manu">
       <querytext>
        select nvl(cognome, '') as cognome_manu
             , nvl(nome, '') as nome_manu
          from coimmanu
         where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_dati_citt">
       <querytext>
        select nvl(cognome, '') as cognome_manu
             , nvl(nome, '') as nome_manu
          from coimcitt
         where cod_cittadino = :cod_manutentore
       </querytext>
    </fullquery>

</queryset>
