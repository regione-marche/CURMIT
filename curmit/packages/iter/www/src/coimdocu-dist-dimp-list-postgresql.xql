<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_uten">
       <querytext>
           select cognome   as uten_cognome
                , nome      as uten_nome
             from coimuten
            where id_utente = :id_utente
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
           select cognome   as manu_cognome
                , nome      as manu_nome
             from coimmanu
            where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

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
                , a.riferimento_pag
                , iter_edit_num(a.costo, 2) as costo
                , p.descr_potenza
             from coimdimp a
       inner join coimaimp b on b.cod_impianto  = a.cod_impianto
  left outer join coimcitt c on c.cod_cittadino = b.cod_responsabile
  left outer join coimcomu d on d.cod_comune    = b.cod_comune
  left outer join coimpote p on p.cod_potenza   = b.cod_potenza
            $from_coimviae
           $where_coimviae
           $where_utente
              and a.cod_docu_distinta is null
              and b.stato = 'A'
         order by b.cod_comune
                , a.data_controllo
                , b.cod_impianto_est
       </querytext>
    </partialquery>

</queryset>
