<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name= "sel_ente_reg">
       <querytext>
		select   denominazione_ente
		       , url_ente
		       , logo_ente
		from coimereg
		order by ordinamento
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
