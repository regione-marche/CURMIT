<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_date">
       <querytext>
         select to_char(sysdate, 'dd/mm/yyyy') as data_corrente
           from dual
       </querytext>
    </fullquery>

    <fullquery name="get_desc_prov">
       <querytext>
                   select initcap(denominazione) as desc_prov
                     from coimprov
                    where cod_provincia = :cod_prov
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc_count">
       <querytext>
                   select count(*) as conta
                     from coimcinc
                    where stato = '1'
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc">
       <querytext>
                   select cod_cinc
                        , descrizione as desc_camp
                     from coimcinc
                    where stato = '1'
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp">
       <querytext>
        select a.cod_cimp
             , b.gen_prog_est
          from coimcimp a
             , coimgend b
         where a.cod_inco         =  :cod_inco
           and b.cod_impianto (+) = a.cod_impianto
           and b.gen_prog     (+) = a.gen_prog
       </querytext>
    </fullquery>

    <fullquery name="sel_anom">
       <querytext>
            select a.cod_tanom
                 , b.descr_tano
              from coimanom a
                 , coimtano b
             where a.cod_cimp_dimp = :cod_cimp
	       and a.flag_origine  = 'RV'
               and b.cod_tano      = a.cod_tanom
          order by to_number(a.prog_anom,'99999999')
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_cod_documento">
       <querytext>
           select cod_documento_02 as cod_documento
             from coiminco
            where cod_inco = :cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_2">
       <querytext>
                   select stato
                     from coiminco
                    where cod_inco = :cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_si_viae">
       <querytext>
  select a.cod_inco
       , a.cod_impianto
       , b.cod_impianto_est
       , a.esito
       , iter_edit.data(a.data_avviso_01) as data_avviso_01
       , a.cod_documento_01
       , a.cod_documento_02 as cod_documento
       , b.potenza
       , b.flag_dichiarato
       , nvl(c.descr_topo,'')||' '||nvl(c.descr_estesa,'')||' '||nvl(b.numero,'')||' '||nvl(b.esponente,'') as indir
       , e.cod_cittadino
       , initcap(e.cognome) as cognome_resp
       , initcap(e.nome) as nome_resp
       , initcap(e.indirizzo) as indirizzo_resp
       , e.numero as numero_resp
       , e.cap as cap_resp
       , initcap(e.comune) as comune_resp
       , e.provincia as provincia_resp
    from coiminco a
       , coimaimp b
       , coimviae c
       , coimcitt e
   where 1=1
     and a.stato             = '8'
     and a.esito            is not null
     and a.cod_cinc          = :cod_cinc
     and b.cod_impianto      = a.cod_impianto
     and c.cod_via       (+) = b.cod_via
     and c.cod_comune    (+) = b.cod_comune
     and e.cod_cittadino (+) = b.cod_responsabile
  $where_inco
  $where_data
  $where_codice
  $where_tecn
  $where_comune
  $where_via
  $where_tipo_estr
  $where_enve
  $where_comb
  $where_anno_inst_da
  $where_anno_inst_a
order by a.cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_no_viae">
       <querytext>
  select a.cod_inco
       , a.cod_impianto
       , b.cod_impianto_est
       , a.esito
       , iter_edit.data(a.data_avviso_01) as data_avviso_01
       , a.cod_documento_01
       , a.cod_documento_02 as cod_documento
       , b.potenza
       , b.flag_dichiarato
       , nvl(b.toponimo,'')||' '||nvl(b.indirizzo,'')||' '||nvl(b.numero,'')||' '||nvl(b.esponente,'') as indir
       , e.cod_cittadino
       , initcap(e.cognome) as cognome_resp
       , initcap(e.nome) as nome_resp
       , initcap(e.indirizzo) as indirizzo_resp
       , e.numero as numero_resp
       , e.cap as cap_resp
       , initcap(e.comune) as comune_resp
       , e.provincia as provincia_resp
    from  coiminco a
       ,  coimaimp b
       , coimcitt e
   where 1=1
     and a.stato = '8'
     and a.esito is not null
     and a.cod_cinc = :cod_cinc
     and b.cod_impianto = a.cod_impianto
     and e.cod_cittadino (+) = b.cod_responsabile
  $where_inco
  $where_data
  $where_codice
  $where_tecn
  $where_comune
  $where_via
  $where_tipo_estr
  $where_enve
  $where_comb
  $where_anno_inst_da
  $where_anno_inst_a
order by a.cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_enve">
       <querytext>
        select telefono as tel
          from coimenve
         where cod_enve = :cod_enve
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_next">
        <querytext>
           select coimdocu_s.nextval as cod_documento
             from dual
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp">
       <querytext>
            select nvl(b.cognome,'')||' '||nvl(b.nome,'') as nome_resp
                 , iter_edit.data(b.data_nas) as data_nas
                 , nvl(b.comune_nas,'') as comune_nas
                 , nvl(b.comune,'') as comune
                 , nvl(b.indirizzo,'') as indiriz
                 , nvl(b.numero,'') as numero
              from coimaimp a
                 , coimcitt b
             where a.cod_impianto = :cod_impianto
               and  b.cod_cittadino = a.cod_responsabile
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_2">
       <querytext>
            select nvl(protocollo_01,'') as protocollo_01
              from coimdocu
             where cod_documento = :cod_documento_01
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
                     , cod_soggetto
                     , tipo_soggetto
                     , tipo_documento
                     , cod_impianto
                     , data_documento
                     , data_stampa
                     , data_ins
                     , data_mod
                     , utente)
                values 
                     (:cod_documento
                     ,:cod_cittadino
                     ,'C'
                     ,:tipo_documento
                     ,:cod_impianto
                     ,sysdate
                     ,sysdate
                     ,sysdate
                     ,sysdate
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_docu">
       <querytext>
                   update coimdocu
                      set data_documento = sysdate
                        , data_mod       = sysdate
                        , utente         = :id_utente
                    where cod_documento  = :cod_documento
       </querytext>
    </partialquery>

    <partialquery name="upd_docu_2">
       <querytext>
                   update coimdocu
                      set tipo_contenuto = :tipo_contenuto
                        , contenuto      = empty_blob()
                    where cod_documento  = :cod_documento
                returning contenuto
                     into :1
       </querytext>
    </partialquery> 

    <partialquery name="upd_inco">
       <querytext>
                   update coiminco
                      set cod_documento_02 = :cod_documento
                        , data_avviso_02   = sysdate
                        , data_mod         = sysdate
                        , utente           = :id_utente
                    where cod_inco         = :cod_inco
       </querytext>
    </partialquery>

    <fullquery name="sel_aimp_2">
       <querytext>
        select nvl(b.cognome,'')||' '||nvl(b.nome,'') as nome_resp
          from coimaimp a
             , coimcitt b
         where a.cod_impianto = :cod_impianto
           and b.cod_cittadino = a.cod_responsabile
       </querytext>
    </fullquery>

    <fullquery name="sel_ente">
       <querytext>
            select f.denominazione as nome_ente
                 , f.indirizzo as indirizzo_ente
                 , f.numero as numero_ente
                 , f.cap as cap_ente      
                 , f.comune as comune_ente
                 , f.provincia as provincia_ente
                 , f.cod_area
              from coimanom a
                 , coimanrg b
                 , coimrgen c
                 , coimenrg d
                 , coimenre e
                 , coimenti f
                 , coimaimp g
                 , coimcmar h
                 , coimarea i
             where a.cod_cimp_dimp = :cod_cimp
	            and a.flag_origine  = 'RV'
               and a.cod_tanom     = b.cod_tano
               and b.cod_rgen      = c.cod_rgen
               and c.cod_rgen      = d.cod_rgen
               and d.cod_enre      = e.cod_enre
               and e.cod_enre      = f.cod_enre
               and g.cod_impianto  = :cod_impianto
               and g.cod_comune    = h.cod_comune
               and h.cod_area      = i.cod_area
               and i.cod_area      = f.cod_area
       </querytext>
    </fullquery>

</queryset>
