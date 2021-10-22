<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

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

    <fullquery name="sel_next_noveb">
       <querytext>
        select nvl(max(to_number(cod_noveb, 99999990) ),0) + 1 as cod_noveb from coimnoveb
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
        select a.cod_manutentore
             , b.nome as nome_manu
             , b.cognome as cognome_manu
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
           select iter_edit.data(data_installaz) as data_installaz
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

</queryset>
