<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>
    
    <fullquery name="sel_dual_date">
       <querytext>
                  select to_char(sysdate, 'yyyymmdd') as current_date
                    from dual
       </querytext>
    </fullquery>
   
   
    <fullquery name="sel_prov">
       <querytext>
            
                  select count(*) as conta
                    from coimprov
                   where cod_regione = :cod_regione 
            
       </querytext>
    </fullquery>

    <fullquery name="sel_regi_s">
       <querytext>
                   select coimregi_s.nextval as cod_regione 
                    from dual
       </querytext>
    </fullquery>
    
    <fullquery name="sel_regi">
       <querytext>
             
             select denominazione
                  , flag_val
                  , cod_istat
               from coimregi
              where cod_regione = :cod_regione

       </querytext>
    </fullquery>

    <partialquery name="ins_regi">
       <querytext>
             
                insert
                  into coimregi 
                     ( cod_regione
                     , denominazione
                     , flag_val
                     , cod_istat)
                values 
                     (:cod_regione
                     ,:denominazione
                     ,:flag_val
                     ,:cod_istat)

       </querytext>
    </partialquery>
 
    <partialquery name="upd_regi">
       <querytext>
             
                update coimregi
                   set cod_regione   = :cod_regione
                     , denominazione = :denominazione
                     , flag_val      = :flag_val
                     , cod_istat     = :cod_istat
                 where cod_regione   = :cod_regione
                 
       </querytext>
    </partialquery>

    <partialquery name="del_regi">
       <querytext>
            
                  delete
                    from coimregi
                   where cod_regione   = :cod_regione
 
       </querytext>
    </partialquery>

</queryset>
   
