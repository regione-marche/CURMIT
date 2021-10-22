<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_user_login">
       <querytext>
         select password
           from coimuten
          where id_utente = :utn_cde  
            and id_settore = 'distributore'
       </querytext>
    </fullquery>

</queryset>
