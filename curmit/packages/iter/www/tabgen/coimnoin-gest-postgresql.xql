<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="del_noin">
       <querytext>
                   delete
                     from coimnoin
                    where cod_noin = :cod_noin
       </querytext>
    </partialquery>

    <partialquery name="upd_noin">
       <querytext>
                   update coimnoin
                      set descr_noin = :descr_noin,
                          data_fine_valid = :data_fine_valid
                    where cod_noin   = :cod_noin
       </querytext>
    </partialquery>

    <partialquery name="ins_noin">
       <querytext>
                   insert
                     into coimnoin 
                        ( cod_noin
                        , descr_noin
                        , data_fine_valid)
                   values 
                        (:cod_noin
                        ,:descr_noin
                        ,:data_fine_valid)
       </querytext>
    </partialquery>

     <fullquery name="sel_check_noin_2">
       <querytext>
                    select '1'
                      from coimnoin
                     where cod_noin = :cod_noin
       </querytext>
    </fullquery>

    <fullquery name="sel_check_noin_1">
       <querytext>
                    select '1'
                      from coimnoin
                     where upper(descr_noin) = upper(:descr_noin)
                    $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_noin">
       <querytext>
                    select cod_noin
                         , descr_noin
                         , iter_edit_data(data_fine_valid) as data_fine_valid
                      from coimnoin
                     where cod_noin = :cod_noin
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_check">
       <querytext>
        select '1'
          from coiminco
         where cod_noin = :cod_noin
        limit 1
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_check">
       <querytext>
        select '1'
          from coimcimp
         where cod_noin = :cod_noin
        limit 1
       </querytext>
    </fullquery>


</queryset>
