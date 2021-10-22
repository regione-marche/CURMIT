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
                select a.cod_impianto
                     , a.cod_manutentore
                     , nvl(iter_edit.data(data_consegna), '&nbsp;') as data_consegna
                     , nvl(luogo_consegna, '&nbsp;') as luogo_consegna
                     , flag_art_3
                     , flag_art_11
                     , flag_patente_abil
                     , flag_art_11_comma_3
                     , flag_installatore
                     , flag_responsabile
                     , n_generatori
                     , dich_conformita_nr
                     , nvl(iter_edit.data(data_dich_conform), '&nbsp;') as data_dich_conform
                     , flag_libretto_centr
                     , nvl(firma_dichiarante, '&nbsp;') as firma_dichiarante
                     , nvl(iter_edit.data(data_dichiarazione), '&nbsp;') as data_dichiarazione
                     , nvl(firma_responsabile, '&nbsp;') as firma_responsabile
                     , nvl(iter_edit.data(data_ricevuta), '&nbsp;') as data_ricevuta
                     , regolamenti_locali
                     , flag_verif_emis_286
                     , nvl(iter_edit.data(data_verif_emiss), '&nbsp;') as data_verif_emiss
                     , risultato_mg_nmc_h
                     , flag_risult_conforme
                     , nvl(iter_edit.data(data_alleg_libretto), '&nbsp;') as data_alleg_libretto
                     , nvl(combustibili, '&nbsp;') as combustibili
                     , flag_consegnato
                     , iter_edit.num(pot_term_tot_mw, 4) as pot_term_tot_mw
               from coimnoveb a
              where cod_noveb = :cod_noveb
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
