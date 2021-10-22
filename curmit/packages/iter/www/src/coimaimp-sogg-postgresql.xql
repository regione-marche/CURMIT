<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="upd_aimp">
       <querytext>
                update coimaimp
                   set cod_proprietario   = :cod_proprietario
                     , cod_occupante      = :cod_occupante   
                     , cod_amministratore = :cod_amministratore
                     , cod_responsabile   = :cod_responsabile
                     , flag_resp          = :flag_responsabile
                     , cod_intestatario   = :cod_intestatario
                     , data_mod           = current_date
                     , utente             = :id_utente                 
                 where cod_impianto = :cod_impianto
       </querytext>
    </partialquery>

    <partialquery name="del_aimp">
       <querytext>
                 update coimaimp
                   set cod_proprietario   = :cod_proprietario
                     , cod_occupante      = :cod_occupante   
                     , cod_amministratore = :cod_amministratore
                     , cod_responsabile   = :cod_responsabile
                     , flag_resp          = :flag_responsabile
                     , cod_intestatario   = :cod_intestatario
                     , data_mod           = current_date
                     , utente             = :id_utente                 
                 where cod_impianto = :cod_impianto
       </querytext>
    </partialquery>

    <partialquery name="ins_sogg">
       <querytext>
                insert
                  into coimrife 
                     ( cod_impianto
                     , ruolo
                     , data_fin_valid
                     , cod_soggetto
                     , data_ins           
                     , utente)             
                values
                     (:cod_impianto
                     ,:ruolo
                     ,:data_fin_valid
                     ,:db_cod_soggetto
                     , current_date        
                     ,:id_utente)   
       </querytext>
    </partialquery>

    <fullquery name="sel_rif_sogg">
       <querytext>
          select a.cod_impianto
               , a.cod_proprietario
               , a.cod_occupante
               , a.cod_amministratore
               , a.cod_responsabile
               , a.flag_resp as flag_responsabile
               , a.cod_intestatario
               , iter_edit_data(a.data_installaz)  as data_variaz
               , b.cognome as cognome_prop
               , b.nome    as nome_prop
               , b.cod_fiscale as cod_fiscale_prop
               , c.cognome as cognome_occ 
               , c.nome    as nome_occ 
               , c.cod_fiscale as cod_fiscale_occ
               , d.cognome as cognome_amm
               , d.nome    as nome_amm
               , d.cod_fiscale as cod_fiscale_amm
               , e.cognome as cognome_terzo
               , e.nome    as nome_terzo
               , e.cod_fiscale as cod_fiscale_terzo
               , f.cognome as cognome_inte
               , f.nome    as nome_inte
               , f.cod_fiscale as cod_fiscale_inte
            from coimaimp a
            left outer join coimcitt b on b.cod_cittadino = a.cod_proprietario
            left outer join coimcitt c on c.cod_cittadino = a.cod_occupante
            left outer join coimcitt d on d.cod_cittadino = a.cod_amministratore
            left outer join coimcitt e on e.cod_cittadino = a.cod_responsabile
            left outer join coimcitt f on f.cod_cittadino = a.cod_intestatario
           where a.cod_impianto = :cod_impianto
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

    <fullquery name="sel_cod_legale">
       <querytext>
             select a.cod_legale_rapp as cod_terzi
                  , b.cognome as cognome_terzi
                  , b.nome as nome_terzi
               from coimmanu a
                  , coimcitt b
              where a.cod_manutentore = :cod_terzi
                and a.cod_legale_rapp = b.cod_cittadino
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp">
       <querytext>
          select flag_dichiarato
               from coimaimp 
              where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_db">
       <querytext>
          select cod_responsabile         as db_cod_responsabile
               , cod_intestatario         as db_cod_intestatario
               , cod_proprietario         as db_cod_proprietario
               , cod_occupante            as db_cod_occupante
               , cod_amministratore       as db_cod_amministratore
               from coimaimp 
              where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_sogg_check">
       <querytext>
        select '1'
          from coimrife
         where cod_impianto    = :cod_impianto
           and ruolo           = :ruolo
           and data_fin_valid  = :data_fin_valid
       </querytext>
    </fullquery>

    <fullquery name="recup_date">
       <querytext>
        select iter_edit_data (current_date)     as data_ini_valid
              ,               (current_date - 1) as data_fin_valid
       </querytext>
    </fullquery>

    <fullquery name="sel_max_data">
       <querytext>
             select to_char(max(data_fin_valid), 'YYYYMMDD')  as data_max_valid
               from coimrife
              where 1 = 1
                and cod_impianto  = :cod_impianto
                and (ruolo         = 'P'  or
                     ruolo         = 'O'  or
                     ruolo         = 'A'  or
                     ruolo         = 'R'  or
                     ruolo         = 'T')
       </querytext>
    </fullquery>

    <fullquery name="sottrai_data">
       <querytext>
        select to_date(:data_ini_valid, 'YYYYMMDD') - 1   as data_fin_valid
       </querytext>
    </fullquery>

    <fullquery name="aggiungi_data">
       <querytext>
        select iter_edit_data(to_date(:data_max_valid, 'yyyymmdd') + 1) as data_max_valid
       </querytext>
    </fullquery>

    <fullquery name="ultima_mod">
       <querytext>
        select iter_edit_data(max(data_fin_valid) + 1) as data_variaz 
          from coimrife 
         where cod_impianto = :cod_impianto
           and ruolo in ('P', 'O', 'A', 'R', 'T')
       </querytext>
    </fullquery>

</queryset>
