<?xml version="1.0"?>


<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>


    <fullquery name="sel_prov_1">
       <querytext>
                  select denominazione
                       , cod_regione
                       , flag_val
		       , cod_istat
		       , sigla
		    from coimprov
		   where cod_provincia = :cod_provincia
       </querytext>
    </fullquery>

    <fullquery name="sel_regi_1">
       <querytext>
                  select denominazione as nome_regi
		    from coimregi
		   where cod_regione = :cod_regione
       </querytext>
    </fullquery>

    <fullquery name="sel_regi_2">
       <querytext>
                  select 1
                    from coimregi
                   where cod_regione = :cod_regione
       </querytext>
    </fullquery>

    <fullquery name="sel_regi_2">
       <querytext>
                 select count(*) as conta
                   from coimcomu
                  where cod_provincia = :cod_provincia
       </querytext>
    </fullquery>

    <fullquery name="sel_prov_2">
       <querytext>
                 select '1'
		   from coimprov
		  where cod_provincia = :cod_provincia
       </querytext>
    </fullquery>

    <fullquery name="sel_prov_next">
       <querytext>
                   select coimprov_s.nextval as cod_provincia
                from dual
       </querytext>
    </fullquery>

    <fullquery name="sel_comu">
       <querytext>
                 select count(*) as conta
                   from coimcomu
                  where cod_provincia = :cod_provincia
       </querytext>
    </fullquery>
  
    <partialquery name="ins_prov">
       <querytext>
                insert into coimprov
                     ( cod_provincia
                     , denominazione
                     , cod_regione
                     , flag_val
                     , cod_istat
                     , sigla)
                values 
                     (:cod_provincia
                     ,:denominazione
                     ,:cod_regione
                     ,:flag_val
                     ,:cod_istat
                     ,:sigla)
       </querytext>
    </partialquery>

    <partialquery name="upd_prov">
       <querytext>
                update coimprov
                   set denominazione = :denominazione
                     , cod_regione   = :cod_regione
                     , flag_val      = :flag_val
                     , cod_istat     = :cod_istat
                     , sigla         = :sigla
                 where cod_provincia = :cod_provincia
       </querytext>
    </partialquery>

    <partialquery name="del_prov">
       <querytext>
                delete
                  from coimprov
                 where cod_provincia = :cod_provincia
       </querytext>
    </partialquery>

</queryset>
