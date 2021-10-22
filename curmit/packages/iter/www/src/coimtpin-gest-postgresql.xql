<?xml version="1.0"?>


<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_manu">
       <querytext>
                 select cognome||' '||coalesce(nome,'') as nome_manu
                   from coimmanu
                  where cod_manutentore = :cod_manutentore
       </querytext>
    </partialquery>

    <partialquery name="ins_tpin">
       <querytext>
                insert
                  into coimtpin_manu 
                     ( cod_coimtpin_manu
                     , cod_manutentore
                     , cod_coimtpin
                     , creation_user
                     , creation_date
                     ) 
                values
                     (:cod_coimtpin_manu
		     ,:cod_manutentore
		     ,:tipologia_impianto
		     ,:id_utente
		     , current_date
                     );
       </querytext>
    </partialquery>

    <fullquery name="sel_opma">
       <querytext>
             select cod_opma
                  , cod_manutentore
                  , cognome
                  , nome
                  , matricola
                  , stato
		  , telefono
		  , cellulare
		  , recapito
                  , codice_fiscale
                  , note
                  , flag_portafoglio_admin --sim01
               from coimopma
              where cod_opma = :cod_opma
       </querytext>
    </fullquery>


</queryset>
