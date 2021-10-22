<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_stub">
       <querytext>
select iter_edit_data(a.data_fin_valid) as data_fin_valid_edit
     , a.data_fin_valid
     , coalesce(b.descr_topo, '')
       ||' '||coalesce(b.descrizione, '') 
       || case when a.numero is null
          then ''
          else ' N.'||' '||a.numero
          end
       || case  when a.esponente is null
          then ''
          else '/'||' '||a.esponente
          end 
       || case when a.scala is null
          then ''
          else ' scala: '||a.scala
          end
       || case when a.piano is null
          then ''
          else ' piano: '||a.piano
          end
       || case when a.interno is null
          then ''
          else ' interno: '||a.interno
          end
       || case when a.localita is null
          then ''
          else ' Località: '||a.localita
          end
       || case when a.cap is null
          then ''
          else ' CAP: '||a.cap
          end
       || case when c.denominazione is null
          then ''
          else ' Comune: '||c.denominazione
          end
       || case when d.sigla is null
          then ''
          else ' ('||d.sigla||')'
          end
          as localita
       , case when g.descr_tpdu is null
          then ''
          else ' Tipo utilizz.: '||g.descr_tpdu
          end
          as cod_urb
  from coimstub a
       left outer join coimviae b on b.cod_via = a.cod_via
       left outer join coimcomu c on c.cod_comune = a.cod_comune
       left outer join coimprov d on d.cod_provincia = a.cod_provincia
       left outer join coimtpdu g on g.cod_tpdu = a.cod_tpdu                 
 where 1 = 1
   and a.cod_impianto = :cod_impianto
$where_last
order by data_fin_valid desc
       </querytext>
    </partialquery>

</queryset>
