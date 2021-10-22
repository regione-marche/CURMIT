<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_utar">
       <querytext>
select a.cod_area
     , a.id_utente
     , coalesce (b.cognome, '') ||' '|| coalesce (b.nome, '') as utente
     , b.cognome
     , b.livello
     , c.descrizione  as ruolo
     , d.descrizione  as settore
  from coimutar a left outer join
       coimuten b
    on b.id_utente = a.id_utente 
                  left outer join
       coimruol c
    on c.id_ruolo  = b.id_ruolo
                  left outer join
       coimsett d
    on d.id_settore = b.id_settore
 where 1 = 1
   and a.cod_area = :cod_area
$where_last
$where_word
order by upper(b.cognome), upper(a.id_utente)
       </querytext>

    </partialquery>
    <partialquery name="del_utar">
       <querytext>
                delete
                  from coimutar
                 where cod_area  = :cod_area
                   and id_utente = :uten_canc
       </querytext>
    </partialquery>

</queryset>
