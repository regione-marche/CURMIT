<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_batc">
       <querytext>
             select iter_edit.data(dat_prev) as dat_prev
                  , iter_edit.time(ora_prev) as ora_prev
                  , par
               from coimbatc
              where cod_batc = :cod_batc
       </querytext>
    </fullquery>

    <fullquery name="sel_batc_next">
       <querytext>
             select coimbatc_s.nextval as cod_batc
               from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_batc">
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
                     (:cod_batc
                     ,:nom
                     ,:flg_stat
                     ,:dat_prev
                     ,:ora_prev
                     ,:cod_uten_sch
                     ,:nom_prog
                     ,:par
                     ,:note)
       </querytext>
    </partialquery>

    <fullquery name="sel_date_cinc">
       <querytext>
            select to_char(data_inizio, 'yyyymmdd') as data_inizio
                 , to_char(data_fine, 'yyyymmdd') as data_fine
              from coimcinc
             where cod_cinc = :cod_cinc
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc_att">
       <querytext>
            select cod_cinc as cod_cinc_att
              from coimcinc
             where stato = '1'
       </querytext>
    </fullquery>


</queryset>
