<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="ins_nove">
       <querytext>
                insert
                  into coimnove
                     ( cod_nove
                     , cod_impianto
                     , cod_manutentore
                     , data_consegna
                     , luogo_consegna
                     , flag_art_109
                     , flag_art_11
                     , flag_installatore
                     , flag_manutentore
                     , pot_termica_mw
                     , combustibili
                     , n_focolari
                     , pot_focolari_mw
                     , n_bruciatori
                     , pot_tipi_bruc
                     , apparecchi_acc
                     , n_canali_fumo
                     , sez_min_canali
                     , svil_totale
                     , aperture_ispez
                     , n_camini
                     , sez_min_camini
                     , altezze_bocche
                     , durata_impianto
                     , manut_ordinarie
                     , manut_straord
                     , varie
                     , flag_consegnato
                     , firma
                     , data_rilascio
		     )
                values
                     ( :cod_nove
                     , :cod_impianto
                     , :cod_manutentore
                     , :data_consegna
                     , :luogo_consegna
                     , :flag_art_109
                     , :flag_art_11
                     , :flag_installatore
                     , :flag_manutentore
                     , :pot_termica_mw
                     , :combustibili
                     , :n_focolari
                     , :pot_focolari_mw
                     , :n_bruciatori
                     , :pot_tipi_bruc
                     , :apparecchi_acc
                     , :n_canali_fumo
                     , :sez_min_canali
                     , :svil_totale
                     , :aperture_ispez
                     , :n_camini
                     , :sez_min_camini
                     , :altezze_bocche
                     , :durata_impianto
                     , :manut_ordinarie
                     , :manut_straord
                     , :varie
                     , :flag_consegnato
                     , :firma
                     , :data_rilascio
		     )
       </querytext>
    </fullquery>

    <fullquery name="upd_nove">
       <querytext>
                update coimnove
                   set cod_manutentore   = :cod_manutentore
                     , data_consegna     = :data_consegna
                     , luogo_consegna    = :luogo_consegna
                     , flag_art_109      = :flag_art_109
                     , flag_art_11       = :flag_art_11
                     , flag_installatore = :flag_installatore
                     , flag_manutentore  = :flag_manutentore
                     , pot_termica_mw    = :pot_termica_mw
                     , combustibili      = :combustibili
                     , n_focolari        = :n_focolari
                     , pot_focolari_mw   = :pot_focolari_mw
                     , n_bruciatori      = :n_bruciatori
                     , pot_tipi_bruc     = :pot_tipi_bruc
                     , apparecchi_acc    = :apparecchi_acc
                     , n_canali_fumo     = :n_canali_fumo
                     , sez_min_canali    = :sez_min_canali
                     , svil_totale       = :svil_totale
                     , aperture_ispez    = :aperture_ispez
                     , n_camini          = :n_camini
                     , sez_min_camini    = :sez_min_camini
                     , altezze_bocche    = :altezze_bocche
                     , durata_impianto   = :durata_impianto
                     , manut_ordinarie   = :manut_ordinarie
                     , manut_straord     = :manut_straord
                     , varie             = :varie
                     , flag_consegnato   = :flag_consegnato
                     , firma             = :firma
                     , data_rilascio     = :data_rilascio
                 where cod_nove = :cod_nove
       </querytext>
    </fullquery>

    <fullquery name="del_nove">
       <querytext>
                delete
                  from coimnove
                 where cod_nove = :cod_nove
       </querytext>
    </fullquery>

    <fullquery name="sel_nove">
       <querytext>
                select a.cod_manutentore
                     , iter_edit.data(data_consegna) as data_consegna
                     , luogo_consegna
                     , flag_art_109
                     , flag_art_11
                     , flag_installatore
                     , flag_manutentore
                     , iter_edit.num(pot_termica_mw, 4) as pot_termica_mw
                     , combustibili
                     , n_focolari
                     , pot_focolari_mw
                     , n_bruciatori
                     , pot_tipi_bruc
                     , apparecchi_acc
                     , n_canali_fumo
                     , iter_edit.num(sez_min_canali, 2) as sez_min_canali
                     , iter_edit.num(svil_totale, 2) as svil_totale
                     , aperture_ispez
                     , n_camini
                     , iter_edit.num(sez_min_camini, 2) as sez_min_camini
                     , altezze_bocche
                     , durata_impianto
                     , manut_ordinarie
                     , manut_straord
                     , varie
                     , flag_consegnato
                     , firma
                     , iter_edit.data(a.data_rilascio) as data_rilascio
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

    <fullquery name="sel_next_nove">
       <querytext>
        select nvl(max(to_number(cod_nove, '99999990') ),0) + 1 as cod_nove from coimnove
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
             from coimnove
            where cod_nove = :cod_nove
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
