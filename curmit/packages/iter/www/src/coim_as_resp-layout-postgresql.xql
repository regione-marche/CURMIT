<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_as_resp">
       <querytext>
             select  a.cod_legale_rapp
                     , a.cod_manutentore
                     , iter_edit_data(a.data_inizio) as data_inizio
                     , iter_edit_data(a.data_fine) as data_fine
                     , case a.causale_fine
                        when 'R' then 'Revoca dell''incarico'
                        when 'D' then 'Dimissioni'
                        else ''
                       end as causale_fine
                     , a.toponimo
                     , a.indirizzo
                     , a.cod_via as f_cod_via
                     , a.localita
                     , a.numero
                     , a.esponente
                     , a.scala
                     , a.piano
                     , a.interno
                     , a.cod_comune
                     , a.cod_responsabile
                     , a.flag_tracciato
                     , a.committente
                     , iter_edit_num(a.potenza, 2) as potenza
                     , case
                        when a.data_inizio is null then 'fine'
                        else 'inizio'
                       end as swc_inizio_fine
                     , a.nome_condominio
                     , c.cod_impianto_est
                     , d.cognome as cognome_legale
                     , d.nome as nome_legale
                     , d.indirizzo as ind_legale
                     , d.telefono as tel_legale
                     , d.cellulare as cell_legale
                     , d.fax as fax_legale
                     , d.email as email_legale
                     , e.cognome as cognome_resp
                     , e.nome as nome_resp
		     , p.cognome as cognome_prop --rom01
		     , p.nome    as nome_prop    --rom01
                     , f.denominazione as descr_comune
                     , g.descr_utgi as cod_utgi
                     , h.ragione_01 as forn_energia
                     , m.cognome as cognome_manu
                     , m.nome as nome_manu
                     , m.reg_imprese
                     , m.localita_reg
                     , replace(m.flag_a, 't', 'X') as flag_a
                     , replace(m.flag_b, 't', 'X') as flag_b
                     , replace(m.flag_c, 't', 'X') as flag_c
                     , replace(m.flag_d, 't', 'X') as flag_d
                     , replace(m.flag_e, 't', 'X') as flag_e
                     , replace(m.flag_f, 't', 'X') as flag_f
                     , replace(m.flag_g, 't', 'X') as flag_g
                     , m.cert_uni_iso
                     , m.cert_altro
               from coim_as_resp a
    left outer join coimmanu m on m.cod_manutentore = a.cod_manutentore
    left outer join coimcitt d on d.cod_cittadino = a.cod_legale_rapp
    left outer join coimcitt e on e.cod_cittadino = a.cod_responsabile
    left outer join coimaimp c on c.cod_impianto    = a.cod_impianto
    left outer join coimcitt p on p.cod_cittadino   = c.cod_proprietario --rom01
    left outer join coimcomu f on f.cod_comune      = a.cod_comune
    left outer join coimutgi g on g.cod_utgi        = a.cod_utgi
    left outer join coimdist h on h.cod_distr		= c.cod_distributore
              where a.cod_as_resp = :cod_as_resp
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
