<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_sett">
       <querytext>
select id_settore
     , descrizione
  from coimsett
 where 1 = 1
$where_last
$where_word
order by descrizione
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
