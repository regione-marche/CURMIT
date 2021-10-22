<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_batc">
       <querytext>
             select iter_edit_data(dat_prev) as dat_prev
                  , iter_edit_time(ora_prev) as ora_prev
                  , par
               from coimbatc
              where cod_batc = :cod_batc
       </querytext>
    </fullquery>

    <fullquery name="sel_batc_next">
       <querytext>
             select nextval('coimbatc_s') as cod_batc
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
