<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>


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
                     , stato_citt
                     )
                values 
                     (:cod_cittadino
                     ,:natura_giuridica
                     ,upper(:cognome)
                     ,upper(:nome)
                     ,upper(:indirizzo)
                     ,:numero
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
                     ,:stato_citt
                     )
       </querytext>
    </partialquery>


    <fullquery name="sel_cod">
        <querytext>
	    select coimcitt_s.nextval as cod_cittadino
              from dual
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

</queryset>
