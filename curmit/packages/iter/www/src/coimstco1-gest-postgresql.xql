<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_count_dimp">
       <querytext>
           select coalesce(b.id_settore,'system') as id_settore
                , coalesce(trim(coalesce(b.nome,'')||' '||coalesce(b.cognome,'')),'system') as nome_soggetto
                , count(*) as num_dimp
             from coimdimp a
  left outer join coimuten b on b.id_utente    = a.utente_ins
       inner join coimaimp c on c.cod_impianto = a.cod_impianto
                            and c.stato <> 'N'
            where 1 = 1
           $where_da_data
           $where_a_data
           $where_cind
	   $where_id_utente
         group by id_settore
                , nome_soggetto
         order by id_settore
                , nome_soggetto
       </querytext>
    </fullquery>

    <fullquery name="sel_count_aimp">
       <querytext>
           select count(*) as num_aimp
             from coimaimp
            where stato = 'A'
       </querytext>
    </fullquery>

    <fullquery name="sel_count_nove">
       <querytext>
           select count(*) as num_nove
             from coimnove
       </querytext>
    </fullquery>

</queryset>
