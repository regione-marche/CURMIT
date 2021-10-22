<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>


     <fullquery name="sel_dual_anno">
       <querytext>
                  select to_char(sysdate, 'yyyy') as anno
                    from dual
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
