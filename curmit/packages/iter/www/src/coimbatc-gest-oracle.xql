<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="upd_batc">
       <querytext>
                update coimbatc
                   set dat_prev = :dat_prev
                     , ora_prev = :ora_prev
                 where cod_batc = :cod_batc
       </querytext>
    </partialquery>

    <partialquery name="del_batc">
       <querytext>
                delete
                  from coimbatc
                 where cod_batc = :cod_batc
       </querytext>
    </partialquery>

    <fullquery name="sel_batc">
       <querytext>
             select nom
                  , flg_stat
                  , iter_edit.data(dat_prev) as dat_prev
                  , iter_edit.time(ora_prev) as ora_prev
                  , cod_uten_sch
               from coimbatc
              where cod_batc = :cod_batc
       </querytext>
    </fullquery>

    <fullquery name="sel_batc_stat">
       <querytext>
             select flg_stat
               from coimbatc
              where cod_batc = :cod_batc
       </querytext>
    </fullquery>

</queryset>
