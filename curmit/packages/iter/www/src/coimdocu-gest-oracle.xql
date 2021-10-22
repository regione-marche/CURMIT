<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_docu_next">
        <querytext>
           select coimdocu_s.nextval as cod_documento
             from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_docu">
       <querytext>
                insert
                  into coimdocu 
                     ( cod_documento
                     , tipo_documento
                     , cod_impianto
                     , data_stampa
                     , data_documento
                     , data_prot_01
                     , protocollo_01
                     , data_prot_02
                     , protocollo_02
                     , flag_notifica
                     , descrizione
                     , data_notifica
                     , note)
                values 
                     (:cod_documento
                     ,:tipo_documento
                     ,:cod_impianto
                     ,:data_stampa
                     ,:data_documento
                     ,:data_prot_01
                     ,:protocollo_01
                     ,:data_prot_02
                     ,:protocollo_02
                     ,:flag_notifica
                     ,:descrizione
                     ,:data_notifica
                     ,:note)
       </querytext>
    </partialquery>

    <partialquery name="upd_docu">
       <querytext>
                update coimdocu
                   set tipo_documento = :tipo_documento
                     , data_stampa    = :data_stampa
                     , data_documento = :data_documento
                     , data_prot_01   = :data_prot_01
                     , protocollo_01  = :protocollo_01
                     , data_prot_02   = :data_prot_02
                     , protocollo_02  = :protocollo_02
                     , flag_notifica  = :flag_notifica
                     , descrizione    = :descrizione
                     , note           = :note
                     , data_notifica  = :data_notifica
                 where cod_documento  = :cod_documento
       </querytext>
    </partialquery>

    <partialquery name="upd_docu_ins_alle">
       <querytext>
                update coimdocu
                   set tipo_contenuto = :tipo_contenuto
                     , contenuto      = empty_blob()
                 where cod_documento  = :cod_documento
             returning contenuto
                  into :1                     
       </querytext>
    </partialquery> 

    <partialquery name="upd_docu_del_alle">
       <querytext>
                update coimdocu
                   set tipo_contenuto = null
                     , contenuto      = empty_blob()
                 where cod_documento  = :cod_documento
       </querytext>
    </partialquery>

    <partialquery name="del_docu">
       <querytext>
                delete
                  from coimdocu
                 where cod_documento = :cod_documento
       </querytext>
    </partialquery>

    <fullquery name="sel_docu">
       <querytext>
             select cod_documento
                  , tipo_documento
                  , iter_edit.data(data_stampa) as data_stampa
                  , iter_edit.data(data_documento) as data_documento
                  , iter_edit.data(data_notifica) as data_notifica
                  , iter_edit.data(data_prot_01) as data_prot_01
                  , protocollo_01
                  , iter_edit.data(data_prot_02) as data_prot_02
                  , protocollo_02
                  , flag_notifica
                  , descrizione
                  , note
               from coimdocu
              where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_tipo_contenuto">
       <querytext>
           select tipo_contenuto
             from coimdocu
            where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_alle">
       <querytext>
           select contenuto
             from coimdocu
            where cod_documento = [ns_dbquotevalue $cod_documento]
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_cod_est">
       <querytext>
       select cod_impianto_est
         from coimaimp
        where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_cod">
       <querytext>
       select cod_impianto
         from coimaimp
        where cod_impianto_est = :cod_impianto_est
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_resp">
       <querytext>
           select cod_responsabile as cod_soggetto
             from coimaimp
            where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <partialquery name="upd_aimp">
       <querytext>
	update coimaimp 
           set data_ultim_dich = :data_documento
             , data_mod        = sysdate
             , utente          = :id_utente
         where cod_impianto = :cod_impianto
       </querytext>
    </partialquery> 

    <fullquery name="sel_check_modh">
        <querytext>
           select count(*) as conta_mh
             from coimdimp 
            where cod_impianto = :cod_impianto
              and substr(data_controllo,1,4) = :anno_doc
       </querytext>
    </fullquery>

    <fullquery name="sel_dual_cod_dimp">
       <querytext>
        select coimdimp_s.nextval as cod_dimp
          from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_dimp">
       <querytext>
	insert into 
           coimdimp ( cod_dimp 
                    , cod_impianto
                    , data_controllo
                    , cod_documento
                    , n_prot
                    , data_prot
                    , osservazioni
                    , data_ins
                    , utente
                  ) values (
		     :cod_dimp
                    ,:cod_impianto
                    ,:data_documento
                    ,:cod_documento
                    ,:protocollo_02
                    ,:data_prot_02
                    ,'Modello H inserito attraverso acquisizione del documento originale'
                    ,sysdate
                    ,:id_utente
		  )
       </querytext>
    </partialquery> 

</queryset>
