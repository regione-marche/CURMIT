<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_dimp">
       <querytext>
           select a.data_ins
                , iter_edit_data(a.data_ins)             as data_ins_edit
                , a.data_controllo
                , iter_edit_data(a.data_controllo)       as data_controllo_edit
                , b.cod_impianto_est
                , coalesce(c.cognome,' ')||' '||
                  coalesce(c.nome,' ')                   as resp
                , d.denominazione                        as comune
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
             from coimdimp a
       inner join coimaimp b on b.cod_impianto  = a.cod_impianto
  left outer join coimcitt c on c.cod_cittadino = b.cod_responsabile
  left outer join coimcomu d on d.cod_comune    = b.cod_comune
            $from_coimviae
           $where_coimviae
            where 1 = 1
           $where_manu
           $where_data_ins
           $where_data_controllo
           $where_last
        $order_by
            limit $rows_per_page
       </querytext>
    </partialquery>

    <fullquery name="sel_dimp_count">
       <querytext>
           select iter_edit_num(count(*),0)
             from coimdimp a
       inner join coimaimp b on b.cod_impianto  = a.cod_impianto
            where 1 = 1
           $where_manu
           $where_data_ins
           $where_data_controllo
       </querytext>
    </fullquery>

</queryset>
