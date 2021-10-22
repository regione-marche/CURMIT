<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_comu">
        <querytext>
                   select cod_provincia
                        , denominazione 
                        , flag_val
                        , cap
                        , id_belfiore
                        , cod_istat
                        , iter_edit.num(popolaz_citt,0) as popolaz_citt
                        , iter_edit.num(popolaz_aimp,0) as popolaz_aimp
                     from coimcomu
                    where cod_comune = :cod_comune
       </querytext>
   </fullquery>

    <fullquery name="sel_prov">
        <querytext>
                   select denominazione as nome_prov 
                     from coimprov
                    where cod_provincia = :cod_provincia
       </querytext>
   </fullquery>

   <partialquery name="ins_comu">
        <querytext>
                   insert
                     into coimcomu
                        ( cod_comune
                        , cod_provincia
                        , denominazione
                        , cap
                        , id_belfiore
                        , cod_istat
                        , flag_val
                        , popolaz_citt
                        , popolaz_aimp
                        )
                 values (:cod_comune
                        ,:cod_provincia
                        ,:denominazione
                        ,:cap
                        ,:id_belfiore
                        ,:cod_istat
                        ,:flag_val
                        ,:popolaz_citt
                        ,:popolaz_aimp
                       )
       </querytext>
   </partialquery>

    <partialquery name="upd_comu">
        <querytext>
                   update coimcomu
                      set cod_provincia = :cod_provincia
                        , denominazione = :denominazione
                        , cap           = :cap
                        , id_belfiore   = :id_belfiore
                        , cod_istat     = :cod_istat
                        , flag_val      = :flag_val
                        , popolaz_citt  = :popolaz_citt
                        , popolaz_aimp  = :popolaz_aimp
                    where cod_comune    = :cod_comune
       </querytext>
   </partialquery>

    <partialquery name="del_comu">
        <querytext>
                   delete
                     from coimcomu
                    where cod_comune = :cod_comune
       </querytext>
   </partialquery>

   <fullquery name="sel_dual_date">
        <querytext>
                    select to_char(sysdate, 'yyyymmdd')
                        as currente_date
                      from dual
       </querytext>
   </fullquery>
 

    <fullquery name="sel_nextval_comu">
        <querytext>
                   select coimcomu_s.nextval as cod_comune
                     from dual
       </querytext>
   </fullquery>

    <fullquery name="sel_aimp_count">
        <querytext>
             select count(*) as conta_aimp
               from coimaimp
	             where cod_comune = :cod_comune
       </querytext>
   </fullquery>

</queryset>
