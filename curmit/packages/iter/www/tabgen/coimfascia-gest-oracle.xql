<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="del_topo">
       <querytext>
                   delete
                     from coimtopo
                    where cod_topo = :cod_topo
       </querytext>
    </partialquery>

    <partialquery name="upd_topo">
       <querytext>
                   update coimtopo
                      set descr_topo = :descr_topo
                    where cod_topo = :cod_topo
       </querytext>
    </partialquery>

    <partialquery name="ins_topo">
       <querytext>
                   insert
                     into coimtopo 
                        ( cod_topo
                        , descr_topo)
                   values 
                        (:cod_topo
                        ,:descr_topo)
       </querytext>
    </partialquery>

     <fullquery name="sel_check_topo_2">
       <querytext>
                    select '1'
                      from coimtopo
                     where cod_topo = :cod_topo
       </querytext>
    </fullquery>

    <fullquery name="sel_check_topo_1">
       <querytext>
                    select '1'
                      from coimtopo
                     where upper(descr_topo) = upper(:descr_topo)
                    $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_topo">
       <querytext>
                    select cod_topo
                         , descr_topo
                      from coimtopo
                     where cod_topo = :cod_topo
       </querytext>
    </fullquery>

</queryset>
