<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_aimp">
       <querytext>
    select a.cod_impianto_est
         , nvl(a.cod_amag,'&nbsp;') as cod_amag
         , decode (a.flag_dichiarato
           , 'S' , 'SI'
	   , 'N' , 'NO'
           , 'C' , 'N.C.'
           , '&nbsp;') as desc_dich
         , decode (a.tariffa
           , '03' , 'Riscald. &gt; 100 KW'
           , '04' , 'Riscald. autonomo e acqua calda'
           , '05' , 'Riscald. centralizzato'
           , '07' , 'Riscald.central.piccoli condomini'
           , '&nbsp;') as desc_tariffa
         , nvl(iter_edit.data(a.data_ultim_dich),'&nbsp;') as data_ult
         , nvl(iter_edit.data(a.data_prima_dich),'&nbsp;') as data_pri
         , nvl(iter_edit.data(a.data_installaz),'&nbsp;') as data_insta
         , nvl(iter_edit.data(a.data_attivaz),'&nbsp;') as data_att
         , nvl(iter_edit.data(a.data_rottamaz),'&nbsp;') as data_rott
         , nvl(iter_edit.num(a.potenza, 2),'&nbsp;') as potenza
         , nvl(iter_edit.num(a.potenza_utile, 2),'&nbsp;') as potenza_utile
         , nvl(iter_edit.num(a.consumo_annuo, 2),'&nbsp;') as consumo_annuo
         , nvl(iter_edit.num(a.n_generatori, 0),'&nbsp;') as n_generatori
         , nvl(iter_edit.num(a.volimetria_risc, 0),'&nbsp;') as volimetria_risc
         , nvl(b.descr_cted,'&nbsp;') as descr_cted
         , nvl(c.descr_comb,'&nbsp;') as comb
         , nvl(d.descr_tpim,'&nbsp;') as descr_tpim
         , nvl(e.descr_tppr,'&nbsp;') as descr_prov
         , f.descr_imst as desc_stato
      from coimaimp a
         , coimcted b
         , coimcomb c
         , coimtpim d
         , coimtppr e
         , coimimst f
     where a.cod_impianto         = :cod_impianto
       and b.cod_cted         (+) = a.cod_cted
       and c.cod_combustibile (+) = a.cod_combustibile
       and d.cod_tpim         (+) = a.cod_tpim
       and e.cod_tppr         (+) = a.provenienza_dati
       and e.cod_imst             = a.stato
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_si_viae">
       <querytext>
    select nvl(b.descr_topo,'')||' '||nvl(b.descrizione,'')||' '||nvl(a.numero,'')||' '||nvl(a.esponente,'')||' '||nvl(a.scala,'')||' '||nvl(a.piano,'')||' '||nvl(a.interno,'') as indir
         , nvl(a.cap,'') as cap
         , c.denominazione as nome_comu
         , d.sigla
         , a.cod_impianto_est
         , a.pdr
         , a.pod
      from coimaimp a
         , coimviae b
         , coimcomu c
         , coimprov d
     where a.cod_impianto      = :cod_impianto
       and b.cod_via       (+) = a.cod_via
       and b.cod_comune    (+) = a.cod_comune
       and c.cod_comune    (+) = a.cod_comune
       and d.cod_provincia (+) = a.cod_provincia
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_no_viae">
       <querytext>
    select nvl(a.toponimo,'')||' '||nvl(a.indirizzo,'')||' '||nvl(a.numero,'')||' '||nvl(a.esponente,'')||' '||nvl(a.scala,'')||' '||nvl(a.piano,'')||' '||nvl(a.interno,'') as indir
         , nvl(a.cap,'') as cap
         , c.denominazione as nome_comu
         , d.sigla
         , a.cod_impianto_est
         , a.pdr
         , a.pod
      from coimaimp a
         , coimcomu c
         , coimprov d
     where a.cod_impianto      = :cod_impianto
       and c.cod_comune    (+) = a.cod_comune
       and d.cod_provincia (+) = a.cod_provincia
       </querytext>
    </fullquery>

    <fullquery name="sel_stub_si_viae">
       <querytext>
    select iter_edit.data(a.data_fin_valid) as data_fin_valid
         , nvl(b.descr_topo,'')||' '||nvl(b.descrizione,'')||' '||nvl(a.numero,'')||' '||nvl(a.esponente,'')||' '||nvl(a.scala,'')||' '||nvl(a.piano,'')||' '||nvl(a.interno,'') as indir
         , nvl(a.cap,'') as cap
         , c.denominazione as nome_comu
         , d.sigla
      from coimstub a
         , coimviae b
         , coimcomu c
         , coimprov d
     where a.cod_impianto = :cod_impianto
       and b.cod_via       (+) = a.cod_via
       and b.cod_comune    (+) = a.cod_comune
       and c.cod_comune    (+) = a.cod_comune
       and d.cod_provincia (+) = a.cod_provincia
    order by a.data_fin_valid desc
       </querytext>
    </fullquery>

    <fullquery name="sel_stub_no_viae">
       <querytext>
    select iter_edit.data(a.data_fin_valid) as data_fin_valid
         , nvl(a.toponimo,'')||' '||nvl(a.indirizzo,'')||' '||nvl(a.numero,'')||' '||nvl(a.esponente,'')||' '||nvl(a.scala,'')||' '||nvl(a.piano,'')||' '||nvl(a.interno,'') as indir
         , nvl(a.cap,'') as cap
         , c.denominazione as nome_comu
         , d.sigla
      from coimstub a
         , coimcomu c
         , coimprov d
     where a.cod_impianto = :cod_impianto
       and c.cod_comune    (+) = a.cod_comune
       and d.cod_provincia (+) = a.cod_provincia
    order by a.data_fin_valid desc
       </querytext>
    </fullquery>

    <fullquery name="sel_resp">
       <querytext>
    select nvl(b.cognome,'')||' '||nvl(b.nome,'') as nome_resp
         , nvl(b.indirizzo,'')||' '||nvl(b.numero,'') as indir_r
         , nvl(b.comune,'') as nome_comu_r
         , nvl(b.provincia,'') as sigla_r
         , nvl(b.cap,'') as cap_r
      from coimaimp a
         , coimcitt b
     where a.cod_impianto = :cod_impianto
       and b.cod_cittadino (+) = a.cod_responsabile
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_3">
       <querytext>
    select nvl(b.cognome,'')||' '||nvl(b.nome,'') as nome_inte
         , nvl(b.indirizzo,'')||' '||nvl(b.numero,'') as indir_i
         , nvl(b.comune,'') as nome_comu_i
         , nvl(b.provincia,'') as sigla_i
         , nvl(b.cap,'') as cap_i
         , nvl(c.cognome,'')||' '||nvl(c.nome,'') as nome_prop
         , nvl(c.indirizzo,'')||' '||nvl(c.numero,'') as indir_p
         , nvl(c.comune,'') as nome_comu_p
         , nvl(c.provincia,'') as sigla_p
         , nvl(c.cap,'') as cap_p
         , nvl(d.cognome,'')||' '||nvl(d.nome,'') as nome_occu
         , nvl(d.indirizzo,'')||' '||nvl(d.numero,'') as indir_o
         , nvl(d.comune,'') as nome_comu_o
         , nvl(d.provincia,'') as sigla_o
         , nvl(d.cap,'') as cap_o
         , nvl(e.cognome,'')||' '||nvl(e.nome,'') as nome_ammi
         , nvl(e.indirizzo,'')||' '||nvl(e.numero,'') as indir_a
         , nvl(e.comune,'') as nome_comu_a
         , nvl(e.provincia,'') as sigla_a
         , nvl(e.cap,'') as cap_a
         , nvl(f.cognome,'')||' '||nvl(f.nome,'') as nome_resp
         , nvl(f.indirizzo,'')||' '||nvl(f.numero,'') as indir_r
         , nvl(f.comune,'') as nome_comu_r
         , nvl(f.provincia,'') as sigla_r
         , nvl(f.cap,'') as cap_r
      from coimaimp a
         , coimcitt b
         , coimcitt c
         , coimcitt d
         , coimcitt e
         , coimcitt f
     where a.cod_impianto = :cod_impianto
       and b.cod_cittadino (+) = a.cod_intestatario
       and c.cod_cittadino (+) = a.cod_proprietario
       and d.cod_cittadino (+) = a.cod_occupante
       and e.cod_cittadino (+) = a.cod_amministratore
       and f.cod_cittadino (+) = a.cod_responsabile
       </querytext>
    </fullquery>

    <fullquery name="sel_rife">
       <querytext>
    select iter_edit.data(a.data_fin_valid) as data_fin_valid
         , nvl(b.cognome,'')||' '||nvl(b.nome,'') as nome_sogg
         , nvl(b.indirizzo,'')||' '||nvl(b.numero,'') as indir_s
         , nvl(b.comune,'') as nome_comu_s
         , nvl(b.provincia,'') as sigla_s
         , nvl(b.cap,'') as cap_s
         , decode (a.ruolo
           , 'P' , 'Proprietario'
           , 'O' , 'Occupante'
           , 'A' , 'Amministratore'
           , 'R' , 'Responsabile'
           , 'I' , 'Intestatario'
           , '&nbsp;') as desc_ruolo
      from coimrife a
         , coimcitt b
     where a.cod_impianto = :cod_impianto
       and a.ruolo       in ('P', 'O', 'A', 'R', 'I')
       and b.cod_cittadino (+) = a.cod_soggetto
    order by a.data_fin_valid desc
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_4">
       <querytext>
    select nvl(b.cognome,'')||' '||nvl(b.nome,'') as nome_manu
         , nvl(b.indirizzo,'') as indir_m
         , nvl(b.comune,'') as nome_comu_m
         , nvl(b.provincia,'') as sigla_m
         , nvl(b.cap,'') as cap_m
         , nvl(c.cognome,'')||' '||nvl(c.nome,'') as nome_inst
         , nvl(c.indirizzo,'') as indir_i
         , nvl(c.comune,'') as nome_comu_i
         , nvl(c.provincia,'') as sigla_i
         , nvl(c.cap,'') as cap_i
         , nvl(d.ragione_01,'') as nome_dist
         , nvl(d.indirizzo,'')||' '||nvl(d.numero,'') as indir_d
         , nvl(d.comune,'') as nome_comu_d
         , nvl(d.provincia,'') as sigla_d
         , nvl(d.cap,'') as cap_d
         , nvl(e.cognome,'')||' '||nvl(e.nome,'') as nome_prog
         , nvl(e.indirizzo,'') as indir_g
         , nvl(e.comune,'') as nome_comu_g
         , nvl(e.provincia,'') as sigla_g
         , nvl(e.cap,'') as cap_g
      from coimaimp a
         , coimmanu b
         , coimmanu c
         , coimdist d
         , coimprog e
     where a.cod_impianto = :cod_impianto
       and b.cod_manutentore (+) = a.cod_manutentore
       and c.cod_manutentore (+) = a.cod_installatore
       and d.cod_distr       (+) = a.cod_distributore
       and e.cod_progettista (+) = a.cod_progettista
       </querytext>
    </fullquery>

    <fullquery name="sel_rife_2">
       <querytext>
    select iter_edit.data(a.data_fin_valid) as data_fin_valid
         , nvl(b.cognome,'')||' '||nvl(b.nome,'') as nome_sogg
         , nvl(b.indirizzo,'')||' '||nvl(b.numero,'') as indir_s
         , nvl(b.comune,'') as nome_comu_s
         , nvl(b.provincia,'') as sigla_s
         , nvl(b.cap,'') as cap_s
         , decode (a.ruolo
           , 'P' , 'Manutentore'
           , 'O' , 'Installatore'
           , 'A' , 'Distributore'
           , 'R' , 'Progettista'
           , '&nbsp;') as desc_ruolo
      from coimrife a
         , coimcitt b 
     where a.cod_impianto = :cod_impianto
       and a.ruolo       in ('M', 'I', 'D', 'G')
       and b.cod_cittadino = a.cod_soggetto
    order by a.data_fin_valid desc
       </querytext>
    </fullquery>

    <fullquery name="sel_gend">
       <querytext>
    select a.gen_prog_est
         , nvl(a.matricola,'&nbsp;') as matricola
         , nvl(a.modello,'&nbsp;') as modello
         , nvl(b.descr_comb,'&nbsp;') as descr_comb
         , nvl(iter_edit.data(a.data_installaz),'&nbsp;') as data_installaz
         , nvl(iter_edit.num(a.pot_focolare_lib, 2),'&nbsp;') as pot_focolare_lib
         , nvl(c.descr_cost, '&nbsp') as costruttore_gend
      from coimgend a
         , coimcomb b
         , coimcost c
     where a.cod_impianto = :cod_impianto
       and a.flag_attivo    = 'S'
       and b.cod_combustibile (+) = a.cod_combustibile
       and c.cod_cost         (+) = a.cod_cost
    order by a.gen_prog_est
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp">
       <querytext>
    select decode (a.flag_status
           , 'P' , 'Positivo'
           , 'N' , 'Negativo'
           , '&nbsp;') as desc_status
         , nvl(a.n_prot,'&nbsp;') as n_prot
         , nvl(iter_edit.data(a.data_controllo),'&nbsp;') as data_controllo
         , nvl(iter_edit.data(a.data_prot),'&nbsp;') as data_prot
         , nvl(a.num_bollo,'&nbsp;') as num_bollo
      from coimdimp a
     where a.cod_impianto = :cod_impianto
    order by a.data_controllo desc
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp">
       <querytext>
    select cod_cimp
         , case when a.esito_verifica = 'P' then 'Positivo'
                when a.esito_verifica = 'N' then 'Negativo'
                else '&nbsp;'
           end as desc_esito
         , nvl(a.verb_n,'&nbsp;') as verb_n
         , nvl(iter_edit.data(a.data_controllo),'&nbsp;') as data_controllo
         , nvl(iter_edit.data(a.data_verb),'&nbsp;') as data_verb
         , nvl(iter_edit.num(a.costo, 2),'&nbsp;') as costo_verifica
         , nvl(b.cognome,'')||' '||nvl(b.nome,'') as nome_opve
      from coimcimp a
         , coimopve b
     where a.cod_impianto = :cod_impianto
       and b.cod_opve (+) = a.cod_opve
    order by a.data_controllo desc
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
  order by to_number(a.prog_anom, '99999999')
       </querytext>
    </fullquery>

    <fullquery name="sel_inco">
       <querytext>
    select decode (a.esito
           , 'P' , 'Positivo'
           , 'N' , 'Negativo'
           , '&nbsp;') as desc_esito
         , d.descr_inst as desc_stato
         , nvl(iter_edit.data(a.data_verifica),'&nbsp;') as data_verifica
         , nvl(substr(a.ora_verifica,1,5),'&nbsp;') as ora_verifica
         , nvl(b.cognome,'')||' '||nvl(b.nome,'') as nome_opve
         , nvl(c.descrizione,'&nbsp;') as desc_camp
      from coiminco a
         , coimopve b
         , coimcinc c
         , coiminst d
     where a.cod_impianto = :cod_impianto
       and c.cod_cinc     = a.cod_cinc
       and b.cod_opve (+) = a.cod_opve
       and d.cod_inst     = a.stato
   order by c.data_inizio desc
       , a.data_verifica desc
       </querytext>
    </fullquery>

    <fullquery name="sel_movi">
       <querytext>
    select decode (a.tipo_movi
           , 'P' , 'Positivo'
           , 'N' , 'Negativo'
           , '&nbsp;') as desc_movi
         , nvl(iter_edit.data(a.data_scad),'&nbsp;') as data_scad
         , nvl(iter_edit.num(a.importo, 2),'&nbsp;') as importo
         , nvl(iter_edit.data(a.data_pag),'&nbsp;') as data_pag
         , nvl(iter_edit.num(a.importo_pag, 2),'&nbsp;') as importo_pag
         , decode (a.tipo_pag
           , 'BO' , 'Bollino prepagato'
           , 'BP' , 'Bollettino postale'
           , 'CN' , 'Contante a sportello ente gestore'
           , '&nbsp;') as desc_pag
      from coimmovi a
     where a.cod_impianto = :cod_impianto
   order by a.data_scad desc
       </querytext>
    </fullquery>

    <fullquery name="sel_prvv">
       <querytext>
    select decode (a.causale
           , 'MC' , 'Mancato pagamento'
           , 'SN' , 'Sanzione per inadempienza sull''impianto'
           , 'GE' , 'Generico'
           , '&nbsp;') as desc_causale
         , nvl(iter_edit.data(a.data_provv),'&nbsp;') as data_provv
      from coimprvv a
     where a.cod_impianto = :cod_impianto
   order by a.data_provv desc
       </querytext>
    </fullquery>

    <fullquery name="sel_todo">
       <querytext>
    select b.descrizione as desc_tipologia
         , decode (a.flag_evasione
           , 'E' , 'Evaso'
           , 'N' , 'Non Evaso'
           , 'A' , 'Annullato'
           , '&nbsp;') as desc_evasione
         , nvl(iter_edit.data(a.data_evasione),'&nbsp;') as data_evasione
      from coimtodo a
         , coimtpdo b
     where a.cod_impianto = :cod_impianto
       and b.cod_tpdo = a.tipologia
   order by a.data_evasione desc
       </querytext>
    </fullquery>

</queryset>
