<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_dimp">
       <querytext>
select a.cod_dimp
     , iter_edit.data(a.data_controllo) as data_controllo_edit
     , a.data_controllo 
     , a.cod_manutentore
     , decode (a.flag_status 
          ,'P','Positivo'
          ,'N','Negativo'
          ,''
       ) as flag_status
     , b.cognome||' '||nvl(b.nome,'') as desc_manutentore
     , c.cognome||' '||nvl(c.nome,'') as desc_responsabile
     , a.flag_tracciato
     , case a.flag_tracciato
          when 'H'  then 'Mod. H'
          when 'HB' then 'Mod. H bis'
          when 'G'  then 'Mod. G'
          when 'F'  then 'Mod. F'
          else ''
       end as flag_tracciato_edit
  from coimdimp a
     , coimmanu b
     , coimcitt c
 where 1 = 1
   and b.cod_manutentore (+)= a.cod_manutentore
   and c.cod_cittadino   (+)= a.cod_responsabile
$where_aimp
$where_last
$where_word
order by data_controllo, cod_dimp
       </querytext>
    </partialquery>

    <partialquery name="sel_aimp_potenza">
       <querytext>
          select potenza
            from coimaimp 
           where cod_impianto = :cod_impianto
       </querytext>
    </partialquery>


</queryset>
