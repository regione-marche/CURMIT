<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_cuar">
       <querytext>
select a.cod_area
     , a.cod_urb
     , coalesce (b.descrizione, '')  as descrizione 
     , b.cod_comune
     , c.denominazione  as comune
  from coimcuar a 
  left outer join coimcurb b on b.cod_urb = a.cod_urb
  left outer join coimcomu c on c.cod_comune  = a.cod_comune 
 where 1 = 1
   and a.cod_area = :cod_area
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
