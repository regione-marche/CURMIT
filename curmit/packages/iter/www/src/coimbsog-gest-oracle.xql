<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_sogg">
        <querytext>
                   select cod_cittadino
                        , nvl(cognome,'')||' '||nvl(nome,'')
                       as nominativo
                        , nvl(indirizzo,'')||' '||nvl(numero,'') as indirizzo
                        , comune
                        , nvl(cod_fiscale, '&nbsp;') as cod_fiscale
                     from coimcitt
                    where cod_cittadino = :cod_sogg
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

    <partialquery name="del_sogg">
       <querytext>
           delete 
             from coimcitt
            where cod_cittadino = :cod_sogg
       </querytext>
    </partialquery>


</queryset>
