<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_tecn">
       <querytext>
             select cognome as f_cog_tecn
                  , nome    as f_nom_tecn
               from coimopve
              where cod_opve = :f_cod_tecn
       </querytext>
    </fullquery>

    <fullquery name="sel_tecn_nom">
       <querytext>
             select cod_opve as cod_tecn_db
               from coimopve
              where cod_enve       = :f_cod_enve
                and upper(nome)    = upper(:f_nom_tecn)
                and upper(cognome) = upper(:f_cog_tecn)
       </querytext>
    </fullquery>

</queryset>
