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


    <fullquery name="sel_cimp_tar">
       <querytext>
       select   nvl(c.cognome,'')|| ' '||nvl(c.nome,' ') as nome_opve  
	 , g.ragione_01 as nome_ente
	 , count(*) as n_verifiche
	 , iter_edit.num(a.costo, 2) as costo
        from   coimcimp a
	, coimopve c
	, coimenve g
	, coiminco i
     where c.cod_opve (+)= a.cod_opve
     and g.cod_enve (+)= c.cod_enve
     and i.cod_inco (+)= a.cod_inco
     and i.stato = '8'
     $where_opve
     $where_data
     $where_costo
     group by   a.costo
              , c.cognome
	      , c.nome
	      , g.ragione_01
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
</queryset>
