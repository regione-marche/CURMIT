<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_dimp">
       <querytext>
    select *
      from (
           select /* FIRST_ROWS */
                  a.data_ins
                , iter_edit.data(a.data_ins)             as data_ins_edit
                , a.data_controllo
                , iter_edit.data(a.data_controllo)       as data_controllo_edit
                , b.cod_impianto_est
                , nvl(c.cognome,' ')||' '||
                  nvl(c.nome,' ')                        as resp
                , d.denominazione                        as comune
                , nvl($nome_col_toponimo,'')||' '||
                  nvl($nome_col_via,'')||
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
                , coimaimp b
                , coimcitt c
                , coimcomu d
            $from_coimviae
            where b.cod_impianto     = a.cod_impianto
              and c.cod_cittadino (+)= b.cod_responsabile
              and d.cod_comune    (+)= b.cod_comune
           $where_coimviae

           $where_manu
           $where_data_ins
           $where_data_controllo
           $where_last
        $order_by
           )
     where rownum <= $rows_per_page
       </querytext>
    </partialquery>

    <fullquery name="sel_dimp_count">
       <querytext>
           select iter_edit.num(count(*),0)
             from coimdimp a
                , coimaimp b
            where b.cod_impianto = a.cod_impianto
           $where_manu
           $where_data_ins
           $where_data_controllo
       </querytext>
    </fullquery>

</queryset>
