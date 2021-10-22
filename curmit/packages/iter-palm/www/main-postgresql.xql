<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

     <fullquery name="sel_dual_anno">
       <querytext>
                  select to_char(current_date, 'yyyy') as anno
       </querytext>
    </fullquery>

    <fullquery name="sel_user">
       <querytext>
                    select nome
                         , cognome
                         , id_settore
                         , id_ruolo
                      from coimuten
                     where id_utente = :id_utente
       </querytext>
    </fullquery>

</queryset>
