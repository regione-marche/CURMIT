<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="ins_gend">
       <querytext>
                insert
                  into coimgend 
                     ( cod_impianto
                     , gen_prog
                     , descrizione
                     , matricola
                     , modello
                     , cod_cost
                     , matricola_bruc
                     , modello_bruc
                     , cod_cost_bruc
                     , tipo_foco
                     , mod_funz
                     , cod_utgi
                     , tipo_bruciatore
                     , tiraggio
                     , locale
                     , cod_emissione
                     , cod_combustibile
                     , data_installaz
                     , data_rottamaz
                     , pot_focolare_lib
                     , pot_utile_lib
                     , pot_focolare_nom
                     , pot_utile_nom
                     , flag_attivo
                     , note
                     , data_ins 
                     , utente
                     , gen_prog_est
                     , data_costruz_gen
                     , data_costruz_bruc
                     , data_installaz_bruc
                     , data_rottamaz_bruc
                     , marc_effic_energ
                     , campo_funzion_max
                     , campo_funzion_min
                     , dpr_660_96
		     )
                values 
                     (:cod_impianto
                     ,:gen_prog
                     ,:descrizione
                     ,:matricola
                     ,:modello
                     ,:cod_cost
                     ,:matricola_bruc
                     ,:modello_bruc
                     ,:cod_cost_bruc
                     ,:tipo_foco
                     ,:mod_funz
                     ,:cod_utgi
                     ,:tipo_bruciatore
                     ,:tiraggio
                     ,:locale
                     ,:cod_emissione
                     ,:cod_combustibile
                     ,:data_installaz
                     ,:data_rottamaz
                     ,:pot_focolare_lib
                     ,:pot_utile_lib
                     ,:pot_focolare_nom
                     ,:pot_utile_nom
                     ,:flag_attivo
                     ,:note
                     , sysdate
                     ,:id_utente
		     ,:gen_prog_est
                     ,:data_costruz_gen
                     ,:data_costruz_bruc
                     ,:data_installaz_bruc
                     ,:data_rottamaz_bruc
                     ,:marc_effic_energ
                     ,:campo_funzion_max
                     ,:campo_funzion_min
                     ,:dpr_660_96
		     )
       </querytext>
    </fullquery>

    <fullquery name="upd_gend">
       <querytext>
                update coimgend
                   set descrizione      = :descrizione
                     , matricola        = :matricola
                     , modello          = :modello
                     , cod_cost         = :cod_cost
                     , matricola_bruc   = :matricola_bruc
                     , modello_bruc     = :modello_bruc
                     , cod_cost_bruc    = :cod_cost_bruc
                     , tipo_foco        = :tipo_foco
                     , mod_funz         = :mod_funz
                     , cod_utgi     = :cod_utgi
                     , tipo_bruciatore  = :tipo_bruciatore
                     , tiraggio         = :tiraggio
                     , locale           = :locale
                     , cod_emissione      = :cod_emissione
                     , cod_combustibile = :cod_combustibile
                     , data_installaz   = :data_installaz
                     , data_rottamaz    = :data_rottamaz
                     , pot_focolare_lib = :pot_focolare_lib
                     , pot_utile_lib    = :pot_utile_lib
                     , pot_focolare_nom = :pot_focolare_nom
                     , pot_utile_nom    = :pot_utile_nom
                     , flag_attivo      = :flag_attivo
                     , note             = :note
                     , data_mod         =  sysdate
                     , utente           = :id_utente
		     , gen_prog_est     = :gen_prog_est
                     , data_costruz_gen     = :data_costruz_gen
                     , data_costruz_bruc    = :data_costruz_bruc
                     , data_installaz_bruc  = :data_installaz_bruc
                     , data_rottamaz_bruc   = :data_rottamaz_bruc
                     , marc_effic_energ     = :marc_effic_energ
                     , campo_funzion_max    = :campo_funzion_max
                     , campo_funzion_min    = :campo_funzion_min
                     , dpr_660_96           = :dpr_660_96
                 where cod_impianto = :cod_impianto
                   and gen_prog     = :gen_prog
       </querytext>
    </fullquery>

    <fullquery name="del_gend">
       <querytext>
                delete
                  from coimgend
                 where cod_impianto = :cod_impianto
                   and gen_prog     = :gen_prog
       </querytext>
    </fullquery>

    <fullquery name="upd_aimp">
       <querytext>
         update coimaimp
            set n_generatori = :count_gend
              , data_mod     =  sysdate
              , utente       = :id_utente
          where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="upd_aimp_potenza">
       <querytext>
         update coimaimp
            set potenza       = :tot_pot_focolare_nom
              , cod_potenza   = :cod_potenza
          where cod_impianto  = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="upd_aimp_potenza_utile">
       <querytext>
         update coimaimp
            set potenza_utile = :tot_pot_utile_nom
          where cod_impianto  = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_gend_count">
       <querytext>
         select count(*)              as count_gend
              , sum(pot_focolare_nom) as tot_pot_focolare_nom
              , sum(pot_utile_nom)    as tot_pot_utile_nom
           from coimgend
          where cod_impianto = :cod_impianto
            and flag_attivo  = 'S'
       </querytext>
    </fullquery>

    <fullquery name="sel_pote_cod">
       <querytext>
          select cod_potenza 
            from coimpote
           where :tot_pot_focolare_nom between potenza_min and potenza_max
       </querytext>
    </fullquery>

    <fullquery name="sel_gend">
       <querytext>
             select cod_impianto
                  , gen_prog
                  , descrizione
                  , matricola
                  , modello
                  , cod_cost
                  , matricola_bruc
                  , modello_bruc
                  , cod_cost_bruc
                  , tipo_foco
                  , mod_funz
                  , cod_utgi
                  , tipo_bruciatore
                  , tiraggio
                  , locale
                  , cod_emissione
                  , cod_combustibile
                  , iter_edit.data(data_installaz)     as data_installaz
                  , iter_edit.data(data_rottamaz)      as data_rottamaz
                  , iter_edit.num(pot_focolare_lib, 2) as pot_focolare_lib
                  , iter_edit.num(pot_utile_lib, 2)    as pot_utile_lib
                  , iter_edit.num(pot_focolare_nom, 2) as pot_focolare_nom
                  , iter_edit.num(pot_utile_nom, 2)    as pot_utile_nom
                  , flag_attivo
                  , note
                  , gen_prog_est
                  , iter_edit.data(data_costruz_gen)   as data_costruz_gen
                  , iter_edit.data(data_costruz_bruc)  as data_costruz_bruc
                  , iter_edit.data(data_installaz_bruc) as data_installaz_bruc
                  , iter_edit.data(data_rottamaz_bruc) as data_rottamaz_bruc
                  , marc_effic_energ
                  , iter_edit.num(campo_funzion_max,2) as campo_funzion_max
                  , iter_edit.num(campo_funzion_min,2) as campo_funzion_min
                  , dpr_660_96
               from coimgend
              where cod_impianto = :cod_impianto
                and gen_prog     = :gen_prog
       </querytext>
    </fullquery>

    <fullquery name="sel_gend_check">
       <querytext>
        select '1'
          from coimgend
         where cod_impianto = :cod_impianto
           and gen_prog_est = :gen_prog_est
	$where_gen_prog
       </querytext>
    </fullquery>

    <fullquery name="sel_gend_next_prog">
       <querytext>
        select nvl(max(gen_prog),0) + 1 as next_prog
          from coimgend
         where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_gend_next_prog_est">
       <querytext>
        select nvl(max(gen_prog_est),0) + 1 as next_prog_est
          from coimgend
         where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_check">
       <querytext>
        select count(*) as conta_cimp
          from coimcimp
         where cod_impianto = :cod_impianto
           and gen_prog     = :gen_prog
           and flag_tracciato <> 'MA'
       </querytext>
    </fullquery>

</queryset>
