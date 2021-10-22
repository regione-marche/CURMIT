<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_batc_1">
       <querytext>
             select iter_edit_data(dat_prev) as dat_prev
                  , iter_edit_time(ora_prev) as ora_prev
                  , par
               from coimbatc
              where cod_batc = :cod_batc_1
       </querytext>
    </fullquery>

	<fullquery name="sel_batc_2">
       <querytext>
             select iter_edit_data(dat_prev) as dat_prev
                  , iter_edit_time(ora_prev) as ora_prev
                  , par
               from coimbatc
              where cod_batc = :cod_batc_2
       </querytext>
    </fullquery>
    
    <fullquery name="sel_batc_next_1">
       <querytext>
             select nextval('coimbatc_s') as cod_batc_1
       </querytext>
    </fullquery>
    
    <fullquery name="sel_batc_next_2">
       <querytext>
             select nextval('coimbatc_s') as cod_batc_2
       </querytext>
    </fullquery>

    <partialquery name="ins_batc_1">
       <querytext>
                insert
                  into coimbatc 
                     ( cod_batc
                     , nom
                     , flg_stat
                     , dat_prev
                     , ora_prev
                     , cod_uten_sch
                     , nom_prog
                     , par
                     , note)
                values
                     (:cod_batc_1
                     ,:nom
                     ,:flg_stat
                     ,:dat_prev
                     ,:ora_prev
                     ,:cod_uten_sch
                     ,:nom_prog_1
                     ,:par
                     ,:note)
       </querytext>
    </partialquery>
    
        <partialquery name="ins_batc_2">
       <querytext>
                insert
                  into coimbatc 
                     ( cod_batc
                     , nom
                     , flg_stat
                     , dat_prev
                     , ora_prev
                     , cod_uten_sch
                     , nom_prog
                     , par
                     , note)
                values
                     (:cod_batc_2
                     ,:nom
                     ,:flg_stat
                     ,:dat_prev
                     ,:ora_prev
                     ,:cod_uten_sch
                     ,:nom_prog_2
                     ,:par
                     ,:note)
       </querytext>
    </partialquery>

</queryset>
