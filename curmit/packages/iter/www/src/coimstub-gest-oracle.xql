<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>


    <partialquery name="del_stub">
       <querytext>
                delete
                  from coimstub
                 where cod_impianto   = :cod_impianto
                   and data_fin_valid = :data_fin_valid
       </querytext>
    </partialquery>


    <fullquery name="sel_stub">
       <querytext>
select iter_edit.data(a.data_fin_valid) as data_fin_valid_edit
     , a.data_fin_valid
     , nvl(b.descr_topo, '')
       ||' '||nvl(b.descrizione, '') 
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
     , case when e.descrizione is null
          then ''
          else 'Quart.: '||e.descrizione
          end
       || case when f.descrizione is null
          then ''
          else ' Area urb.: '||f.descrizione
          end
       || case when g.descr_tpdu is null
          then ''
          else ' Tipo utilizz.: '||g.descr_tpdu
          end
          as cod_urb
  from coimstub a
     , coimviae b 
     , coimcomu c
     , coimprov d 
     , coimcqua e
     , coimcurb f
     , coimtpdu g          
 where a.cod_impianto      = :cod_impianto
   and data_fin_valid      = :data_fin_valid
   and b.cod_via       (+) = a.cod_via
   and c.cod_comune    (+) = a.cod_comune
   and d.cod_provincia (+) = a.cod_provincia
   and d.cod_provincia (+) = a.cod_provincia
   and e.cod_qua       (+) = a.cod_qua
   and e.cod_comune    (+) = a.cod_comune
   and f.cod_urb       (+) = a.cod_urb
   and f.cod_comune    (+) = a.cod_comune
   and g.cod_tpdu      (+) = a.cod_tpdu  
       </querytext>
    </fullquery>

</queryset>
