<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_d_tano">
       <querytext>
                insert
                  into coim_d_tano 
                     ( cod_tano
                     , descr_tano
                     , descr_breve
                     , data_ins
                     , utente
                     , flag_scatenante
                     , norma
                     , flag_stp_esito
                     , gg_adattamento
                     , flag_report
                     , flag_modello
                     , data_fine_valid
                     , clas_funz)
                values 
                     (:cod_tano
                     ,:descr_tano
                     ,:descr_breve
                     ,current_date
                     ,:id_utente
                     ,:flag_scatenante
                     ,:norma
                     ,:flag_stp_esito
                     ,:gg_adattamento
                     ,:flag_report
                     ,:flag_modello
                     ,:data_fine_valid
                     ,:clas_funz)
       </querytext>
    </partialquery>

    <partialquery name="upd_d_tano">
       <querytext>
                update coim_d_tano
                   set descr_tano      = :descr_tano
                     , descr_breve     = :descr_breve
                     , data_mod        = current_date
                     , utente          = :id_utente
                     , flag_scatenante = :flag_scatenante
                     , norma           = :norma
                     , flag_stp_esito  = :flag_stp_esito
                     , gg_adattamento  = :gg_adattamento
                     , flag_report     = :flag_report
                     , flag_modello    = :flag_modello
                     , data_fine_valid = :data_fine_valid
                     , clas_funz       = :clas_funz
                 where cod_tano = :cod_tano
       </querytext>
    </partialquery>

    <partialquery name="del_d_tano">
       <querytext>
                delete
                  from coim_d_tano
                 where cod_tano = :cod_tano
       </querytext>
    </partialquery>

    <fullquery name="sel_d_tano">
       <querytext>
             select cod_tano
                  , descr_tano
                  , descr_breve
                  , iter_edit_data(data_ins) as data_ins
                  , iter_edit_data(data_mod) as data_mod
                  , utente
                  , flag_scatenante
                  , norma
                  , flag_stp_esito
                  , iter_edit_num(gg_adattamento, 0) as gg_adattamento
                  , flag_report
                  , flag_modello
                  , iter_edit_data(data_fine_valid) as data_fine_valid
                  , clas_funz
              from coim_d_tano
             where cod_tano  = :cod_tano			
  </querytext>
    </fullquery>

    <fullquery name="sel_d_tano_check">
       <querytext>
        select '1'
          from coim_d_tano
         where cod_tano = :cod_tano
       </querytext>
    </fullquery>
    
    <fullquery name="sel_d_clas">
       <querytext>
        select '1'
          from coim_d_clas
         where clas_funz = :clas_funz
       </querytext>
    </fullquery>

    <fullquery name="sel_d_anom_count">
        <querytext>
         select count(*) as conta_anom
           from coim_d_anom
          where cod_tanom = :cod_tano
       </querytext>
    </fullquery>

</queryset>
