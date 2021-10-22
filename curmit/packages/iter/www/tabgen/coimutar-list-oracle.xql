<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_utar">
       <querytext>
select a.cod_area
     , a.id_utente
     , Nvl(b.cognome, '') ||' '|| Nvl(b.nome, '') as utente
     , b.cognome
     , b.livello
     , c.descrizione  as ruolo
     , d.descrizione  as settore
  from coimutar a 
     , coimuten b
     , coimruol c
     , coimsett d
 where 1 = 1
   and a.cod_area   = :cod_area
   and b.id_utente  (+) = a.id_utente 
   and d.id_settore (+) = b.id_settore
   and c.id_ruolo   (+) = b.id_ruolo
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
