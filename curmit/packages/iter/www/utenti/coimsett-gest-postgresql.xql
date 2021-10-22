<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_sett">
       <querytext>
                insert
                  into coimsett 
                     ( id_settore
                     , descrizione
                     , responsabile)
                values 
                     (:id_settore
                     ,:descrizione
                     ,:responsabile)
       </querytext>
    </partialquery>

    <partialquery name="upd_sett">
       <querytext>
                update coimsett
                   set descrizione = :descrizione
                     , responsabile = :responsabile
                 where id_settore = :id_settore
       </querytext>
    </partialquery>

    <partialquery name="del_sett">
       <querytext>
                delete
                  from coimsett
                 where id_settore = :id_settore
       </querytext>
    </partialquery>

    <fullquery name="sel_sett">
       <querytext>
             select id_settore
                  , descrizione
                  , responsabile
               from coimsett
              where id_settore = :id_settore
       </querytext>
    </fullquery>

    <fullquery name="sel_sett_check">
       <querytext>
        select '1'
          from coimsett
         where upper(id_settore) = upper(:id_settore)
       </querytext>
    </fullquery>

    <fullquery name="check_settore">
       <querytext>
        select '1'
          from coimsett
         where upper(descrizione) = upper(:descrizione)
        $where_cod
       </querytext>
    </fullquery>

</queryset>
