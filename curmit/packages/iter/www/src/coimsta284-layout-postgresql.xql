?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_tot_all">
       <querytext>
              select count(*) as tot_all
                from coimnoveb
               where (data_consegna between :f_data1 and :f_data2)
       </querytext>
    </fullquery>

    <partialquery name="sel_aimp">
       <querytext>
           select b.cod_impianto
                , a.data_consegna
                , d.denominazione as comune 
                , iter_edit_data(a.data_ricevuta)             as data_ricevuta_edit
                , iter_edit_data(a.data_consegna)             as data_consegna_edit
                 , coalesce($nome_col_toponimo,'')||' '||
                  coalesce($nome_col_via,'')||
                  case
                    when b.numero is null then ''
                    else ', '||b.numero
                  end ||
                  case
                    when b.esponente is null then ''
                    else '/'||b.esponente
                  end ||
                  case
                    when b.scala is null then ''
                    else ' S.'||b.scala
                  end ||
                  case
                    when b.piano is null then ''
                    else ' P.'||b.piano
                  end ||
                  case
                    when b.interno is null then ''
                    else ' In.'||b.interno
                  end                                    as indir
                  ,b.utente_ins   as utente
                  ,b.cod_impianto_est
                  ,coalesce(c.cognome,'') || ' ' || coalesce(c.nome,'') as manutentore
               from coimnoveb a
                    left outer join coimmanu c on c.cod_manutentore = a.cod_manutentore,
                    coimaimp b
  left outer join coimcomu d on d.cod_comune    = b.cod_comune
    left outer join coimviae e on e.cod_comune    = b.cod_comune and e.cod_via = b.cod_via
  where (a.data_consegna between :f_data1 and :f_data2) and a.cod_impianto = b.cod_impianto
  $where_cond
  $where_com
     order by b.cod_impianto_est
       </querytext>
    </partialquery>

    
</queryset>
