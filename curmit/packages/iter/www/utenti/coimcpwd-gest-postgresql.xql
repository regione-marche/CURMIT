<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="upd_uten">
       <querytext>
            update coimuten
               set e_mail         = :utn_eml
                 , rows_per_page  = :utn_rgh
                 , data           = current_date
              $set_utn_psw
             where id_utente = :id_utente
       </querytext>
    </partialquery>

    <fullquery name="get_current_values">
       <querytext>
        select password as utn_psw
             , e_mail
             , rows_per_page
          from coimuten
         where id_utente = :id_utente
       </querytext>
    </fullquery>

    <fullquery name="get_psw">
       <querytext>
      select password as db_psw
        from coimuten
       where id_utente = :id_utente
       </querytext>
    </fullquery>

</queryset>
