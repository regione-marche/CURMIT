<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_cimp_cod_impianto">
       <querytext>
           select cod_impianto
             from coimcimp
            where cod_cimp = :cod_cimp
       </querytext>
    </fullquery>

    <fullquery name="sel_enve_opve">
       <querytext>
           select nvl(e.ragione_01,'')
               || ' - '
               || nvl(o.cognome,'')
               || ' '
               || nvl(o.nome,'') as des_opve
                , o.cod_opve
             from coimopve o
                , coimenve e
            where e.cod_enve = o.cod_enve
           $where_enve_opve
         order by e.ragione_01
                , o.cognome
                , o.nome
                , o.cod_opve
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp">
       <querytext>
           select iter_edit.data(a.data_installaz) as aimp_data_installaz
                , a.potenza            as aimp_pot_focolare_nom
		, a.potenza_utile      as aimp_pot_utile_nom
		, a.cod_combustibile   as aimp_cod_combustibile
		, a.cod_responsabile   as aimp_cod_responsabile
		, a.flag_resp          as aimp_flag_resp
                , a.cod_occupante      as aimp_cod_occupante
                , a.cod_proprietario   as aimp_cod_proprietario
                , a.cod_intestatario   as aimp_cod_intestatario
                , a.cod_amministratore as aimp_cod_amministratore
		, b.cognome            as aimp_cogn_resp
		, b.nome               as aimp_nome_resp
                , decode (a.flag_resp
                      ,'P', 'il Proprietario'
                      ,'O', 'l''Occupante'
                      ,'A', 'l''Amministratore'
                      ,'I', 'l''Intestatario'
                      ,'T', 'un Terzo'
                      ,'Non noto'
                  )                  as aimp_flag_resp_desc
                , decode (a.cod_tpim
                      ,'A', 'Singola unit&agrave; immobiliare'
                      ,'C', 'Pi&ugrave; unit&agrave; immobiliari'
                      ,'0', 'Non noto'
                      ,'Non Noto;'
                  )                  as aimp_tipologia
                , c.descr_cted         as aimp_categoria_edificio
                , d.descr_tpdu         as aimp_dest_uso
             from coimaimp a
                , coimcitt b
                , coimcted c
                , coimtpdu d
            where a.cod_impianto      =  :cod_impianto
              and b.cod_cittadino (+) = a.cod_responsabile
              and c.cod_cted      (+) = a.cod_cted
              and d.cod_tpdu      (+) = a.cod_tpdu
       </querytext>
    </fullquery>

    <fullquery name="sel_pote_cod_potenza">
       <querytext>
           select cod_potenza
             from coimpote
            where potenza_min <= :h_potenza
              and potenza_max >= :h_potenza
       </querytext>
    </fullquery>

    <fullquery name="sel_tari">
       <querytext>
           select a.importo
             from coimtari a
            where a.cod_potenza = :cod_potenza
              and a.tipo_costo  = :tipo_costo
              and a.data_inizio = (select max(d.data_inizio) 
                                     from coimtari d 
                                    where d.cod_potenza  = :cod_potenza
                                      and d.tipo_costo   = :tipo_costo
                                      and d.data_inizio <=  sysdate)
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc">
       <querytext>
           select to_char(data_inizio,'yyyymmdd') as cinc_data_inizio
                , to_char(data_fine,'yyyymmdd')   as cinc_data_fine
             from coimcinc
            where cod_cinc = :cod_cinc
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_default">
       <querytext>
           select a.cod_inco
                , a.data_verifica
             from coiminco a
                , coimcinc b
            where a.cod_impianto =  :cod_impianto
              and b.cod_cinc     = a.cod_cinc
              and b.stato        =  '1'
         order by a.data_verifica desc
                , a.cod_inco      desc
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_inco_count">
       <querytext>
           select count(*)
             from coimcimp
            where cod_inco = :cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_inco">
       <querytext>
           select data_assegn
                , cod_cinc
                , cod_impianto  as inco_cod_impianto
                , iter_edit.data(data_verifica) as inco_data_verifica
                , cod_opve      as inco_cod_opve
             from coiminco
            where cod_inco = :cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_count_dup">
       <querytext>
           select count(*)
             from coimcimp
            where cod_impianto   = :cod_impianto
              and gen_prog      is  null
              and data_controllo = :data_controllo
           $where_cod_cimp
        </querytext>
    </fullquery>

    <fullquery name="sel_dual_cod_cimp">
       <querytext>
           select coimcimp_s.nextval as cod_cimp
             from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_cimp">
       <querytext>
           insert
             into coimcimp 
                ( cod_cimp
                , cod_impianto
                , cod_inco
                , data_controllo
                , cod_opve
                , costo
                , tipologia_costo
                , riferimento_pag
                , data_ins
                , utente
		, flag_tracciato
                )
           values 
                (:cod_cimp
                ,:cod_impianto
                ,:cod_inco
                ,:data_controllo
                ,:cod_opve
                ,:costo
                ,:tipologia_costo
                ,:riferimento_pag
		, sysdate
		,:id_utente
		,'MA'
                )
       </querytext>
    </partialquery>

    <fullquery name="sel_dual_cod_movi">
       <querytext>
           select coimmovi_s.nextval as cod_movi
             from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_movi">
       <querytext>
           insert
             into coimmovi 
                ( cod_movi
                , tipo_movi
                , cod_impianto
                , data_scad
                , data_compet
                , importo
                , importo_pag
                , riferimento
                , data_pag
                , tipo_pag
                , data_ins
                , utente)
           values 
                (:cod_movi
                ,'VC'
                ,:cod_impianto
                ,:data_scad_pagamento
                ,:data_controllo
                ,:costo
                ,:importo_pag
                ,:cod_cimp
                ,:data_pag
                ,:tipologia_costo
                , sysdate
                ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_movi">
       <querytext>
           update coimmovi
              set data_scad    = :data_scad_pagamento
                , data_compet  = :data_controllo
                , importo      = :costo
                , importo_pag  = :importo_pag
                , data_pag     = :data_pag
                , tipo_pag     = :tipologia_costo
                , data_mod     =  sysdate
                , utente       = :id_utente
            where cod_movi     = :cod_movi                 
       </querytext>
    </partialquery>

    <fullquery name="sel_movi_check">
       <querytext>
           select cod_movi 
             from coimmovi
            where riferimento  = :cod_cimp
              and cod_impianto = :cod_impianto
              and tipo_movi    = 'VC'
       </querytext>
    </fullquery>

    <partialquery name="upd_inco">
       <querytext>
           update coiminco
              set cod_opve      = :cod_opve
                , data_verifica = :data_controllo
                , stato         = '5'
                , data_assegn   = :data_assegn
		, note          = 'Effettuato ma responsabile o delegato non presente'
            where cod_inco      = :cod_inco                 
       </querytext>
    </partialquery>

    <partialquery name="upd_inco_old">
       <querytext>
           update coiminco
              set esito         =  null
            where cod_inco      = :cod_inco_old                 
       </querytext>
    </partialquery>

    <partialquery name="upd_cimp">
       <querytext>
           update coimcimp
              set cod_inco                  = :cod_inco
                , data_controllo            = :data_controllo
                , cod_opve                  = :cod_opve
                , costo                     = :costo
                , tipologia_costo           = :tipologia_costo
                , riferimento_pag           = :riferimento_pag
                , data_mod                  = sysdate
                , utente                    = :id_utente
            where cod_cimp          = :cod_cimp
       </querytext>
    </partialquery>

    <partialquery name="del_cimp">
       <querytext>
           delete
             from coimcimp
            where cod_cimp = :cod_cimp
       </querytext>
    </partialquery>

    <partialquery name="del_movi">
       <querytext>
          delete from coimmovi
           where tipo_movi   = 'VC'
             and riferimento = :cod_cimp
       </querytext>
    </partialquery>

    <fullquery name="sel_cimp">
       <querytext>
           select a.gen_prog
                , a.cod_inco
                , iter_edit.data(a.data_controllo) as data_controllo
                , a.cod_opve
                , iter_edit.num(a.costo, 2) as costo
                , a.tipologia_costo
                , a.riferimento_pag
                , iter_edit.data(b.data_scad) as data_scad
                , a.data_ins
                , case 
                      when importo_pag is null
                       and data_pag    is null
                      then 'N'
                      else 'S'
                  end         as flag_pagato
             from coimcimp a
                , coimmovi b
            where a.cod_cimp         = :cod_cimp
              and b.riferimento  (+) = a.cod_cimp
              and b.cod_impianto (+) = a.cod_impianto
              and b.tipo_movi    (+) = 'VC'
       </querytext>
    </fullquery>

</queryset>
