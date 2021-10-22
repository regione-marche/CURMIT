<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    gab01 13/02/2017 Gestisco il nuovo campo pec della coimcitt

-->
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

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
                     , cod_fiscale
                     , cod_piva
                     , telefono
                     , cellulare
                     , fax
                     , email
                     , data_nas
                     , comune_nas
                     , note
                     , data_ins
                     , utente
                     , sesso
                     , stato_citt
                     , pec --gab01
                     )
                values 
                     (:cod_cittadino
                     ,:natura_giuridica
                     ,upper(:cognome)
                     ,upper(:nome)
                     ,upper(:indirizzo)
                     ,null
                     ,:cap
                     ,upper(:localita)
                     ,upper(:comune)
                     ,upper(:provincia)
                     ,upper(:cod_fiscale)
                     ,:cod_piva
                     ,:telefono
                     ,:cellulare
                     ,:fax
                     ,:email
                     ,:data_nas
                     ,:comune_nas
                     ,:note
                     ,current_date
                     ,:id_utente
                     ,:sesso
                     ,:stato_citt
                     ,:pec --gab01
                     )
       </querytext>
    </partialquery>


    <fullquery name="sel_cod">
        <querytext>
           select nextval('coimcitt_s') as cod_cittadino
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_count">
        <querytext>
             select count(*) as conta_aimp
               from coimaimp
              where cod_responsabile   = :cod_cittadino
                 or cod_intestatario   = :cod_cittadino 
                 or cod_proprietario   = :cod_cittadino
                 or cod_occupante      = :cod_cittadino
                 or cod_amministratore = :cod_cittadino
       </querytext>
    </fullquery>

    <fullquery name="sel_comu_desc">
        <querytext>
             select denominazione as comu_denom
               from coimcomu
              where cod_comune = :cod_comune
       </querytext>
    </fullquery>

    <partialquery name="upd_manu">
        <querytext>
             update coimmanu
                set cod_legale_rapp = :cod_cittadino
              where cod_manutentore = :cod_manutentore
       </querytext>
    </partialquery>


</queryset>
