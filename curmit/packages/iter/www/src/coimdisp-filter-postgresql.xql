<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>


    <fullquery name="sel_cod_enve">
       <querytext>
	  select cod_enve
            from coimopve
           where cod_opve = :cod_opve
       </querytext>
    </fullquery>

    <fullquery name="sel_tecn">
       <querytext>
             select cognome as f_cog_tecn
                  , nome    as f_nom_tecn
               from coimopve
              where cod_opve = :cod_opve
       </querytext>
    </fullquery>

    <fullquery name="sel_tecn_nom">
       <querytext>
             select cod_opve as cod_tecn_db
               from coimopve
              where cod_enve       = :cod_enve
                and upper(nome)    = upper(:f_nom_tecn)
                and upper(cognome) = upper(:f_cog_tecn)
       </querytext>
    </fullquery>

    <fullquery name="sel_ragione_enve">
        <querytext>
	   select ragione_01
             from coimenve
            where cod_enve = :cod_enve
	</querytext>
    </fullquery>

    <fullquery name="sel_livello_utente">
	<querytext>
		select livello
		from coimuten
		where id_utente = :id_utente
	</querytext>
    </fullquery>
</queryset>
