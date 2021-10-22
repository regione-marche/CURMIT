<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_as_resp">
       <querytext>
                insert
                  into coim_as_resp
                     ( cod_as_resp
                     , cod_impianto
                     , cod_legale_rapp
                     , data_inizio
                     , data_fine
                     , causale_fine
                     , toponimo
                     , indirizzo
                     , cod_via
                     , localita
                     , numero
                     , esponente
                     , scala
                     , piano
                     , interno
                     , cod_comune
                     , cod_responsabile
                     , potenza
                     , cod_utgi
                     , data_ins
                     , utente
                     , flag_tracciato
                     , nome_condominio
                     , flag_ammimp)
                values
                     (:cod_as_resp
                     ,:cod_impianto
                     ,:cod_legale_rapp
                     ,:data_inizio
                     ,:data_fine
                     ,:causale_fine
                     ,:toponimo
                     ,:indirizzo
                     ,:f_cod_via
                     ,:localita
                     ,:numero
                     ,:esponente
                     ,:scala
                     ,:piano
                     ,:interno
                     ,:cod_comune
                     ,:cod_responsabile
                     ,:potenza_gend_tot
                     ,:cod_utgi
                     ,current_date
                     ,:id_utente
                     ,:flag_tracciato
                     ,:nome_condominio
                     ,:flag_ammimp)
       </querytext>
    </partialquery>

    <partialquery name="upd_as_resp">
       <querytext>
                update coim_as_resp
                  set  cod_legale_rapp = :cod_legale_rapp
                     , data_inizio     = :data_inizio
                     , data_fine       = :data_fine
                     , causale_fine    = :causale_fine
                     , toponimo        = :toponimo
                     , indirizzo       = :indirizzo
                     , cod_via         = :f_cod_via
                     , localita        = :localita
                     , numero          = :numero
                     , esponente       = :esponente
                     , scala           = :scala
                     , piano           = :piano
                     , interno         = :interno
                     , cod_comune      = :cod_comune
                     , cod_responsabile = :cod_responsabile
                     , potenza          = :potenza_gend_tot
                     , cod_utgi         = :cod_utgi
                     , data_mod         = current_date
                     , utente           = :id_utente
                     , nome_condominio	= :nome_condominio
                     , flag_ammimp      = :flag_ammimp
                 where cod_as_resp      = :cod_as_resp
       </querytext>
    </partialquery>

    <partialquery name="del_as_resp">
       <querytext>
                delete
                  from coim_as_resp
                 where cod_as_resp = :cod_as_resp
       </querytext>
    </partialquery>

    <fullquery name="sel_as_resp">
       <querytext>
             select  a.cod_legale_rapp
                     , iter_edit_data(a.data_inizio) as data_inizio
                     , iter_edit_data(a.data_fine) as data_fine
                     , a.causale_fine
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
                     , a.nome_condominio
                     , iter_edit_num(a.potenza, 2) as potenza
                     , a.cod_utgi
                     , d.cognome as cognome_legale
                     , d.nome as nome_legale
                     , e.cognome as cognome_resp
                     , e.nome as nome_resp
                     , case
                        when a.data_inizio is null then 'fine'
                        else 'inizio'
                       end as swc_inizio_fine
                     , c.cod_impianto_est
                     , b.cod_distr as forn_energia
                     , a.potenza
                     , flag_ammimp
               from coim_as_resp a
    left outer join coimcitt d on d.cod_cittadino 	= a.cod_legale_rapp
    left outer join coimcitt e on e.cod_cittadino 	= a.cod_responsabile
    left outer join coimaimp c on c.cod_impianto    = a.cod_impianto
    left outer join coimdist b on b.cod_distr		= c.cod_distributore
              where a.cod_as_resp = :cod_as_resp
       </querytext>
    </fullquery>

    <fullquery name="sel_man">
       <querytext>
         select cognome as cognome_manu,
                nome as nome_manu,
                reg_imprese as reg_imprese_old,
                localita_reg as localita_reg_old,
                flag_a as flag_a_old,
                flag_b as flag_b_old,
                flag_c as flag_c_old,
                flag_d as flag_d_old,
                flag_e as flag_e_old,
                flag_f as flag_f_old,
                flag_g as flag_g_old,
                cert_uni_iso as cert_uni_iso_old,
                cert_altro as cert_altro_old
           from coimmanu where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_legale">
       <querytext>
            select cognome as cognome_legale,
                   nome as nome_legale
              from coimcitt
             where cod_cittadino = :cod_legale_rapp
       </querytext>
    </fullquery>
    
    <partialquery name="sel_ammi">
       <querytext>
            select cod_cittadino as cod_ammi_db
              from coimcitt
             where upper(cognome) $eq_cognome
               and upper(nome)    $eq_nome
               and cod_cittadino like 'AM%'
       </querytext>
    </partialquery>

    <fullquery name="sel_dual_cod_as_resp">
       <querytext>
        select nextval('coim_as_resp_s') as cod_as_resp
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
             select cod_manutentore
               from coimmanu
              where cognome   $eq_cognome
                and nome      $eq_nome
       </querytext>
    </fullquery>


    <fullquery name="sel_citt">
       <querytext>
             select cod_cittadino
               from coimcitt
              where cognome   $eq_cognome
                and nome      $eq_nome
       </querytext>
    </fullquery>

    <fullquery name="sel_viae">
       <querytext>
             select cod_via
               from coimviae
              where cod_comune  = :cod_comune
                and descrizione = upper(:indirizzo)
                and descr_topo  = upper(:toponimo)
                and cod_via_new is null
       </querytext>
    </fullquery>

    <partialquery name="upd_manu">
       <querytext>
                update coimmanu
                   set localita_reg = upper(:localita_reg)
                     , reg_imprese  = upper(:reg_imprese)
                     , flag_a       = :flag_a
                     , flag_b       = :flag_b
                     , flag_c       = :flag_c
                     , flag_d       = :flag_d
                     , flag_e       = :flag_e
                     , flag_f       = :flag_f
                     , flag_g       = :flag_g
                     , cert_uni_iso = upper(:cert_uni_iso)
                     , cert_altro   = upper(:cert_altro)
                 where cod_manutentore = :cod_manutentore
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp">
       <querytext>
		update coimaimp 
				set cod_responsabile 	= :cod_ammin
				, flag_resp = :flag_resp
				, cod_distributore	= :fornitore_energia
		where cod_impianto = :cod_impianto
       </querytext>
    </partialquery>

    <fullquery name="sel_aimp_ins_no_vie">
       <querytext>
          select a.cod_utgi,
                 b.cod_impianto_est,
                 b.indirizzo,
                 b.toponimo,
                 b.cod_comune,
                 b.numero,
                 b.esponente,
                 b.piano,
                 b.scala,
                 b.localita,
                 b.interno,
                 iter_edit_num(b.potenza, 2) as potenza,
                 b.cod_proprietario,
                 d.nome as nome_resp_old,
                 d.cognome as cognome_resp_old,
                 b.cod_distributore as forn_energia
            from coimgend a,
                 coimaimp b
       left outer join coimcitt d on d.cod_cittadino = b.cod_proprietario
           where a.cod_impianto = :cod_impianto
             and a.cod_impianto = b.cod_impianto
                limit 1
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_ins_vie">
       <querytext>
                select a.cod_utgi,
                       b.cod_impianto_est,
                       c.descrizione as indirizzo,
                       c.descr_topo as toponimo,
                       b.cod_comune,
                       b.numero,
                       b.esponente,
                       b.piano,
                       b.scala,
                       b.localita,
                       b.interno,
                       iter_edit_num(b.potenza, 2) as potenza,
                       b.cod_proprietario,
                       d.nome as nome_resp_old,
                       d.cognome as cognome_resp_old,
                       b.cod_distributore as forn_energia
                  from coimgend a,
                       coimaimp b
       left outer join coimcitt d on d.cod_cittadino = b.cod_proprietario
       left outer join coimviae c on c.cod_via = b.cod_via
                                  and c.cod_comune = b.cod_comune
                 where a.cod_impianto = :cod_impianto
                   and a.cod_impianto = b.cod_impianto
                     limit 1
       </querytext>
    </fullquery>

    <partialquery name="ins_gend_as">
       <querytext>
                insert
                  into coimgend_as_resp
                     ( cod_as_resp
                     , gen_prog
                     , cod_combustibile
                     , potenza)
                values
                     (:cod_as_resp
                     ,:gen_prog_db
                     ,:cod_comb_db
                     ,:potenza_db)
       </querytext>
    </partialquery>

</queryset>
