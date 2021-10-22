<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_cimp">
       <querytext>
select iter_edit_data(c.data_controllo) as data_controllo
     , c.cod_cimp
     , c.cod_inco
     , c.verb_n
     , coalesce(e.ragione_01,'') || ' - ' || coalesce(o.cognome,'') || ' ' || coalesce(o.nome,'') as des_opve
     , c.tipologia_costo
     , c.costo
     , case
       when importo_pag is null
        and data_pag    is null
       then 'N'
       else 'S'
       end         as flag_pagato
     , c.riferimento_pag
     , n.descr_noin
     , c.note_verificatore
     , iter_edit_data(b.data_scad) as data_scad
     , c.cod_documento
     , a.cod_responsabile
     , c.n_prot
     , c.data_prot
     , a.cod_impianto_est
     , a.toponimo ||' '|| a.indirizzo ||' '|| a.numero ||' '|| a.cap ||' '|| co.denominazione as ubicazione_impianto
     , ci.cognome ||' '|| ci.nome ||' - '|| ci.cod_fiscale ||'<br>'|| ci.indirizzo ||' '|| ci.cap ||' '|| ci.comune as responsabile_impianto
  from coimcimp c
  left join coimopve o on o.cod_opve = c.cod_opve
  left join coimenve e on e.cod_enve = o.cod_enve
  left join coimnoin n on n.cod_noin = c.cod_noin
  left outer join coimmovi b on b.riferimento   = c.cod_cimp
                            and b.cod_impianto  = c.cod_impianto
                            and b.tipo_movi     = 'VC'
     , coimaimp a
  left join coimcomu co on co.cod_comune = a.cod_comune
  left join coimcitt ci on ci.cod_cittadino = a.cod_responsabile
 where c.cod_cimp = :cod_cimp
   and c.cod_impianto = :cod_impianto
   and c.cod_impianto = a.cod_impianto
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
                     , protocollo_02
                     , data_prot_02
                     , data_ins
                     , data_mod
                     , utente)
                values 
                     (:cod_documento
                     ,:tipo_documento
                     ,:cod_impianto
                     ,:data_controllo
                     ,current_date
                     ,'C'
                     ,:cod_responsabile
                     ,:n_prot
                     ,:data_prot
                     ,current_date
                     ,current_date
                     ,:id_utente)
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

    <partialquery name="upd_cimp">
       <querytext>
                   update coimcimp
                      set cod_documento = :cod_documento
                    where cod_cimp      = :cod_cimp
       </querytext>
    </partialquery> 

    <fullquery name="sel_anom">
        <querytext>
           select cod_tanom, descr_tano
             from coimanom,
                  coimtano
            where cod_cimp_dimp = :cod_cimp
              and cod_tanom = cod_tano
              and tipo_anom     = '2'
       </querytext>
    </fullquery>

</queryset>
