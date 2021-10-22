<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="upd_aimp">
       <querytext>
                update coimaimp
                   set cod_proprietario   = :cod_proprietario
                     , cod_occupante      = :cod_occupante   
                     , cod_amministratore = :cod_amministratore
                     , cod_responsabile   = :cod_responsabile
                     , flag_resp          = :flag_responsabile
                     , cod_intestatario   = :cod_intestatario
                     , data_mod           =  sysdate
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
                     , data_mod           =  sysdate
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
                     , sysdate        
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
               , iter_edit.data(a.data_installaz)  as data_variaz
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
                $join_prop_ora
                $join_occu_ora
                $join_ammi_ora
                $join_resp_ora
                $join_inte_ora
           where a.cod_impianto      = :cod_impianto
             and b.cod_cittadino (+) = a.cod_proprietario
             and c.cod_cittadino (+) = a.cod_occupante
             and d.cod_cittadino (+) = a.cod_amministratore
             and e.cod_cittadino (+) = a.cod_responsabile
             and f.cod_cittadino (+) = a.cod_intestatario
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
        select iter_edit.data (sysdate)     as data_ini_valid
              ,               (sysdate - 1) as data_fin_valid
          from dual
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
          from dual
       </querytext>
    </fullquery>

    <fullquery name="aggiungi_data">
       <querytext>
        select iter_edit.data(to_date(:data_max_valid, 'yyyymmdd') + 1) as data_max_valid
          from dual
       </querytext>
    </fullquery>

    <fullquery name="ultima_mod">
       <querytext>
        select iter_edit.data(max(data_fin_valid) + 1) as data_variaz 
          from coimrife 
         where cod_impianto = :cod_impianto
           and ruolo in ('P', 'O', 'A', 'R', 'T')
       </querytext>
    </fullquery>

</queryset>
