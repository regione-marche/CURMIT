<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_tpdo">
       <querytext>
                insert
                  into coimtpdo
                     ( cod_tpdo
                     , descrizione)
                values 
                     (:cod_tpdo
                     ,:descr_tpdo)
       </querytext>
    </partialquery>

    <partialquery name="upd_tpdo">
       <querytext>
                update coimtpdo
                   set descrizione = :descr_tpdo
                 where cod_tpdo = :cod_tpdo
       </querytext>
    </partialquery>

    <partialquery name="del_tpdo">
       <querytext>
                delete
                  from coimtpdo
                 where cod_tpdo = :cod_tpdo
       </querytext>
    </partialquery>

    <fullquery name="sel_tpdo">
       <querytext>
             select cod_tpdo
                  , descrizione as descr_tpdo
                  , flag_modifica
               from coimtpdo
              where cod_tpdo = :cod_tpdo
       </querytext>
    </fullquery>

    <fullquery name="check_desc">
       <querytext>
            select '1' 
              from coimtpdo
             where descrizione = :descr_tpdo
	     $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_cod">
        <querytext>
           select nextval('coimtpdo_s') as cod_tpdo
       </querytext>
    </fullquery>

</queryset>
