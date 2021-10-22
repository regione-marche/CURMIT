<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_via">
       <querytext>
             select cod_via
               from coimviae
              where cod_comune  = :f_cod_comune
                and descr_topo  = upper(:f_descr_topo)
                and descrizione = upper(:f_descr_via)
       </querytext>
    </fullquery>

    <fullquery name="sel_cod_enve">
       <querytext>
	  select cod_enve
            from coimopve
           where cod_opve = :cod_tecn
       </querytext>
    </fullquery>

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

    <fullquery name="sel_cinc_count">
       <querytext>
                   select count(*) as conta
                     from coimcinc
                    where stato = '1'
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc">
       <querytext>
                   select cod_cinc
                        , descrizione as desc_camp
                     from coimcinc
                    where stato = '1'
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
