<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_resp">
       <querytext>
             select    a.cod_responsabile
                     , a.cod_manutentore
                     , c.descr_topo as toponimo
                     , c.descrizione as indirizzo
                     , a.cod_via
                     , a.localita
                     , a.numero
                     , a.esponente
                     , a.scala
                     , a.piano
                     , a.interno
                     , a.cod_comune
                     , iter_edit_data(z.data_fin_valid) as data_fin_valid_edit
                     , iter_edit_num(a.potenza, 2) as potenza
                     , case a.flag_resp
                      when 'P' then 'Proprietario'
                      when 'O' then 'Occupante'
                      when 'A' then 'Amministratore'
                      when 'R' then 'Responsabile'
                      when 'I' then 'Intestatario'
                      else ''
                      end as flag_resp
                     , a.cod_impianto_est
                     , d.cognome as cognome_resp
                     , d.nome as nome_resp
                     , d.indirizzo as ind_resp
                     , d.telefono as tel_resp
                     , d.cellulare as cell_resp
                     , d.fax as fax_resp
                     , d.email as email_resp
                     , d.comune as comune_resp
                     , d.provincia as provincia_resp
                     , d.cod_fiscale as cod_fiscale_resp
                     , d.cod_piva as cod_piva_resp
                     , f.denominazione as descr_comune
                     , h.ragione_01 as forn_energia
                     , k.cognome as cognome_old
                     , k.nome as nome_old
               from coimaimp a
    left outer join coimmanu m on m.cod_manutentore = a.cod_manutentore
    left outer join coimcitt d on d.cod_cittadino = a.cod_responsabile
    left outer join coimviae c on c.cod_via    = a.cod_via
    left outer join coimcomu f on f.cod_comune      = a.cod_comune
    left outer join coimdist h on h.cod_distr		= a.cod_distributore
    left outer join coimrife z on z.cod_impianto     =  a.cod_impianto
     left outer join coimcitt k on k.cod_cittadino = z.cod_soggetto 
              where a.cod_impianto = :cod_impianto limit 1
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_next">
        <querytext>
           select nextval('coimdocu_s') as cod_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_docu">
        <querytext>
           select 1
             from coimdocu
            where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <partialquery name="ins_docu">
       <querytext>
                   insert
                     into coimdocu 
                        ( cod_documento
                        , tipo_documento
                        , cod_impianto
                        , data_documento
                        , data_stampa
                        , tipo_soggetto
                        , cod_soggetto
                        , data_ins
                        , utente)
                   values
                        ( :cod_documento
                        , :tipo_documento
                        , :cod_impianto
                        , current_date
                        , current_date
                        , 'C'
                        , :cod_responsabile
                        , current_date
                        , :id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_docu">
       <querytext>
                   update coimdocu
                      set data_documento = current_date
                        , data_mod       = current_date
                        , utente         = :id_utente
                    where cod_documento  = :cod_documento
       </querytext>
    </partialquery>

    <fullquery name="sel_docu_contenuto">
       <querytext>
          select contenuto as docu_contenuto_check
            from coimdocu
           where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <partialquery name="upd_docu_2">
       <querytext>
                   update coimdocu
                      set contenuto     = lo_unlink(coimdocu.contenuto)
                    where cod_documento = :cod_documento
       </querytext>
    </partialquery> 

    <partialquery name="upd_docu_3">
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
                      set cod_documento = :cod_documento
                    where cod_dimp      = :cod_dimp
       </querytext>
    </partialquery> 

    <fullquery name="sel_anom">
        <querytext>
           select cod_tanom
             from coimanom
            where cod_cimp_dimp = :cod_dimp
              and tipo_anom     = '1'
       </querytext>
    </fullquery>

    <fullquery name="sel_cod_gend">
       <querytext>
              select a.gen_prog as gen_progg 
                from coimgend a
                   , coimdimp b
               where b.cod_dimp     =  :cod_dimp
                 and a.cod_impianto = b.cod_impianto
                 and a.flag_attivo  =  'S'
               order by a.gen_prog_est
               limit 1
      </querytext>
    </fullquery>

</queryset>
