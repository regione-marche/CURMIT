<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="iter_car_aces.sel_dist">
       <querytext>
                 select ragione_01||' '||coalesce(ragione_02, '') as nome_dist
                   from coimdist
                  where cod_distr = :cod_distr
       </querytext>
    </fullquery>

    <fullquery name="iter_car_aces.sel_indir">
       <querytext>
                 select descr_topo||' '||descr_estesa as indirizzo_xaps
                   from coimviae
                  where cod_via = lpad(:cod_via_aps,5,'0')
       </querytext>
    </fullquery>

    <fullquery name="iter_car_aces.sel_cod_comb">
       <querytext>
                 select cod_combustibile as cod_comb
                   from coimcomb
                  where upper(descr_comb) = upper(:cod_combustibile)
       </querytext>
    </fullquery>

    <fullquery name="iter_car_aces.sel_acts">
       <querytext>
                   select cod_distr
                        , to_char(data_caric, 'yyyymmdd') as data_caric
                     from coimacts
                    where cod_acts = :cod_acts_input
       </querytext>
    </fullquery>

    <partialquery name="iter_car_aces.set_where_cognome_nome">
       <querytext>
       and trim(trim(coalesce(cognome,''))||' '||trim(coalesce(nome,''))) =
           trim(trim(coalesce(:cognome,''))||' '||trim(coalesce(:nome,'')))
       </querytext>
    </partialquery>



    <fullquery name="iter_car_aces.sel_cods_acts">
       <querytext>
          select cod_acts as cod_acts_dif
	    from coimacts
	   where cod_distr = :cod_distr
	     and cod_acts  <> :cod_acts
       </querytext>
    </fullquery>

    <fullquery name="iter_car_aces.sel_aces_count">
       <querytext>
                   select count(*) as conta
                     from coimaces 
                      where 1=1 
                      $where_cod_acts
                      and cod_aces_est      $where_cod_aces_est
                      and cod_combustibile  $where_cod_combustibile
                      and natura_giuridica  = :natura_giuridica
                      $where_cognome_nome
                      and upper(indirizzo)  $where_indirizzo
                      and numero            $where_numero
                      and upper(comune)     $where_comune
                      and upper(provincia)  $where_provincia
                      and upper(cod_fiscale_piva)  $where_cod_fiscale_piva
                      and data_nas          $where_data_nas
                      and upper(comune_nas) $where_comune_nas
        </querytext>
    </fullquery>

    <partialquery name="iter_car_aces.ins_aces">
       <querytext>
                   insert
                     into coimaces
                        ( cod_aces
                        , cod_aces_est
                        , cod_acts
                        , natura_giuridica
                        , cod_combustibile
                        , cognome
                        , nome
                        , indirizzo
                        , numero
                        , esponente
                        , scala
                        , piano
                        , interno
                        , cap
                        , localita
                        , comune
                        , provincia
                        , cod_fiscale_piva
                        , telefono
                        , data_nas
                        , comune_nas
                        , consumo_annuo
                        , tariffa
                        , stato_01
                        , stato_02
                        , cod_cittadino
                        , cod_impianto
                        , data_ins
                        , utente)
                   values
                        ( :cod_aces
                        , $ins_cod_aces_est
			, :cod_acts_input
                        , upper(:natura_giuridica)
                        , upper(:cod_combustibile)
                        , upper(:cognome)
                        , upper(:nome)
                        , upper(:indirizzo)
                        , :numero
                        , upper(:esponente)
                        , upper(:scala)
                        , upper(:piano)
                        , upper(:interno)
                        , :cap
                        , upper(:localita)
                        , upper(:comune)
                        , upper(:provincia)
                        , upper(:cod_fiscale_piva)
                        , :telefono
                        , :data_nas
                        , upper(:comune_nas)
                        , :consumo_annuo
                        , :tariffa
                        , upper(:stato_01)
                        , upper(:stato_02)
                        , :cod_cittadino
                        , :cod_impianto
                        , :data_ins
                        , upper(:utente))
       </querytext>
    </partialquery>

    <fullquery name="iter_car_aces.sel_aces_2">
       <querytext>
              select nextval('coimaces_s') as cod_aces
        </querytext>
    </fullquery>

    <partialquery name="iter_car_aces.upd_acts">
       <querytext>
                 update coimacts
                    set caricati      = :ctr_caricati
                      , scartati      = :ctr_scartati
                      , invariati     = :ctr_invariati_t
                      , da_analizzare = :ctr_da_analizzare
                      , stato         = :stato_acts
                      , data_mod      =  current_date
                      , utente        = :id_utente
                  where cod_acts      = :cod_acts_input
                
       </querytext>
    </partialquery>

    <fullquery name="iter_car_aces.sel_count_aimp1">
       <querytext>
                   select count(*) as conta_aimp
                     from coimaimp 
                    where cod_amag       $where_cod_amag
                   $where_dist
       </querytext>
    </fullquery>

    <fullquery name="iter_car_aces.sel_count_aimp2">
       <querytext>
                   select count(*) as conta_aimp
                     from coimaimp a
                    where a.numero $where_numero
		   $where_via
                   $where_comu
                   $where_prov
       </querytext>
    </fullquery>

    <fullquery name="iter_car_aces.sel_cod_viae">
       <querytext>
                   select cod_via
                     from coimviae
	            where cod_comune = :cod_com
		    $where_topon_indiriz
       </querytext>
    </fullquery>

    <fullquery name="iter_car_aces.get_cod_comu">
       <querytext>
                   select cod_comune as cod_com
                     from coimcomu
		    where upper(denominazione) = upper(:comune)
       </querytext>
    </fullquery>

    <fullquery name="iter_car_aces.get_cod_prov">
       <querytext>
                   select cod_provincia as cod_prv
                     from coimprov
		    where upper(sigla) = upper(:provincia)
       </querytext>
    </fullquery>

    <fullquery name="iter_car_aces.sel_count_aimp3-1">
       <querytext>
                   select count(*) as conta_aimp1
                     from coimcitt a
                        , coimaimp b
                    where 1=1
		   $where_comu
		   $where_via
		   and b.numero            $where_numero
                   and a.natura_giuridica  = upper(:natura_giuridica)
                   $where_cogn_nome
                   $where_piva
                   and  b.cod_intestatario = a.cod_cittadino
       </querytext>
    </fullquery>

    <fullquery name="iter_car_aces.sel_count_aimp3-2">
       <querytext>
                   select count(*) as conta_aimp2
                     from coimcitt a
                        , coimaimp b
                    where 1=1
		   $where_comu
		   $where_via
		   and b.numero            $where_numero
                   and a.natura_giuridica  = upper(:natura_giuridica)
                   $where_cogn_nome
                   $where_piva
                   and b.cod_proprietario = a.cod_cittadino
       </querytext>
    </fullquery>

    <fullquery name="iter_car_aces.sel_count_aimp3-3">
       <querytext>
                   select count(*) as conta_aimp3
                     from coimcitt a
                        , coimaimp b
                    where 1=1
		   $where_comu
		   $where_via
		   and b.numero            $where_numero
                   and a.natura_giuridica  = upper(:natura_giuridica)
                   $where_cogn_nome
                   $where_piva
                   and  b.cod_occupante    = a.cod_cittadino
       </querytext>
    </fullquery>


</queryset>
