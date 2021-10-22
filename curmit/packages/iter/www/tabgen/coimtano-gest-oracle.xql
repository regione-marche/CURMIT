<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="ins_tano">
       <querytext>
                insert
                  into coimtano 
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
                update coimtano
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
                  from coimtano
                 where cod_tano = :cod_tano
       </querytext>
    </partialquery>

    <fullquery name="sel_tano">
       <querytext>
             select cod_tano
                  , descr_tano
                  , descr_breve
                  , iter_edit.data(data_ins) as data_ins
                  , iter_edit.data(data_mod) as data_mod
                  , utente
                  , flag_scatenante
                  , norma
                  , flag_stp_esito
                  , iter_edit.num(gg_adattamento, 0) as gg_adattamento
                  , flag_report
               from coimtano
              where cod_tano = :cod_tano
       </querytext>
    </fullquery>

    <fullquery name="sel_tano_check">
       <querytext>
        select '1'
          from coimtano
         where cod_tano = :cod_tano
       </querytext>
    </fullquery>
    
    <fullquery name="sel_anom_count">
        <querytext>
         select count(*) as conta_anom
           from coimanom
          where cod_tanom = :cod_tano
       </querytext>
    </fullquery>

</queryset>
