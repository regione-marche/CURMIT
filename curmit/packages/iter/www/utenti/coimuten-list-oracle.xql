<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_uten">
       <querytext>
select id_utente as cod_utente
     , cognome
     , nome
     , id_settore
     , id_ruolo
     , iter_edit.num(livello, 0) as livello_edit
  from coimuten
 where 1 = 1
$where_last
$where_word
order by cognome, nome, id_utente
       </querytext>
    </partialquery>

    <fullquery name="select_profilo_utente">
      <querytext>
	select id_settore
	       , id_ruolo
	from coimuten
	where id_utente = :id_utente
      </querytext>
    </fullquery>

</queryset>
