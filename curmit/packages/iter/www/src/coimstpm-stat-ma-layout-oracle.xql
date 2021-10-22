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

    <fullquery name="sel_stat_ma">
       <querytext>
select to_char(a.data_controllo, 'dd/mm/yyyy') as data_controllo_edit
   , a.data_controllo as data_controllo
, a.cod_cimp as codice_ma
, b.cod_impianto_est as cod_impianto_est
, nvl(d.descr_topo,'')||' '||nvl(d.descrizione,'')||
  case  when b.numero is null then ''
  else ', '||b.numero  end ||
  case  when b.esponente is null then ''
  else '/'||b.esponente  end ||
  case  when b.scala is null then ''
  else ' S.'||b.scala  end ||
  case  when b.piano is null then ''
  else ' P.'||b.piano  end ||
  case  when b.interno is null then ''
  else ' In.'||b.interno
  end	 as indirizzo
, c.denominazione as comune
, nvl (e.cognome,'')|| ' ' ||nvl(e.nome,' ') as nome_resp	
, a.note_mancata_verifica as note
from coimcimp a
,coimaimp b,coimviae d,coimcomu c,coimcitt e
where b.cod_impianto (+)= a.cod_impianto
and d.cod_via (+)= b.cod_via
and c.cod_comune (+)= b.cod_comune
and e.cod_cittadino (+)= b.cod_responsabile
and a.flag_tracciato = 'MA'
$where_data
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
