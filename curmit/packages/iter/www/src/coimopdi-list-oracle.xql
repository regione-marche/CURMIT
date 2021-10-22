<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_opdi">
       <querytext>
select cod_opve
     , iter_edit.num(prog_disp, 0) as prog_disp_edit
     , prog_disp
     , ora_da
     , ora_a
  from coimopdi
 where 1 = 1
   and cod_opve = :cod_opve
$where_last
order by prog_disp
       </querytext>
    </partialquery>

    <fullquery name="sel_opve_nome">
       <querytext>
                 select b.ragione_01||' '||nvl(b.ragione_02,'') as nome_enve
                      , nvl(a.cognome,'')||' '||nvl(a.nome,'') as nome_opve
                   from coimopve a
                      , coimenve b
                  where a.cod_opve = :cod_opve
                    and b.cod_enve = a.cod_enve
       </querytext>
    </fullquery>


</queryset>
