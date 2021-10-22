<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_sogg">
        <querytext>
                   select cod_cittadino
                        , coalesce(cognome,'')||' '||coalesce(nome,'')
                       as nominativo
                        , coalesce(indirizzo,'')||' '||coalesce(numero,'') as indirizzo
                        , comune
                        , coalesce(cod_fiscale, '&nbsp;') as cod_fiscale
                     from coimcitt
                    where cod_cittadino = :cod_sogg
                          and cod_cittadino not like 'AM%'
       </querytext>
   </fullquery>

    <partialquery name="upd_aimp_prop">
       <querytext>
          update coimaimp
	     set cod_proprietario = :destinazione
           where cod_proprietario = :cod_sogg
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_occu">
       <querytext>
          update coimaimp
	     set cod_occupante = :destinazione
           where cod_occupante = :cod_sogg
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_ammi">
       <querytext>
          update coimaimp
	     set cod_amministratore = :destinazione
           where cod_amministratore = :cod_sogg
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_resp">
       <querytext>
          update coimaimp
	     set cod_responsabile = :destinazione
           where cod_responsabile = :cod_sogg
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_inte">
       <querytext>
          update coimaimp
	     set cod_intestatario = :destinazione
           where cod_intestatario = :cod_sogg
       </querytext>
    </partialquery>

  <partialquery name="upd_aimp_rife">
       <querytext>
          update coimrife
	     set cod_soggetto = :destinazione
           where cod_soggetto = :cod_sogg
       </querytext>
    </partialquery>


    <partialquery name="del_sogg">
       <querytext>
           delete 
             from coimcitt
            where cod_cittadino = :cod_sogg
       </querytext>
    </partialquery>

    <partialquery name="upd_dimp_resp">--rom01
       <querytext>
	   update coimdimp
              set cod_responsabile = :destinazione
            where cod_responsabile = :cod_sogg
       </querytext>
    </partialquery>    

    <partialquery name="upd_dimp_occu">--rom01
       <querytext>
       update coimdimp
             set cod_occupante = :destinazione
        where cod_occupante = :cod_sogg
       </querytext>
    </partialquery>

    <partialquery name="upd_dimp_prop">--rom01
       <querytext>
          update coimdimp
	        set cod_proprietario = :destinazione
        where cod_proprietario = :cod_sogg
       </querytext>
    </partialquery>

    <partialquery name="upd_cimp_resp">--rom02
       <querytext>
           update coimcimp
              set cod_responsabile = :destinazione
            where cod_responsabile = :cod_sogg
       </querytext>
    </partialquery>

    <partialquery name="upd_dope_resp">--rom02
       <querytext>
           update coimdope_aimp
              set cod_responsabile = :destinazione
            where cod_responsabile = :cod_sogg
       </querytext>
    </partialquery>

</queryset>
