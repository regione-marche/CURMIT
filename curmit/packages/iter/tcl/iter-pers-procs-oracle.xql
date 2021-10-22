<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="iter_calc_media.sel_dual_round">
       <querytext>
           select round(:risultato,:num_decimali)
             from dual
       </querytext>
    </fullquery>

    <fullquery name="iter_selbox_from_table_wherec.sel_lol_2">
       <querytext>
                    select $key_description
                         , $table_key
                      from $table_name a
                      $where_condition
                     order by a.$key_orderby
       </querytext>
    </fullquery>

    <fullquery name="iter_get_coimuten.sel_uten">
       <querytext>
           select id_utente
                , cognome
                , nome
                , password
                , id_settore
                , id_ruolo
                , lingua
                , e_mail
                , rows_per_page
                , data
                , livello
             from coimuten
            where id_utente = :id_utente
       </querytext>
    </fullquery>


</queryset>
