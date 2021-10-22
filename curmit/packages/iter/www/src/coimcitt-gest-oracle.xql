<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="del_citt">
        <querytext>
                delete
                  from coimcitt
                 where cod_cittadino = :cod_cittadino 
       </querytext>
    </partialquery>


    <partialquery name="mod_citt">
        <querytext>
                 update coimcitt
                   set natura_giuridica = :natura_giuridica
                     , cognome          = upper(:cognome)
                     , nome             = upper(:nome)
                     , indirizzo        = upper(:indirizzo)
                     , numero           = :numero
                     , cap              = :cap
                     , localita         = upper(:localita)
                     , comune           = upper(:comune)
                     , provincia        = upper(:provincia)
                     , cod_fiscale      = upper(:cod_fiscale)
                     , cod_piva         = :cod_piva
                     , telefono         = :telefono
                     , cellulare        = :cellulare
                     , fax              = :fax
                     , email            = :email
                     , data_nas         = :data_nas
                     , comune_nas       = :comune_nas
                     , note             = :note
                     , stato_citt       = :stato_citt
		     , patentino        = :patentino
		     , patentino_fgas   = :patentino_fgas
                 where cod_cittadino    = :cod_cittadino
       </querytext>
    </partialquery>

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
		     , patentino
		     , patentino_fgas
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
		     ,:patentino
		     ,:patentino_fgas
                     )
       </querytext>
    </partialquery>


    <fullquery name="sel_cod">
        <querytext>
	    select coimcitt_s.nextval as cod_cittadino
              from dual
       </querytext>
    </fullquery>

    <fullquery name="sel_citt_chk">
        <querytext> 
        select '1'
          from coimcitt
         where cod_cittadino = :cod_cittadino
       </querytext>
    </fullquery>

    <fullquery name="sel_citt">
        <querytext>
             select cod_cittadino
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
                  , iter_edit.data(data_nas) as data_nas
                  , comune_nas
                  , note
                  , stato_citt
		  , patentino
		  , patentino_fgas
               from coimcitt
              where cod_cittadino = :cod_cittadino
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
</queryset>
