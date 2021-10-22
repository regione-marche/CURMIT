<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_menu">
       <querytext>
select a.nome_menu
  from coimmenu a
       left outer join coimprof b on b.nome_menu = a.nome_menu
 where 1 = 1
$flag_regione
$where_last
group by a.nome_menu
order by a.nome_menu
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
