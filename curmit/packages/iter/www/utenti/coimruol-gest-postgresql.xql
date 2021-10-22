<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_ruol">
       <querytext>
                insert
                  into coimruol 
                     ( id_ruolo
                     , descrizione)
                values 
                     (:id_ruolo
                     ,:descrizione)
       </querytext>
    </partialquery>

    <partialquery name="upd_ruol">
       <querytext>
                update coimruol
                   set descrizione = :descrizione
                 where id_ruolo = :id_ruolo
       </querytext>
    </partialquery>

    <partialquery name="del_ruol">
       <querytext>
                delete
                  from coimruol
                 where id_ruolo = :id_ruolo
       </querytext>
    </partialquery>

    <fullquery name="sel_ruol">
       <querytext>
             select id_ruolo
                  , descrizione
               from coimruol
              where id_ruolo = :id_ruolo
       </querytext>
    </fullquery>

    <fullquery name="sel_ruol_check">
       <querytext>
        select '1'
          from coimruol
         where upper(id_ruolo) = upper(:id_ruolo)
       </querytext>
    </fullquery>

    <fullquery name="check_descrizione">
       <querytext>
             select '1'
               from coimruol
              where upper(descrizione) = upper(:descrizione)
              $where_cod
       </querytext>
    </fullquery>

</queryset>
