<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_user_login">
       <querytext>
         select rtrim(id_utente) as id_utente
              , id_ruolo
              , id_settore
              , rows_per_page
              , password
              , data
           from coimuten
          where id_utente = [ns_dbquotevalue $utn_cde]  
       </querytext>
    </fullquery>

</queryset>
