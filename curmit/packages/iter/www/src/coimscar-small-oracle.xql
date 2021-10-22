<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_scar">
       <querytext>
          select a.cod_impianto_est as imp_numeroatto
               , c.nome             as imp_nomedich
               , c.cognome          as imp_cogndich
               , c.comune_nas       as imp_lnascdich
               , c.data_nas         as imp_dnascdich
               , c.comune           as imp_lresdich
               , c.cap              as imp_capresdich
               , c.indirizzo        as imp_viaresdich
               , c.numero           as imp_cresdich
               , c.telefono         as imp_teldich
               , c.cod_fiscale      as imp_cfiscdich
               , d.denominazione    as imp_comuneimpianto
               , a.localita         as imp_locimpianto
               , a.cap              as imp_capimpianto
               , coalesce(a.toponimo, '')||' '||coalesce(a.indirizzo, '') as imp_viaimpianto
               , a.numero           as imp_civicoimpianto
               , case when a.cod_tpim = 'A' then 'I'
                      when a.cod_tpim = 'C' then 'C'
                      else ''
                  end               as imp_tipoimpianto
               , case when a.cod_potenza = 'B'  then '1'
                      when a.cod_potenza = 'MB' then '2'
                      when a.cod_potenza = 'MA' then '2'
                      when a.cod_potenza = 'A' then '2'
                      else ''
                 end                as imp_classepotenza
               , a.note as imp_noteimpianto
               , case when a.flag_resp = 'P' then 'S'
                      else 'N'
                 end                as imp_flagproprietario
               , case when a.flag_resp = 'O' then 'S'
                      else 'N'
                 end                as imp_flagoccupante
               , case when a.flag_resp = 'T' then 'S'
                      else 'N'
                 end                as imp_flagterzo
               , a.data_prima_dich  as imp_dataatto
            from coimaimp a
 left outer join coimcitt c on  c.cod_cittadino = a.cod_responsabile
 left outer join coimcomu d on  d.cod_comune    = a.cod_comune
               , coiminco b
           where (a.stato = 'A' or a.stato = 'D')
             and a.cod_impianto_est is not null
             and a.cod_impianto = b.cod_impianto
             and b.cod_opve = :f_cod_tecn
             and b.data_verifica between :data_pre and :data_cor
        group by a.cod_impianto_est
               , c.nome
               , c.cognome
               , c.comune_nas
               , c.data_nas
               , c.comune
               , c.cap
               , c.indirizzo
               , c.numero
               , c.telefono
               , c.cod_fiscale
               , d.denominazione
               , a.localita
               , a.cap
               , a.toponimo
               , a.indirizzo
               , a.numero
               , a.cod_tpim
               , a.cod_potenza
               , a.note
               , a.flag_resp
               , a.data_prima_dich
       </querytext>
    </fullquery>

    <fullquery name="sel_opve">
       <querytext>
          select cognome
               , nome
            from coimopve
           where cod_opve = :f_cod_tecn
       </querytext>
    </fullquery>

</queryset>
