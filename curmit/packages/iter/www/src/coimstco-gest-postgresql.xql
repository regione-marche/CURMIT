<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_count_dimp">
       <querytext>
          select coalesce(b.id_settore,'system') as id_settore
       , coalesce(trim(coalesce(b.nome,'')||' '||coalesce(b.cognome,'')),'system') as nome_soggetto
       , count(*) as num_dimp
       , sum(case when c.flag_tipo_impianto = 'R' then 1 else 0 end) as num_dimp_risc
       , sum(case when c.flag_tipo_impianto = 'F' then 1 else 0 end) as num_dimp_raff
       , sum(case when c.flag_tipo_impianto = 'C' then 1 else 0 end) as num_dimp_coge
       , sum(case when c.flag_tipo_impianto = 'T' then 1 else 0 end) as num_dimp_tele
       , sum(case when c.flag_tipo_impianto not in ('R','F','C','T') then 1 else 0 end) as num_dimp_nonn
   from coimdimp a
  left join coimuten b on b.id_utente    = a.utente_ins
 inner join coimaimp c on c.cod_impianto = a.cod_impianto and stato = 'A'
                                where 1 = 1 
           $where_da_data
           $where_a_data
           $where_tipo_imp
	   $where_id_utente
         group by c.flag_tipo_impianto
                , id_settore
                , nome_soggetto
         order by c.flag_tipo_impianto
                 ,id_settore
                , nome_soggetto
       </querytext>
    </fullquery>

    <fullquery name="sel_count_dimp_doc">
       <querytext>
          select count(*)  as num_dimp_doc
   from coimdimp a
  left join coimuten b on b.id_utente    = a.utente_ins
 inner join coimaimp c on c.cod_impianto = a.cod_impianto and stato = 'A'
                                where 1 = 1 and a.cod_manutentore is null
           $where_da_data
           $where_a_data
           $where_tipo_imp
	   $where_id_utente
         
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
             from coimnoveb
       </querytext>
    </fullquery>

</queryset>
