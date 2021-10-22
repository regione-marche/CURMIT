<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_cind_2">
       <querytext>
             select stato
               from coimcind
              where cod_cind = :cod_cind
       </querytext>
    </fullquery>

    <fullquery name="sel_cind">
       <querytext>
             select cod_cind
                  , descrizione
                  , iter_edit_data(data_inizio) as data_inizio
                  , iter_edit_data(data_fine) as data_fine
                  , stato
                  , note
                  , iter_edit_num(controlli_prev,0) as controlli_prev
               from coimcind
              where cod_cind = :cod_cind
       </querytext>
    </fullquery>

    <fullquery name="sel_desc">
       <querytext>
                  select 1 
                    from coimcind
                   where upper(descrizione) = upper(:descrizione)
                  $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_dual_cod">
       <querytext>
          select nextval('coimcind_s') as cod_cind
       </querytext>
    </fullquery>

    <partialquery name="ins_cind">
       <querytext>
                insert
                  into coimcind 
                     ( cod_cind
                     , stato
                     , descrizione
                     , data_inizio
                     , data_fine
                     , note
                     , controlli_prev)
                values
                     (:cod_cind
                     ,:stato
                     ,:descrizione
                     ,:data_inizio
                     ,:data_fine
                     ,:note
                     ,:controlli_prev)
       </querytext>
    </partialquery>

    <partialquery name="mod_cind">
       <querytext>
                update coimcind
                   set descrizione    = :descrizione
                     , stato          = :stato
                     , data_inizio    = :data_inizio
                     , data_fine      = :data_fine
                     , note           = :note
                     , controlli_prev = :controlli_prev
                 where cod_cind       = :cod_cind
       </querytext>
    </partialquery>

    <partialquery name="del_cind">
       <querytext>
                delete
                  from coimcind
                 where cod_cind = :cod_cind
       </querytext>
    </partialquery>

    <fullquery name="sel_cind_count">
       <querytext>
                select count(*) as conta
                  from coimcind
                 where stato = '1'
                $where_cod
       </querytext>
    </fullquery>

</queryset>
