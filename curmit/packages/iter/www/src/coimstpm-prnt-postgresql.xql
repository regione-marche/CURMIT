<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_docu">
       <querytext>
                insert
                  into coimdocu 
                     ( cod_documento
                     , tipo_documento
                     , cod_impianto
                     , data_documento
                     , data_stampa
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
                  , tipo_documento
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
         , iter_edit_data(a.data_installaz)                          as data_installazione           
         , iter_edit_data(a.data_attivaz)                            as data_installazione     
         , iter_edit_data(a.data_rottamaz)                           as data_rottamazione  
         , a.note                                                    as note_impianto             
         , f.descr_imst                                              as stato_impianto
         , case a.flag_dichiarato
                when 'S' then 'dichiarato'
                when 'N' then 'non dichiarato'                        
                else          ''    
                end                                                  as dichiarato                    
         , iter_edit_data(a.data_prima_dich)                         as data_prima_dichiarazione 
         , iter_edit_data(a.data_ultim_dich)                         as data_ultima_dichiarazione 
         , a.consumo_annuo                                           as consumo_annuo   
         , a.n_generatori                                            as numero_generatori    
         , case a.stato_conformita
                when 'C' then 'conforme'
                else          'non conforme' 
                end                                                  as conformita                
         , case a.flag_resp
                when 'I' then 'intestatario'         
                when 'P' then 'proprietario'         
                when 'O' then 'occupante'         
                when 'A' then 'amministratore'         
                else          'terzo responsabile'
                end                                                  as figura_responsabile
         , a.localita                                                as localita_impianto          
         , coalesce(a.toponimo,'') || ' ' || coalesce(a.indirizzo,'') || ' ' || coalesce(a.numero,'') || ' ' || coalesce(a.esponente,'') || ' ' || coalesce(a.scala,'') || ' ' || coalesce(a.piano,'') || ' ' || coalesce(a.interno,'')                                                  as indirizzo_impianto  
         , a.cap                                                     as cap_impianto                
         , case a.flag_dpr412
                when 'S' then 'soggetto a D.Pr. n°412'
                else          'non soggetto a D.Pr. n°412' 
                end                                                  as dpr412       
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
         , coimimst f
      where cod_impianto = :cod_impianto
        and f.cod_imst   = a.stato
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
         , iter_edit_data(a.data_installaz)                          as data_installazione           
         , iter_edit_data(a.data_attivaz)                            as data_installazione     
         , iter_edit_data(a.data_rottamaz)                           as data_rottamazione  
         , a.note                                                    as note_impianto             
         , f.descr_imst                                              as stato_impianto
         , case a.flag_dichiarato
                when 'S' then 'dichiarato'
                when 'N' then 'non dichiarato'                        
                else          ''    
                end                                                  as dichiarato                    
         , iter_edit_data(a.data_prima_dich)                         as data_prima_dichiarazione 
         , iter_edit_data(a.data_ultim_dich)                         as data_ultima_dichiarazione 
         , a.consumo_annuo                                           as consumo_annuo   
         , a.n_generatori                                            as numero_generatori    
         , case a.stato_conformita
                when 'C' then 'conforme'
                else          'non conforme' 
                end                                                  as conformita                
         , case a.flag_resp
                when 'I' then 'intestatario'         
                when 'P' then 'proprietario'         
                when 'O' then 'occupante'         
                when 'A' then 'amministratore'         
                else          'terzo responsabile'
                end                                                  as figura_responsabile
         , a.localita                                                as localita_impianto          
         , coalesce(b.descr_topo,'') || ' ' || coalesce(b.descrizione,'') || ' ' || coalesce(a.numero,'') || ' ' || coalesce(a.esponente,'') || ' ' || coalesce('scala ' || a.scala,'') || ' ' || coalesce('piano ' || a.piano,'') || ' ' || coalesce('interno ' || a.interno,'')                                                  as indirizzo_impianto  
         , a.cap                                                     as cap_impianto                
         , case a.flag_dpr412
                when 'S' then 'soggetto a D.Pr. n°412'
                else          'non soggetto a D.Pr. n°412' 
                end                                                  as dpr412       
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
      from coimimst f
         , coimaimp a
      left outer join coimviae b on b.cod_via      = a.cod_via
                                and b.cod_comune   = a.cod_comune
     where a.cod_impianto = :cod_impianto
       and f.cod_imst     = a.stato
        </querytext>
    </fullquery>

    <fullquery name="sel_resp">
       <querytext>
    select case natura_giuridica
                when 'F' then 'fisica'
                when 'G' then 'giuridica'
                else          'ignota'
                end                                                        as natura_resp 
         , coalesce(cognome, '') || ' ' || coalesce(nome, '')              as nome_resp  
         , coalesce(indirizzo, '')                                         as indirizzo_resp
         , cap                                                             as cap_resp 
         , localita                                                        as localita_resp
         , comune                                                          as comune_resp 
         , provincia                                                       as provincia_resp
         , case natura_giuridica
                when 'F' then cod_fiscale
                else     cod_piva
                end                                                        as codice_fiscale_resp  
         , coalesce(telefono, '') || ' ' || coalesce(cellulare,'')         as telefono_resp 
         , iter_edit_data(data_nas)                                        as data_nascita_resp
         , comune_nas                                                      as comune_nascita_resp 
         , note                                                            as note_resp 
      from coimcitt
     where cod_cittadino = :cod_responsabile 
       </querytext>
    </fullquery>

    <fullquery name="sel_prop">
       <querytext>
    select case natura_giuridica
                when 'F' then 'fisica'
                when 'G' then 'giuridica'
                else          'ignota'
                end                                                        as natura_prop 
         , coalesce(cognome,'') || ' ' || coalesce(nome,'')                as nome_prop  
         , coalesce(indirizzo,'')                                          as indirizzo_prop
         , cap                                                             as cap_prop 
         , localita                                                        as localita_prop
         , comune                                                          as comune_prop 
         , provincia                                                       as provincia_prop
         , case natura_giuridica
                when 'F' then cod_fiscale
                else     cod_piva
                end                                                        as codice_fiscale_prop  
         , coalesce(telefono,'') || ' ' || coalesce(cellulare,'')          as telefono_prop 
         , iter_edit_data(data_nas)                                        as data_nascita_prop
         , comune_nas                                                      as comune_nascita_prop 
         , note                                                            as note_prop 
      from coimcitt
     where cod_cittadino = :cod_proprietario 
       </querytext>
    </fullquery>

    <fullquery name="sel_inte">
       <querytext>
    select case natura_giuridica
                when 'F' then 'fisica'
                when 'G' then 'giuridica'
                else          'ignota'
                end                                                        as natura_inte 
         , coalesce(cognome,'') || ' ' || coalesce(nome,'')                as nome_inte  
         , coalesce(indirizzo,'')                                          as indirizzo_inte
         , cap                                                             as cap_inte 
         , localita                                                        as localita_inte
         , comune                                                          as comune_inte 
         , provincia                                                       as provincia_inte
         , case natura_giuridica
               when 'F' then cod_fiscale
               else     cod_piva
               end                                                         as codice_fiscale_inte  
         , coalesce(telefono,'') || ' ' || coalesce(cellulare,'')          as telefono_inte 
         , iter_edit_data(data_nas)                                        as data_nascita_inte
         , comune_nas                                                      as comune_nascita_inte 
         , note                                                            as note_inte 
      from coimcitt
     where cod_cittadino = :cod_intestatario 
       </querytext>
    </fullquery>

    <fullquery name="sel_occu">
       <querytext>
    select case natura_giuridica
                when 'F' then 'fisica'
                when 'G' then 'giuridica'
                else          'ignota'
                end                                                        as natura_occu
         , coalesce(cognome,'') || ' ' || coalesce(nome,'')                as nome_occu
         , coalesce(indirizzo,'')                                          as indirizzo_occu
         , cap                                                             as cap_occu
         , localita                                                        as localita_occu
         , comune                                                          as comune_occu
         , provincia                                                       as provincia_occu
         , case natura_giuridica
                when 'F' then cod_fiscale
                else     cod_piva
                end                                                        as codice_fiscale_occu
         , coalesce(telefono,'') || ' ' || coalesce(cellulare,'')          as telefono_occu
         , iter_edit_data(data_nas)                                        as data_nascita_occu
         , comune_nas                                                      as comune_nascita_occu
         , note                                                            as note_occu
      from coimcitt
     where cod_cittadino = :cod_occupante
       </querytext>
    </fullquery>

    <fullquery name="sel_ammi">
       <querytext>
    select case natura_giuridica
                when 'F' then 'fisica'
                when 'G' then 'giuridica'
                else          'ignota'
                end                                                        as natura_ammi
         , coalesce(cognome,'') || ' ' || coalesce(nome,'')                as nome_ammi
         , coalesce(indirizzo,'')                                          as indirizzo_ammi
         , cap                                                             as cap_ammi
         , localita                                                        as localita_ammi
         , comune                                                          as comune_ammi
         , provincia                                                       as provincia_ammi
         , case natura_giuridica
                when 'F' then cod_fiscale
                else     cod_piva
                end                                                        as codice_fiscale_ammi
         , coalesce(telefono,'') || ' ' || coalesce(cellulare,'')          as telefono_ammi
         , iter_edit_data(data_nas)                                        as data_nascita_ammi
         , comune_nas                                                      as comune_nascita_ammi
         , note                                                            as note_ammi
      from coimcitt
     where cod_cittadino = :cod_amministratore 
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
    select coalesce(cognome,'') || ' ' || coalesce(nome,'')                as nome_manu  
         , indirizzo                                                       as indirizzo_manu
         , cap                                                             as cap_manu 
         , localita                                                        as localita_manu
         , comune                                                          as comune_manu 
         , provincia                                                       as provincia_manu
         , coalesce(cod_piva,'') || ' ' || coalesce(cod_fiscale,'')        as partita_iva_manu  
         , coalesce(telefono,'') || ' ' || coalesce(cellulare,'')          as telefono_manu 
         , note                                                            as note_manu 
         , pec                                                             as pec --san01
      from coimmanu
     where cod_manutentore = :cod_manutentore 
       </querytext>
    </fullquery>

    <fullquery name="sel_inst">
       <querytext>
    select coalesce(cognome,'') || ' ' || coalesce(nome,'')                as nome_inst  
         , indirizzo                                                       as indirizzo_inst
         , cap                                                             as cap_inst 
         , localita                                                        as localita_inst
         , comune                                                          as comune_inst 
         , provincia                                                       as provincia_inst
         , coalesce(cod_piva,'') || ' ' || coalesce(cod_fiscale,'')        as partita_iva_inst  
         , coalesce(telefono,'') || ' ' || coalesce(cellulare,'')          as telefono_inst 
         , note                                                            as note_inst 
      from coimmanu
     where cod_manutentore = :cod_installatore
       </querytext>
    </fullquery>

    <fullquery name="sel_dist">
       <querytext>
    select coalesce(ragione_01,'') || ' ' || coalesce(ragione_02,'')       as nome_dist  
         , coalesce(indirizzo,'')            as indirizzo_dist
         , cap                                                             as cap_dist 
         , localita                                                        as localita_dist
         , comune                                                          as comune_dist 
         , provincia                                                       as provincia_dist
         , cod_piva                                                        as partita_iva_dist  
         , coalesce(telefono,'') || ' ' || coalesce(cellulare,'')          as telefono_dist 
         , note                                                            as note_dist 
      from coimdist
     where cod_distr = :cod_distributore 
       </querytext>
    </fullquery>

    <fullquery name="sel_prog">
       <querytext>
    select coalesce(cognome,'') || ' ' || coalesce(nome,'')                as nome_prog  
         , indirizzo                                                       as indirizzo_prog
         , cap                                                             as cap_prog 
         , localita                                                        as localita_prog
         , comune                                                          as comune_prog 
         , provincia                                                       as provincia_prog
         , coalesce(cod_piva,'') || ' ' || coalesce(cod_fiscale,'')        as partita_iva_prog  
         , coalesce(telefono,'') || ' ' || coalesce(cellulare,'')          as telefono_prog 
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
    select a.matricola                           as matricola
         , a.modello                             as modello
         , b.descr_cost                          as descr_cost
         , c.descr_cost                          as descr_cost_bruc 
         , iter_edit_data(a.data_installaz)      as data_installaz
         , a.note                                as note
         , a.gen_prog_est                        as gen_prog_est
         , d.descr_comb                          as descr_comb
         , e.descr_utgi                          as descr_utgi
      from coimgend a left outer join coimcost c on c.cod_cost = a.cod_cost_bruc
                      left outer join coimcost b on b.cod_cost = a.cod_cost
                      left outer join coimcomb d on d.cod_combustibile = a.cod_combustibile
                      left outer join coimutgi e on e.cod_utgi = a.cod_utgi
     where a.cod_impianto = :cod_impianto
       and a.flag_attivo  = 'S'
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
              from coimenrg a left outer join coimenre b on b.cod_enre  = a.cod_enre
             where a.cod_rgen  = :cod_rgen
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp">
       <querytext>
            select a.cod_cimp                                            as cod_cimp
                 , a.gen_prog                                            as gen_prog
                 , a.cod_inco                                            as cod_inco
                 , iter_edit_data(a.data_controllo)                      as data_controllo_rv
                 , a.verb_n                                              as verb_n
                 , iter_edit_data(a.data_verb)                           as data_verb
                 , coalesce(b.cognome,'') || ' ' || coalesce (b.nome,'') as verif_cimp
                 , case a.esito_verifica
                        when 'N' then 'negativo'
                        when 'S' then 'positivo'
                        else              ''    
                        end                                              as esito_verifica
                 , a.flag_ispes
                 , a.flag_cpi
                 , b.telefono											as telefono_ver
                 , b.cellulare											as cellulare_ver
              from coimcimp a left outer join coimopve b on b.cod_opve = a.cod_opve
             where a.cod_impianto = :cod_impianto
               and a.cod_cimp = (select max(cod_cimp) 
                                   from coimcimp
                                  where cod_impianto = :cod_impianto)
       </querytext>
    </fullquery>

    <fullquery name="sel_sanz">
       <querytext>
            select iter_edit_data(a.data_scad)        as data_scad_sanz
                 , iter_edit_num(a.importo, 2)        as importo_sanz
                 , case a.tipo_soggetto
                   when 'R' then 'Responsabile'
                   when 'M' then 'Manutentore'
                   when 'D' then 'Distributore'
                   else          ''
                   end                                as tipo_soggetto_sanz
                 , a.cod_soggetto                     as cod_soggetto_sanz
                 , b.descr_breve                      as sanzione_1
                 , c.descr_breve                      as sanzione_2
                 , iter_edit_data(a.data_rich_audiz)  as data_rich_audiz
                 , iter_edit_data(a.data_pres_deduz)  as data_pres_deduz
                 , iter_edit_data(a.data_ric_giudice) as data_ric_giudice
                 , iter_edit_data(a.data_ric_tar)     as data_ric_tar
                 , iter_edit_data(a.data_ric_ulter)   as data_ric_ulter
                 , iter_edit_data(a.data_ruolo)       as data_ruolo
                 , note_rich_audiz
                 , note_pres_deduz
                 , note_ric_giudice
                 , note_ric_tar
                 , note_ric_ulter
                 , note_ruolo
              from coimmovi a
   left outer join coimsanz b on b.cod_sanzione = a.cod_sanzione_1
   left outer join coimsanz c on c.cod_sanzione = a.cod_sanzione_2
             where a.id_caus = (select s.id_caus from coimcaus s where codice = 'SA')
               and a.importo_pag is null
               and a.data_pag is null
               and a.cod_impianto = :cod_impianto
	     order by a.data_ins desc
             limit 3
       </querytext>
    </fullquery>

    <fullquery name="sel_nome_resp">
       <querytext>
        select coalesce(cognome, '')||' '||coalesce(nome, '') as soggetto_sanz
          from coimcitt
         where cod_cittadino = :cod_soggetto_sanz
       </querytext>
    </fullquery>

    <fullquery name="sel_nome_manu">
       <querytext>
        select coalesce(cognome, '')||' '||coalesce(nome, '') as soggetto_sanz
          from coimmanu
         where cod_manutentore = :cod_soggetto_sanz
       </querytext>
    </fullquery>

    <fullquery name="sel_nome_dist">
       <querytext>
        select coalesce(ragione_01, '')||' '||coalesce(ragione_02, '') as soggetto_sanz
          from coimdist
         where cod_distr = :cod_soggetto_sanz
       </querytext>
    </fullquery>

    <fullquery name="sel_anom">
       <querytext>
            select descr_breve                       as anomalia
                 , iter_edit_data (dat_utile_inter)  as data_interv
              from coimtano
                 , coimanom 
             where cod_tano      = cod_tanom
               and cod_cimp_dimp = :cod_cimp
       </querytext>
    </fullquery>

    <fullquery name="sel_inco">
       <querytext>
            select a.cod_inco                                               as cod_inco
                 , d.descrizione                                            as desc_cinc
                 , a.tipo_estrazione                                        as tipo_estrazione
                 , iter_edit_data(a.data_estrazione)                        as data_estrazione
                 , iter_edit_data(a.data_assegn)                            as data_assegn
                 , coalesce (b.cognome, '') || ' ' || coalesce (b.nome, '') as verif_inco
                  , b.cellulare                                              as verif_cel
                 , b.telefono												as telefono_opve
                 , iter_edit_data(a.data_verifica)                          as data_verifica
                 , a.ora_verifica                                           as ora_verifica
                 , iter_edit_data(a.data_avviso_01)                         as data_avviso_01
                 , a.cod_documento_01                                       as cod_documento_01
                 , iter_edit_data(a.data_avviso_02)                         as data_avviso_02     
                 , a.cod_documento_02                                       as cod_documento_02
                 , c.descr_inst                                             as stato
                 , a.esito                                                  as esito
                 , a.note                                                   as note
		 , coalesce(b.email)                                        as email_opve --rom01
             from coiminco a left outer join coimopve b on b.cod_opve = a.cod_opve
                              left outer join coiminst c on c.cod_inst = a.stato
                              left outer join coimcinc d on d.cod_cinc = a.cod_cinc
             
             where cod_inco = (select max(cod_inco) 
	               --rom02(select max(to_number(cod_inco, '99999999')) --san02 06/12/2018 Messo il to_number perchè cod_inco è un varhcar
                                 from coiminco
                                where cod_impianto = :cod_impianto)
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_count">
       <querytext>
            select count(*) as conta_prot
              from coimdocu a 
   left outer join coimtdoc b on b.tipo_documento = a.tipo_documento
             where cod_impianto = :cod_impianto
              and protocollo_01 = :id_protocollo --san01
       </querytext>
    </fullquery>

    <fullquery name="sel_docu">
       <querytext>
            select b.descrizione                      as desc_tdoc
                 , iter_edit_data(a.data_stampa)      as data_stampa
                 , iter_edit_data(a.data_documento)   as data_documento
                 , iter_edit_data(a.data_prot_01)     as data_prot_01
                 , a.protocollo_01                    as protocollo_01
                 , iter_edit_data(a.data_prot_02)     as data_prot_02
                 , a.protocollo_02                    as protocollo_02
                 , case a.flag_notifica
                        when 'N' then 'No'
                        when 'S' then 'Si'
                   end                                as flag_notifica                    
                 , iter_edit_data(a.data_notifica)    as data_notifica
                 , a.descrizione                      as descrizione
                 , a.note                             as note
              from coimdocu a left outer join coimtdoc b on b.tipo_documento = a.tipo_documento
             where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp">
       <querytext>
            select iter_edit_data(a.data_controllo)                       as data_controllo
                 , coalesce(b.cognome, '') || ' ' || coalesce(b.nome, '') as manutentore
                 , case a.cont_rend
                        when 'N' then 'non effettuato'
                        when 'S' then 'effettuato'
                   end                                                    as cont_rend
                 , a.n_prot                                               as n_prot
                 , iter_edit_data(a.data_prot)                            as data_prot
              from coimdimp a left outer join coimmanu b on b.cod_manutentore = a.cod_manutentore
             where a.cod_impianto = :cod_impianto
          order by a.data_controllo
                 , a.cod_dimp
       </querytext>
    </fullquery>
</queryset>

