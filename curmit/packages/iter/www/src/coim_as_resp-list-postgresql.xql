<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_as_resp">
       <querytext>
select a.cod_as_resp
     , iter_edit_data(a.data_inizio) as data_inizio_edit
     , iter_edit_data(a.data_fine) as data_fine_edit
     , a.cod_manutentore
     , b.cognome||' '||coalesce(b.nome,'') as desc_manutentore
     , c.cognome||' '||coalesce(c.nome,'') as desc_responsabile
     , a.flag_tracciato
  from coim_as_resp a
  left outer join  coimmanu b on b.cod_manutentore = a.cod_manutentore
  left outer join  coimcitt c on c.cod_cittadino   = a.cod_responsabile
 where 1 = 1
$where_aimp
$where_last
$where_word
order by a.data_inizio, a.data_fine
       </querytext>
    </partialquery>

</queryset>
