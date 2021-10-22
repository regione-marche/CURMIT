<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_batc">
       <querytext>
             select iter_edit.data(dat_prev) as dat_prev
                  , iter_edit.time(ora_prev) as ora_prev
                  , par
               from coimbatc
              where cod_batc = :cod_batc
       </querytext>
    </fullquery>

    <fullquery name="sel_batc_next">
       <querytext>
             select coimbatc_s.nextval as cod_batc
               from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_batc">
       <querytext>
                insert
                  into coimbatc 
                     ( cod_batc
                     , nom
                     , flg_stat
                     , dat_prev
                     , ora_prev
                     , cod_uten_sch
                     , nom_prog
                     , par
                     , note)
                values
                     (:cod_batc
                     ,:nom
                     ,:flg_stat
                     ,:dat_prev
                     ,:ora_prev
                     ,:cod_uten_sch
                     ,:nom_prog
                     ,:par
                     ,:note)
       </querytext>
    </partialquery>

    <partialquery name="sel_acts_2">
       <querytext>
                   select 1
                     from coimacts
                    where cod_distr  = :cod_distr
                      and data_caric = :data_caric
       </querytext>
    </partialquery>

    <partialquery name="sel_acts_3">
       <querytext>
                   select to_char(a.data_caric, 'yyyymmdd') as data_caric_ult
		        , iter_edit.data(a.data_caric) as data_caric_edit
                     from coimacts a
                    where a.cod_distr  = :cod_distr
                      and a.data_caric = (select max(b.data_caric)
                                            from coimacts b
                                           where b.cod_distr = a.cod_distr)
       </querytext>
    </partialquery>

    <partialquery name="ins_docu">
       <querytext>
                   insert
                     into coimdocu 
                        ( cod_documento
                        , tipo_documento
                        , tipo_soggetto
                        , cod_soggetto
                        , cod_impianto
                        , data_stampa
                        , data_documento
                        , protocollo_01
                        , data_prot_01
                        , protocollo_02
                        , data_prot_02
                        , flag_notifica
                        , descrizione
                        , data_ins
                        , utente)
                   values
                        ( :cod_documento
                        , upper(:tipo_documento)
                        , upper(:tipo_soggetto)
                        , :cod_soggetto
                        , :cod_impianto
                        , :data_stampa
                        , :data_documento
                        , upper(:protocollo_01)
                        , :data_prot_01
                        , upper(:protocollo_02)
                        , :data_prot_02
                        , upper(:flag_notifica)
                        , upper(:descrizione)
                        , :data_ins
                        , :utente)
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

    <partialquery name="ins_acts">
       <querytext>
                   insert
                     into coimacts 
                        ( cod_acts
                        , cod_distr
                        , data_caric
                        , cod_documento
                        , caricati
                        , scartati
                        , invariati
                        , da_analizzare
                        , importati_aimp
                        , chiusi_forzat
                        , stato
                        , percorso_file
                        , data_ins
                        , utente)
                   values
                        ( :cod_acts
                        , :cod_distr
                        , :data_caric
                        , :cod_documento
                        , :caricati
                        , :scartati
                        , :invariati
                        , :da_analizzare
                        , :importati_aimp
                        , :chiusi_forzat
                        , upper(:stato)
                        , :percorso_file
                        , :data_ins
                        , :utente)
       </querytext>
    </partialquery>

    <fullquery name="sel_docu">
       <querytext>
              select coimdocu_s.nextval as cod_documento
                from dual
       </querytext>
    </fullquery>

    <fullquery name="get_cod_acts">
       <querytext>
              select coimacts_s.nextval as cod_acts
                from dual
       </querytext>
    </fullquery>

    <fullquery name="sel_dist">
       <querytext>
              select Nvl(ragione_01,'')||' '||Nvl(ragione_02,'')
                  as nome_dist
                from coimdist
               where cod_distr = :cod_distr
       </querytext>
    </fullquery>


</queryset>
