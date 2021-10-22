<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_desc_comu">
       <querytext>
           select denominazione as desc_comune
             from coimcomu
            where cod_comune = :f_cod_comune
       </querytext>
    </fullquery>


    <fullquery name="sel_stat_opve">
       <querytext>
select distinct nvl(c.cognome,'')|| ' '||nvl(c.nome,' ') as nome_opve
,g.ragione_01 as nome_ente
,f.descr_potenza as fascia_potenza
,e.descr_comb as combustibile
,d.denominazione as comune
,b.cod_impianto_est
,a.verb_n
,a.cod_cimp
,count(distinct(a.cod_cimp)) as n_verifiche
,case when a.esito_verifica = 'P' then count(distinct(a.cod_cimp)) end as n_verifiche_pos 
,case when a.esito_verifica = 'N' then count(distinct(a.cod_cimp)) end as n_verifiche_neg
from coimcimp a
,coimaimp b 
,coimcomu d
,coimopve c
,coimcomb e
,coimpote f
,coimenve g
,coiminco i
where b.cod_impianto(+)=a.cod_impianto
and i.cod_inco(+)=a.cod_inco
and d.cod_comune(+)=b.cod_comune
and c.cod_opve(+)=a.cod_opve
and e.cod_combustibile(+)=b.cod_combustibile
and f.cod_potenza(+)=b.cod_potenza
and g.cod_enve(+)=c.cod_enve
and a.flag_tracciato!='MA'
$where_opve
$where_data
$where_cod_potenza
$where_comune
$where_combustibile
group by c.cognome
,c.nome
,d.denominazione
,f.descr_potenza
,e.descr_comb
,b.cod_impianto_est
,a.verb_n
,a.cod_cimp
,a.esito_verifica
,g.ragione_01
</querytext>
</fullquery>

    <fullquery name="estrai_data">
       <querytext>
       select iter_edit.data(sysdate) as data_time
         from dual
       </querytext>
    </fullquery>

    <fullquery name="edit_date_dual">
       <querytext>
        select iter_edit.data(:f_data_da) as data_da_e
             , iter_edit.data(:f_data_a) as data_a_e
	  from dual
       </querytext>
    </fullquery>

    <fullquery  name="count_all">
      <querytext>
        select count(*) as n_verifiche 
           from   coimcimp a
		, coimaimp b 
		, coimcomu d
		, coimopve c
		, coimcomb e
		, coimpote f
           where b.cod_impianto (+)= a.cod_impianto
             and d.cod_comune (+)= b.cod_comune
             and c.cod_opve (+)= a.cod_opve
             and e.cod_combustibile (+)= b.cod_combustibile
	     and f.cod_potenza (+)= b.cod_potenza
	     
	     and a.cod_opve = :cod_opve
	     and b.cod_potenza = :cod_potenza
	     and b.cod_comune = :cod_comune
	     and b.cod_combustibile = :cod_combustibile
      </querytext>
    </fullquery>

    <fullquery  name="count_pos">
      <querytext>
        select count(*) as n_verifiche_pos 
           from   coimcimp a
		, coimaimp b 
		, coimcomu d
		, coimopve c
		, coimcomb e
		, coimpote f
           where b.cod_impianto (+)= a.cod_impianto
             and d.cod_comune (+)= b.cod_comune
             and c.cod_opve (+)= a.cod_opve
             and e.cod_combustibile (+)= b.cod_combustibile
	     and f.cod_potenza (+)= b.cod_potenza

	     and a.cod_opve = :cod_opve
	     and b.cod_potenza = :cod_potenza
	     and b.cod_comune = :cod_comune
	     and b.cod_combustibile = :cod_combustibile
	     and a.esito_verifica = 'P'
      </querytext>
    </fullquery>

    <fullquery  name="count_neg">
      <querytext>
        select count(*) as n_verifiche_neg 
           from   coimcimp a
		, coimaimp b 
		, coimcomu d
		, coimopve c
		, coimcomb e
		, coimpote f
           where b.cod_impianto (+)= a.cod_impianto
             and d.cod_comune (+)= b.cod_comune
             and c.cod_opve (+)= a.cod_opve
             and e.cod_combustibile (+)= b.cod_combustibile
	     and f.cod_potenza (+)= b.cod_potenza

	     and a.cod_opve = :cod_opve
	     and b.cod_potenza = :cod_potenza
	     and b.cod_comune = :cod_comune
	     and b.cod_combustibile = :cod_combustibile
	     and a.esito_verifica = 'N'
      </querytext>
    </fullquery>

    <fullquery  name="sel_anom">
<querytext>
        select j.cod_tanom
           from  coimanom j
	   where cod_cimp_dimp = :cod_cimp
	   and flag_origine = 'RV'
      </querytext>
    </fullquery>

    <fullquery name="sel_anom_opve">
       <querytext>
select nvl(c.cognome,'')|| ' '||nvl(c.nome,' ') as nome_opve  
,g.ragione_01 as nome_ente
,f.descr_potenza as fascia_potenza
,e.descr_comb as combustibile
,d.denominazione as comune
,nvl(p.cod_tanom,'')|| ' - '||nvl(s.descr_tano,'') as descr_anomalia
,count(*) as count_anomalie
from coimanom p
,coimaimp b 
,coimcomu d
,coimopve c
,coimcomb e
,coimpote f
,coimenve g
,coiminco i
,coimtano s
,coimcimp a
where b.cod_impianto (+)= a.cod_impianto
and i.cod_inco (+)= a.cod_inco
and p.flag_origine = 'RV'
and d.cod_comune (+)= b.cod_comune
and c.cod_opve (+)= a.cod_opve
and e.cod_combustibile (+)= b.cod_combustibile
and f.cod_potenza (+)= b.cod_potenza
and g.cod_enve (+)= c.cod_enve
and s.cod_tano (+)= p.cod_tanom
and a.cod_cimp (+)= p.cod_cimp_dimp
$where_opve
$where_data
$where_cod_potenza
$where_comune
$where_combustibile
group by p.cod_tanom
,s.descr_tano	
,c.cognome
,c.nome
,d.denominazione
,f.descr_potenza
,e.descr_comb
,g.ragione_01
</querytext>
</fullquery>



</queryset>
