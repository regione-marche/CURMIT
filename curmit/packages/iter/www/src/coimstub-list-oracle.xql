<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_stub">
       <querytext>
select iter_edit.data(a.data_fin_valid) as data_fin_valid_edit
      ,data_fin_valid
      , nvl(b.descr_topo, '')
       ||' '||nvl(b.descrizione, '') 
       || decode (nvl(a.numero , '')
          , '', ''
          , ' N.'||' '||a.numero
          )
       || decode (a.esponente 
          , null, ''
          , '/'||' '||a.esponente
          ) 
       || decode (a.scala
          , null, ''
          , ' scala: '||a.scala
          )
       || decode (a.piano
          , null, ''
          , ' piano: '||a.piano
          )
       || decode (a.interno
          , null , ''
          , ' interno: '||a.interno
          )
       || decode (a.localita
          , null, ''
          , ' Località: '||a.localita
          )
       || decode (a.cap
          , null, ''
          , ' CAP: '||a.cap
          )
       || decode (c.denominazione
          , null, ''
          , ' Comune: '||c.denominazione
          )
       || decode (d.sigla
          , null, ''
          , ' ('||d.sigla||')'
          ) as localita
     , decode (g.descr_tpdu
          , null, ''
          , ' Tipo utilizz.: '||g.descr_tpdu
          ) as cod_urb
  from coimstub a
     , coimviae b
     , coimcomu c
     , coimprov d
     , coimcqua e
     , coimcurb f
     , coimtpdu g
 where 1 = 1
   and cod_impianto = :cod_impianto
$where_last
   and b.cod_via       (+) = a.cod_via
   and c.cod_comune    (+) = a.cod_comune
   and d.cod_provincia (+) = a.cod_provincia
   and g.cod_tpdu      (+) = a.cod_tpdu        
order by data_fin_valid desc
       </querytext>
    </partialquery>

    <partialquery name="del_stub">
       <querytext>
                delete
                  from coimstub
                 where cod_impianto   = :cod_impianto
                   and data_fin_valid = :data_canc
       </querytext>
    </partialquery>

</queryset>
