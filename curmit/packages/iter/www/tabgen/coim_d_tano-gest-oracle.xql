<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

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
                     , flag_report)
                values 
                     (:cod_tano
                     ,:descr_tano
                     ,:descr_breve
                     ,sysdate
                     ,:id_utente
                     ,:flag_scatenante
                     ,:norma
                     ,:flag_stp_esito
                     ,:gg_adattamento
                     ,:flag_report)
       </querytext>
    </partialquery>

    <partialquery name="upd_tano">
       <querytext>
                update coim_d_tano
                   set descr_tano      = :descr_tano
                     , descr_breve     = :descr_breve
                     , data_mod        = sysdate
                     , utente          = :id_utente
                     , flag_scatenante = :flag_scatenante
                     , norma           = :norma
                     , flag_stp_esito  = :flag_stp_esito
                     , gg_adattamento  = :gg_adattamento
                     , flag_report     = :flag_report
                 where cod_tano = :cod_tano
       </querytext>
    </partialquery>

    <partialquery name="del_tano">
       <querytext>
                delete
                  from coim_d_tano
                 where cod_tano = :cod_tano
       </querytext>
    </partialquery>

    <fullquery name="sel_d_tano">
       <querytext>
             select a.cod_tano
                  , a.descr_tano
                  , a.descr_breve
                  , iter_edit.data(a.data_ins) as data_ins
                  , iter_edit.data(a.data_mod) as data_mod
                  , a.utente
                  , a.flag_scatenante
                  , a.norma
                  , a.flag_stp_esito
                  , iter_edit.num(a.gg_adattamento, 0) as gg_adattamento
                  , a.flag_report
                  , a.clas_funz
                  , b.descrizione 
               from coim_d_tano a
                    coim_d-clas b             
              where a.cod_tano  = :cod_tano
                and b.clas_funz = a.clas-funz     
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
