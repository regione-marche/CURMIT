<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

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
           select a.cod_dimp
                , a.cod_impianto
                , a.data_ins
                , iter_edit.data(a.data_ins)             as data_ins_edit
                , a.data_controllo
                , iter_edit.data(a.data_controllo)       as data_controllo_edit
                , b.cod_impianto_est
                , nvl(c.cognome,' ')||' '||
                  nvl(c.nome,' ')                   as resp
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
                , a.riferimento_pag
             from coimdimp a
                , coimaimp b
                , coimcitt c
                , coimcomu d
            $from_coimviae
           $where_utente
              and a.cod_docu_distinta is null
              and b.cod_impianto     = a.cod_impianto
              and c.cod_cittadino (+)= b.cod_responsabile
              and d.cod_comune    (+)= b.cod_comune
           $where_coimviae
         order by a.data_controllo
                , b.cod_impianto_est
       </querytext>
    </partialquery>

    <fullquery name="sel_docu_s">
       <querytext>
           select coimdocu_s.nextval
             from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_docu">
       <querytext>
           insert
             into coimdocu 
                ( cod_documento
                , cod_soggetto
                , tipo_soggetto
                , tipo_documento
                , cod_impianto
                , data_stampa
                , data_documento
                , data_ins
                , data_mod
                , utente)
           values 
                (:cod_documento
                ,:cod_soggetto
                ,:tipo_soggetto
                ,:tipo_documento
                ,:cod_impianto
                ,:data_stampa
                ,:data_documento
                ,:data_ins
                ,:data_mod
                ,:utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_docu_ins_dist">
       <querytext>
           update coimdocu
              set tipo_contenuto = :tipo_contenuto
                , contenuto      = empty_blob()
            where cod_documento  = :cod_documento
        returning contenuto
             into :1
       </querytext>
    </partialquery> 

    <partialquery name="upd_dimp">
       <querytext>
            update coimdimp
               set cod_docu_distinta = :cod_docu_distinta
             where cod_dimp          = :cod_dimp
       </querytext>
    </partialquery> 

</queryset>
