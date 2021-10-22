<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_desc_comu">
       <querytext>
           select denominazione as desc_comune
             from coimcomu
            where cod_comune = :f_cod_comune
       </querytext>
    </fullquery>

    
    <fullquery name="sel_opve">
       <querytext>
             select cognome as cog_tecn
                  , nome    as nom_tecn
                  , cod_enve
               from coimopve
              where cod_opve = :cod_opve
       </querytext>
    </fullquery>

    <fullquery name="sel_opve_nom">
       <querytext>
             select cod_opve as cod_opve_db
               from coimopve
              where cod_enve       = :cod_enve
                and upper(nome)    = upper(:nom_tecn)
                and upper(cognome) = upper(:cog_tecn)
       </querytext>
    </fullquery>

  
    <fullquery name="sel_cod_enve">
       <querytext>
             select cod_enve
               from coimopve
              where cod_opve = :cod_tecn
       </querytext>
    </fullquery>

    <fullquery name="sel_ragione_enve">
        <querytext>
	   select ragione_01
             from coimenve
            where cod_enve = :cod_enve
	</querytext>
    </fullquery>
</queryset>
