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
            where cod_manutentore = :f_cod_manu
       </querytext>
    </fullquery>

    <partialquery name="sel_codici_manu">
       <querytext>
           select distinct(a.cod_manutentore) as f_cod_manu
             from coimdimp a
       inner join coimaimp b on b.cod_impianto  = a.cod_impianto
              and a.cod_docu_distinta is null
              and b.stato = 'A' 
              and a.utente_ins = :id_utente
         order by a.cod_manutentore
       </querytext>
    </partialquery>

    <partialquery name="sel_dimp">
       <querytext>
           select a.cod_dimp
                , a.cod_impianto
                , iter_edit_data(a.data_controllo)       as data_controllo_edit
                , b.cod_impianto_est
                , iter_edit_data(a.data_ins)             as data_ins_edit
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
           where a.cod_manutentore = :f_cod_manu
           $where_prescr
              and a.cod_docu_distinta is null
              and b.stato = 'A' 
              and a.utente_ins = :id_utente
         order by a.data_controllo
                , b.cod_comune
                , b.cod_impianto_est
       </querytext>
    </partialquery>

    <fullquery name="sel_docu_s">
       <querytext>
           select nextval('coimdocu_s')
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
                 , contenuto      = lo_import(:contenuto_tmpfile)
             where cod_documento  = :cod_documento
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
