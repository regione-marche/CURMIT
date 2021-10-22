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
     , d.cognome||' '||coalesce(d.nome,'') as desc_proprietario
     , case
        when a.cod_manutentore is null
         then iter_edit_num(sum(e.potenza), 2)
        else iter_edit_num(a.potenza, 2)
       end as potenza
  from coim_as_resp a
  left outer join  coimmanu b on b.cod_manutentore = a.cod_manutentore
  left outer join  coimgend_as_resp e on e.cod_as_resp = a.cod_as_resp
  left outer join  coimcitt c on c.cod_cittadino   = a.cod_legale_rapp
  left outer join  coimcitt d on d.cod_cittadino   = a.cod_responsabile
 where 1 = 1
$where_aimp
$where_last
$where_word
$where_cogn
$where_nome
$where_inizio
$where_fine
group by a.cod_as_resp, a.data_inizio, a.data_fine, a.cod_manutentore, desc_manutentore, desc_responsabile, desc_proprietario, a.potenza
order by a.data_inizio, a.data_fine
       </querytext>
    </partialquery>

</queryset>
