<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_cuar">
       <querytext>
select a.cod_area
     , a.cod_urb
     , Nvl (b.descrizione, '')  as descrizione 
     , b.cod_comune
     , c.denominazione  as comune
  from coimcuar a 
     , coimcurb b 
     , coimcomu c  
 where 1 = 1
   and a.cod_area       = :cod_area
   and b.cod_urb (+)    = a.cod_urb
   and c.cod_comune (+) = a.cod_comune
$where_last
$where_word
order by upper(b.descrizione), a.cod_urb
       </querytext>
    </partialquery>

    <partialquery name="del_cuar">
       <querytext>
                delete
                  from coimcuar
                 where cod_area  = :cod_area
                   and cod_urb   = :urb_canc
       </querytext>
    </partialquery>

</queryset>
