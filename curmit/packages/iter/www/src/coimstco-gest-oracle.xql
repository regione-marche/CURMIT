<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_count_dimp">
       <querytext>
           select nvl(b.id_settore,'system') as id_settore
                , nvl(trim(nvl(b.nome,'')||' '||nvl(b.cognome,'')),'system')
               as nome_soggetto
                , count(*) as num_dimp
             from coimdimp a
                , coimuten b
                , coimaimp c
            where c.stato <> 'N'
           $where_da_data
           $where_a_data
	   $where_id_utente
              and b.id_utente (+) = a.utente
              and c.cod_impianto  = a.cod_impianto
         group by nvl(b.id_settore,'system')
                , nvl(trim(nvl(b.nome,'')||' '||nvl(b.cognome,'')),'system')
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
