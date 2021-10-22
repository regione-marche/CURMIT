<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="del_imst">
       <querytext>
                   delete
                     from coimimst
                    where cod_imst = :cod_imst
       </querytext>
    </partialquery>

    <partialquery name="upd_imst">
       <querytext>
                   update coimimst
                      set descr_imst = :descr_imst
                        , fl_imst    = :fl_imst
                    where cod_imst   = :cod_imst
       </querytext>
    </partialquery>

    <partialquery name="ins_imst">
       <querytext>
                   insert
                     into coimimst 
                        ( cod_imst
                        , descr_imst
                        , fl_imst)
                   values 
                        (:cod_imst
                        ,:descr_imst
                        ,:fl_imst)
       </querytext>
    </partialquery>

     <fullquery name="sel_check_imst_2">
       <querytext>
                    select '1'
                      from coimimst
                     where cod_imst = :cod_imst
       </querytext>
    </fullquery>

    <fullquery name="sel_check_imst_1">
       <querytext>
                    select '1'
                      from coimimst
                     where upper(descr_imst) = upper(:descr_imst)
                    $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_imst">
       <querytext>
                    select cod_imst
                         , descr_imst
                         , fl_imst
                      from coimimst
                     where cod_imst = :cod_imst
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_check">
       <querytext>
        select '1'
          from coimaimp
         where stato = :cod_imst
        limit 1
       </querytext>
    </fullquery>

    <fullquery name="sel_fl_imst">
       <querytext>
        select '1'
          from coimimst
         where fl_imst = 'S'
       </querytext>
    </fullquery>

</queryset>
