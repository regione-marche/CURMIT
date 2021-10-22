<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="get_id_documento">
       <querytext>
             select nextval('coimdocu_s') as id_documento
       </querytext>
    </partialquery>

    <partialquery name="ins_docu">
       <querytext>
                insert
                  into coimdocu 
                     ( cod_documento
                     , tipo_documento
                     , cod_impianto
                     , data_documento
                     , data_prot_01
                     , protocollo_01
                     , data_ins
                     , data_mod
                     , utente)
                values 
                     (:cod_documento
                     ,:tipo_documento
                     ,:cod_impianto
                     ,current_date
                     ,:protocollo_dt
                     ,:id_protocollo
                     ,current_date
                     ,current_date
                     ,:id_utente)
       </querytext>
    </partialquery>

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

    <partialquery name="sel_docu_next">
       <querytext>
             select nextval('coimdocu_s') as cod_documento
       </querytext>
    </partialquery>

    <fullquery name="sel_docu_contenuto">
       <querytext>
          select contenuto as docu_contenuto_check
            from coimdocu
           where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_stpm">
       <querytext>
             select id_stampa
                  , testo
                  , descrizione as descrizione_stampa
                  , campo1
                  , campo1_testo
                  , campo2
                  , campo2_testo
                  , campo3
                  , campo3_testo
                  , campo4
                  , campo4_testo
                  , campo5
                  , campo5_testo
                  , var_testo
                  , allegato
                  , tipo_foglio
                  , orientamento
               from coimstpm
              where id_stampa = :id_stampa
       </querytext>
    </fullquery>

    <fullquery name="sel_imp_no_vie">
       <querytext>
    select a.cod_impianto                           
         , a.cod_impianto_est                                        as codice_impianto        
         , a.cod_impianto_prov                                       as codice_impianto_originale  
         , a.descrizione                                             as descrizione_impianto        
         , a.potenza                                                 as potenza_nominale         
         , a.potenza_utile                                           as potenza_utile   
         , iter_edit.data(a.data_installaz)                          as data_installazione           
         , iter_edit.data(a.data_attivaz)                            as data_installazione     
         , iter_edit.data(a.data_rottamaz)                           as data_rottamazione  
         , a.note                                                    as note_impianto             
         , decode (a.stato
                , 'A' , 'attivo' 
                , 'N' , 'non attivo' 
                , 'L' , 'annullato' 
                , 'D' , 'da definire' 
                , 'R' , 'rottamato' 
                ,       '')                                          as stato_impianto
         , decode (a.flag_dichiarato
                , 'S' , 'dichiarato'
                , 'N' , 'non dichiarato'                        
                ,       '')                                          as dichiarato                    
         , iter_edit.data(a.data_prima_dich)                         as data_prima_dichiarazione 
         , iter_edit.data(a.data_ultim_dich)                         as data_ultima_dichiarazione 
         , a.consumo_annuo                                           as consumo_annuo   
         , a.n_generatori                                            as numero_generatori    
         , decode (a.stato_conformita
                , 'C' , 'conforme'
                ,       'non conforme')                              as conformita                
         , a.flag_resp -- 13/11/2013

         , decode (a.flag_resp
                , 'I' , 'intestatario'         
                , 'P' , 'proprietario'         
                , 'O' , 'occupante'         
                , 'A' , 'amministratore'         
                ,       'terzo responsabile')                        as figura_responsabile
         , a.localita                                                as localita          
         , nvl(a.toponimo,'') || ' ' || nvl(a.indirizzo,'') || ' ' || nvl(a.numero,'') || ' ' || nvl(a.esponente,'') || ' ' || nvl(a.scala,'') || ' ' || nvl(a.piano,'') || ' ' || nvl(a.interno,'')   as indirizzo_impianto         
         , a.cap                                                     as cap_impianto                
         , decode (a.flag_dpr412
                , 'S' , 'soggetto a D.Pr. n°412'
                ,       'non soggetto a D.Pr. n°412')                as dpr412       
         , a.cod_amag                                                as codice_utenza          
         , a.cod_cted          
         , a.cod_comune        
         , a.cod_provincia     
         , a.cod_tpdu          
         , a.cod_qua           
         , a.cod_urb           
         , a.cod_combustibile 
         , a.cod_potenza                       
         , a.cod_tpim        
         , a.cod_responsabile 
         , a.cod_intestatario 
         , a.cod_proprietario 
         , a.cod_occupante    
         , a.cod_amministratore
         , a.cod_manutentore   
         , a.cod_installatore  
         , a.cod_distributore  
         , a.cod_progettista   
      from coimaimp a
     where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_imp_si_vie">
       <querytext>
    select a.cod_impianto                           
         , a.cod_impianto_est                                        as codice_impianto        
         , a.cod_impianto_prov                                       as codice_impianto_originale  
         , a.descrizione                                             as descrizione_impianto        
         , a.potenza                                                 as potenza_nominale         
         , a.potenza_utile                                           as potenza_utile   
         , iter_edit.data(a.data_installaz)                          as data_installazione           
         , iter_edit.data(a.data_attivaz)                            as data_installazione     
         , iter_edit.data(a.data_rottamaz)                           as data_rottamazione  
         , a.note                                                    as note_impianto             
         , decode (a.stato
                , 'A' , 'attivo' 
                , 'N' , 'non attivo' 
                , 'L' , 'annullato' 
                , 'D' , 'da definire' 
                , 'R' , 'rottamato' 
                ,          '')                                       as stato_impianto
         , decode (a.flag_dichiarato
                , 'S' , 'dichiarato'
                , 'N' , 'non dichiarato'                        
                ,           '')                                      as dichiarato                    
         , iter_edit.data(a.data_prima_dich)                         as data_prima_dichiarazione 
         , iter_edit.data(a.data_ultim_dich)                         as data_ultima_dichiarazione 
         , a.consumo_annuo                                           as consumo_annuo   
         , a.n_generatori                                            as numero_generatori    
         , decode (a.stato_conformita
                , 'C' , 'conforme'
                ,          'non conforme')                           as conformita                
         , a.flag_resp -- 13/11/2013

         , decode (a.flag_resp
                , 'I' , 'intestatario'         
                , 'P' , 'proprietario'         
                , 'O' , 'occupante'         
                , 'A' , 'amministratore'         
                ,          'terzo responsabile')                     as figura_responsabile
         , a.localita                                                as localita_impianto          
         , nvl(b.descr_topo,'') || ' ' || nvl(b.descrizione,'') || ' ' || nvl(a.numero,'') || ' ' || nvl(a.esponente,'') || ' ' || nvl(a.scala,'') || ' ' || nvl(a.piano,'') || ' ' || nvl(a.interno,'')                                                                                 as indirizzo_impianto  
         , a.cap                                                     as cap_impianto                
         , decode (a.flag_dpr412
                , 'S' , 'soggetto a D.Pr. n°412'
                ,          'non soggetto a D.Pr. n°412')             as dpr412       
         , a.cod_amag                                                as codice_utenza          
         , a.cod_cted          
         , a.cod_comune        
         , a.cod_provincia     
         , a.cod_tpdu          
         , a.cod_qua           
         , a.cod_urb           
         , a.cod_combustibile 
         , a.cod_potenza                       
         , a.cod_tpim        
         , a.cod_responsabile 
         , a.cod_intestatario 
         , a.cod_proprietario 
         , a.cod_occupante    
         , a.cod_amministratore
         , a.cod_manutentore   
         , a.cod_installatore  
         , a.cod_distributore  
         , a.cod_progettista   
      from coimaimp a
         , coimviae b
     where a.cod_impianto    = :cod_impianto
       and b.cod_via      (+)= a.cod_via
       and b.cod_comune   (+)= a.cod_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_resp">
       <querytext>
    select decode (natura_giuridica
                , 'F' , 'fisica'
                , 'G' , 'giuridica'
                ,       'ignota')                                          as natura_resp 
         , nvl(cognome,'') || ' ' || nvl(nome,'')                          as nome_resp  
         , nvl(indirizzo,'') || ' ' || nvl(numero,'')                      as indirizzo_resp
         , cap                                                             as cap_resp 
         , localita                                                        as localita_resp
         , comune                                                          as comune_resp 
         , provincia                                                       as provincia_resp
         , decode (natura_giuridica
                , 'F' , cod_fiscale
                ,       cod_piva)                                          as codice_fiscale_resp  
         , nvl(telefono,'') || ' ' || nvl(cellulare,'')                    as telefono_resp 
         , iter_edit.data(data_nas)                                        as data_nascita_resp
         , comune_nas                                                      as comune_nascita_resp 
         , note                                                            as note_resp 
      from coimcitt
     where cod_cittadino = :cod_responsabile 
       </querytext>
    </fullquery>

    <fullquery name="sel_manu_resp">
       <querytext>--13/11/2013
          select * 
             from (
                select 'C/O '||nvl(indirizzo,'')      as indirizzo_resp
                     , cap                            as cap_resp
                     , localita                       as localita_resp
                     , comune                         as comune_resp
                     , provincia                      as provincia_resp
                  from coimmanu
                 where cod_legale_rapp = :cod_responsabile
              order by cod_manutentore
                  ) as result_table
            where rownum <= 1
       </querytext>
    </fullquery>

    <fullquery name="sel_prop">
       <querytext>
    select decode (natura_giuridica
                , 'F' , 'fisica'
                , 'G' , 'giuridica'
                ,       'ignota')                                          as natura_prop 
         , nvl(cognome,'') || ' ' || nvl(nome,'')                          as nome_prop  
         , nvl(indirizzo,'') || ' ' || nvl(numero,'')                      as indirizzo_prop
         , cap                                                             as cap_prop 
         , localita                                                        as localita_prop
         , comune                                                          as comune_prop 
         , provincia                                                       as provincia_prop
         , decode (natura_giuridica
                , 'F' , cod_fiscale
                ,       cod_piva)                                          as codice_fiscale_prop  
         , nvl(telefono,'') || ' ' || nvl(cellulare,'')                    as telefono_prop 
         , iter_edit.data(data_nas)                                        as data_nascita_prop
         , comune_nas                                                      as comune_nascita_prop 
         , note                                                            as note_prop 
      from coimcitt
     where cod_cittadino = :cod_proprietario 
       </querytext>
    </fullquery>

    <fullquery name="sel_inte">
       <querytext>
    select decode (natura_giuridica
                , 'F' , 'fisica'
                , 'G' , 'giuridica'
                ,       'ignota')                                          as natura_inte 
         , nvl(cognome,'') || ' ' || nvl(nome,'')                          as nome_inte  
         , nvl(indirizzo,'') || ' ' || nvl(numero,'')                      as indirizzo_inte
         , cap                                                             as cap_inte 
         , localita                                                        as localita_inte
         , comune                                                          as comune_inte 
         , provincia                                                       as provincia_inte
         , decode (natura_giuridica
                , 'F' , cod_fiscale
                ,       cod_piva)                                          as codice_fiscale_inte  
         , nvl(telefono,'') || ' ' || nvl(cellulare,'')                    as telefono_inte 
         , iter_edit.data(data_nas)                                        as data_nascita_inte
         , comune_nas                                                      as comune_nascita_inte 
         , note                                                            as note_inte 
      from coimcitt
     where cod_cittadino = :cod_intestatario 
       </querytext>
    </fullquery>

    <fullquery name="sel_occu">
       <querytext>
    select decode (natura_giuridica
                , 'F' , 'fisica'
                , 'G' , 'giuridica'
                ,       'ignota')                                          as natura_occu
         , nvl(cognome,'') || ' ' || nvl(nome,'')                          as nome_occu
         , nvl(indirizzo,'') || ' ' || nvl(numero,'')                      as indirizzo_occu
         , cap                                                             as cap_occu
         , localita                                                        as localita_occu
         , comune                                                          as comune_occu
         , provincia                                                       as provincia_occu
         , decode (natura_giuridica
                , 'F' , cod_fiscale
                ,       cod_piva)                                          as codice_fiscale_occu
         , nvl(telefono,'') || ' ' || nvl(cellulare,'')                    as telefono_occu
         , iter_edit.data(data_nas)                                        as data_nascita_occu
         , comune_nas                                                      as comune_nascita_occu
         , note                                                            as note_occu
      from coimcitt
     where cod_cittadino = :cod_occupante
       </querytext>
    </fullquery>

    <fullquery name="sel_ammi">
       <querytext>
    select decode (natura_giuridica
                , 'F' , 'fisica'
                , 'G' , 'giuridica'
                ,       'ignota')                                          as natura_ammi
         , nvl(cognome,'') || ' ' || nvl(nome,'')                          as nome_ammi
         , nvl(indirizzo,'') || ' ' || nvl(numero,'')                      as indirizzo_ammi
         , cap                                                             as cap_ammi
         , localita                                                        as localita_ammi
         , comune                                                          as comune_ammi
         , provincia                                                       as provincia_ammi
         , decode (natura_giuridica
                , 'F' , cod_fiscale
                ,       cod_piva)                                          as codice_fiscale_ammi
         , nvl(telefono,'') || ' ' || nvl(cellulare,'')                    as telefono_ammi
         , iter_edit.data(data_nas)                                        as data_nascita_ammi
         , comune_nas                                                      as comune_nascita_ammi
         , note                                                            as note_ammi
      from coimcitt
     where cod_cittadino = :cod_amministratore 
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
    select nvl(cognome,'') || ' ' || nvl(nome,'')                          as nome_manu  
         , indirizzo                                                       as indirizzo_manu
         , cap                                                             as cap_manu 
         , localita                                                        as localita_manu
         , comune                                                          as comune_manu 
         , provincia                                                       as provincia_manu
         , nvl(cod_piva,'') || ' ' || nvl(cod_fiscale,'')                  as partita_iva_manu  
         , nvl(telefono,'') || ' ' || nvl(cellulare,'')                    as telefono_manu 
         , note                                                            as note_manu 
      from coimmanu
     where cod_manutentore = :cod_manutentore 
       </querytext>
    </fullquery>

    <fullquery name="sel_inst">
       <querytext>
    select nvl(cognome,'') || ' ' || nvl(nome,'')                          as nome_inst  
         , indirizzo                                                       as indirizzo_inst
         , cap                                                             as cap_inst 
         , localita                                                        as localita_inst
         , comune                                                          as comune_inst 
         , provincia                                                       as provincia_inst
         , nvl(cod_piva,'') || ' ' || nvl(cod_fiscale,'')                  as partita_iva_inst  
         , nvl(telefono,'') || ' ' || nvl(cellulare,'')                    as telefono_inst 
         , note                                                            as note_inst 
      from coimmanu
     where cod_manutentore = :cod_installatore
       </querytext>
    </fullquery>

    <fullquery name="sel_dist">
       <querytext>
    select nvl(ragione_01,'') || ' ' || nvl(ragione_02,'')                 as nome_dist  
         , nvl(indirizzo,'') || ' ' || nvl(numero,'')                      as indirizzo_dist
         , cap                                                             as cap_dist 
         , localita                                                        as localita_dist
         , comune                                                          as comune_dist 
         , provincia                                                       as provincia_dist
         , cod_piva                                                        as partita_iva_dist  
         , nvl(telefono,'') || ' ' || nvl(cellulare,'')                    as telefono_dist 
         , note                                                            as note_dist 
      from coimdist
     where cod_distr = :cod_distributore 
       </querytext>
    </fullquery>

    <fullquery name="sel_prog">
       <querytext>
    select nvl(cognome,'') || ' ' || nvl(nome,'')                          as nome_prog  
         , indirizzo                                                       as indirizzo_prog
         , cap                                                             as cap_prog 
         , localita                                                        as localita_prog
         , comune                                                          as comune_prog 
         , provincia                                                       as provincia_prog
         , nvl(cod_piva,'') || ' ' || nvl(cod_fiscale,'')                  as partita_iva_prog  
         , nvl(telefono,'') || ' ' || nvl(cellulare,'')                    as telefono_prog 
         , note                                                            as note_prog 
      from coimprog
     where cod_progettista = :cod_progettista 
       </querytext>
    </fullquery>

    <fullquery name="sel_cted">
       <querytext>
    select descr_cted                                                      as tipo_edificio  
      from coimcted
     where cod_cted = :cod_cted
       </querytext>
    </fullquery>

    <fullquery name="sel_comu">
       <querytext>
    select denominazione                                                   as comune_impianto  
      from coimcomu
     where cod_comune = :cod_comune 
       </querytext>
    </fullquery>

    <fullquery name="sel_prov">
       <querytext>
    select denominazione                                                   as provincia_impianto  
      from coimprov
     where cod_provincia = :cod_provincia 
       </querytext>
    </fullquery>

    <fullquery name="sel_tpdu">
       <querytext>
    select descr_tpdu                                                      as destinazione_uso  
      from coimtpdu
     where cod_tpdu = :cod_tpdu
       </querytext>
    </fullquery>

    <fullquery name="sel_comb">
       <querytext>
    select descr_comb                                                      as combustibile  
      from coimcomb
     where cod_combustibile = :cod_combustibile 
       </querytext>
    </fullquery>

    <fullquery name="sel_pote">
       <querytext>
    select descr_potenza                                                   as fascia_potenza  
      from coimpote
     where cod_potenza = :cod_potenza 
       </querytext>
    </fullquery>

    <fullquery name="sel_tpim">
       <querytext>
    select descr_tpim                                                      as tipo_impianto  
      from coimtpim
     where cod_tpim = :cod_tpim
       </querytext>
    </fullquery>

    <fullquery name="sel_gend">
       <querytext>
    select a.matricola                        as matricola
         , a.modello                          as modello
         , b.descr_cost                       as descr_cost
         , c.descr_cost                       as descr_cost_bruc 
         , iter_edit.data(a.data_installaz)   as data_installaz
         , a.note                             as note
         , a.gen_prog_est                     as gen_prog_est
         , d.descr_comb                       as descr_comb
         , e.descr_utgi                       as descr_utgi
      from coimgend a 
         , coimcost c 
         , coimcost b 
         , coimcomb d
         , coimutgi e
     where a.cod_impianto         = :cod_impianto
       and c.cod_cost (+)         = a.cod_cost_bruc
       and b.cod_cost (+)         = a.cod_cost
       and d.cod_combustibile (+) = a.cod_combustibile
       and e.cod_utgi (+)         = a.cod_utgi
       and a.flag_attivo          = 'S'
       </querytext>
    </fullquery>

    <fullquery name="sel_enrg">
       <querytext>
            select a.cod_enre
                 , b.denominazione as denom_dest
                 , b.indirizzo     as indirizzo_dest
                 , b.numero        as numero_dest
                 , b.cap           as cap_dest
                 , b.localita      as localita_dest
                 , b.comune        as comune_dest
                 , b.provincia     as provincia_dest
              from coimenrg a
                 , coimenre b
             where a.cod_rgen = :cod_rgen
               and b.cod_enre = a.cod_enre
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp">
       <querytext>
            select a.cod_cimp                                            as cod_cimp
                 , a.gen_prog                                            as gen_prog
                 , a.cod_inco                                            as cod_inco
                 , iter_edit.data(a.data_controllo)                      as data_controllo
                 , a.verb_n                                              as verb_n
                 , iter_edit.data(a.data_verb)                           as data_verb
                 , nvl(b.cognome, '') || ' ' || nvl(b.nome, '')          as verif_cimp
                 , decode (a.esito_verifica
                        , 'N' , 'negativo'
                        , 'S' , 'positivo'
                        ,       '')                                      as esito_verifica
                 , a.flag_ispes
                 , a.flag_cpi
              from coimcimp a
                 , coimopve b
             where a.cod_impianto = :cod_impianto
               and b.cod_opve (+) = a.cod_opve
               and a.cod_cimp     = (select max(cod_cimp) 
                                       from coimcimp
                                      where cod_impianto = :cod_impianto)
       </querytext>
    </fullquery>

    <fullquery name="sel_anom">
       <querytext>
            select descr_breve                       as anomalia
                 , iter_edit.data (dat_utile_inter)  as data_interv
              from coimtano
                 , coimanom 
             where cod_tano = cod_tanom
               and cod_cimp_dimp = :cod_cimp
       </querytext>
    </fullquery>

    <fullquery name="sel_inco">
       <querytext>
            select a.cod_inco                                    as cod_inco
                 , d.descrizione                                 as desc_cinc
                 , a.tipo_estrazione                             as tipo_estrazione
                 , iter_edit.data(a.data_estrazione)             as data_estrazione
                 , iter_edit.data(a.data_assegn)                 as data_assegn
                 , nvl(b.cognome, '') || ' ' || nvl(b.nome, '')  as verif_inco
                 , iter_edit.data(a.data_verifica)               as data_verifica
                 , a.ora_verifica                                as ora_verifica
                 , iter_edit.data(a.data_avviso_01)              as data_avviso_01
                 , a.cod_documento_01                            as cod_documento_01
                 , iter_edit.data(a.data_avviso_02)              as data_rapporto     
                 , a.cod_documento_02                            as cod_documento_02
                 , c.descr_inst                                  as stato
                 , a.esito                                       as esito
                 , a.note                                        as note
              from coiminco a
                 , coimopve b
                 , coiminst c
                 , coimcinc d
             where cod_inco = (select max(to_number(cod_inco, '99999999'))
                                 from coiminco
                                where cod_impianto = :cod_impianto)
               and b.cod_opve (+) = a.cod_opve
               and c.cod_inst (+) = a.stato
               and d.cod_cinc (+) = a.cod_cinc
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_count">
       <querytext>
            select count(*) as conta_prot
              from coimdocu a
                 , coimtdoc b
             where cod_impianto         = :cod_impianto
               and b.tipo_documento (+) = a.tipo_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_docu">
       <querytext>
            select b.descrizione                      as desc_tdoc
                 , iter_edit.data(a.data_stampa)      as data_stampa
                 , iter_edit.data(a.data_documento)   as data_documento
                 , iter_edit.data(a.data_prot_01)     as data_prot_01
                 , a.protocollo_01                    as protocollo_01
                 , iter_edit.data(a.data_prot_02)     as data_prot_02
                 , a.protocollo_02                    as protocollo_02
                 , decode (a.flag_notifica
                        , 'N' , 'No'
                        , 'S' , 'Si')                 as flag_notifica                    
                 , iter_edit.data(a.data_notifica)    as data_notifica
                 , a.descrizione                      as descrizione
                 , a.note                             as note
              from coimdocu a
                 , coimtdoc b
             where cod_impianto         = :cod_impianto
               and b.tipo_documento (+) = a.tipo_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp">
       <querytext>
            select iter_edit.data(a.data_controllo)                       as data_controllo
                 , nvl(b.cognome, '') || ' ' || nvl(b.nome, '')           as manutentore
                 , decode (a.cont_rend 
                       , 'N' , 'non effettuato'
                       , 'S' , 'effettuato')                              as cont_rend
                 , a.n_prot                                               as n_prot
                 , iter_edit.data(a.data_prot)                            as data_prot
              from coimdimp a
                 , coimmanu b
             where cod_impianto          = :cod_impianto
               and b.cod_manutentore (+) = a.cod_manutentore
       </querytext>
    </fullquery>

    <partialquery name="upd_inco">
       <querytext>
                   update coiminco
                   set cod_documento_02 = :cod_documento
                     , data_avviso_02   = current_date
                 where cod_inco         = :cod_inco
       </querytext>
    </partialquery> 

</queryset>
