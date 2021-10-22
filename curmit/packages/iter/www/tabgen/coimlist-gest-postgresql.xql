<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_tari">
       <querytext>
                insert
                  into coimlist
                     ( cod_listino
                     , descrizione)
                values 
                     (:cod_listino
                     ,:descrizione)
       </querytext>
    </partialquery>

    <partialquery name="upd_tari">
       <querytext>
                update coimlist
                   set descrizione = :descrizione
                 where cod_listino = :cod_listino
       </querytext>
    </partialquery>

    <partialquery name="del_tari">
       <querytext>
                delete
                  from coimlist
                 where cod_listino = :cod_listino
       </querytext>
    </partialquery>

    <fullquery name="sel_tari">
       <querytext>
select cod_listino
     , descrizione
  from coimlist
 where cod_listino = :cod_listino
       </querytext>
    </fullquery>

    <fullquery name="sel_tari_check">
       <querytext>
        select '1'
          from coimlist
         where cod_listino = :cod_listino
       </querytext>
    </fullquery>

    <fullquery name="sel_list_check">
       <querytext>
        select '1'
          from coimtari
         where cod_listino = :cod_listino
        limit 1
       </querytext>
    </fullquery>

</queryset>
