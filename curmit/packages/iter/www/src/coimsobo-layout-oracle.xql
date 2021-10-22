<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_boll">
       <querytext>
select b.cognome
     , b.nome
     , b.indirizzo
     , b.comune
     , b.cap
     , b.provincia
     , a.nr_bollini 
     , iter_edit.data(data_scadenza) as data_scadenza_edit
  from coimboll a 
     , coimmanu b
 where (   a.pagati is null
        or a.pagati = 'N')
   and a.data_scadenza < current_date
   and b.cod_manutentore = a.cod_manutentore
       </querytext>
    </fullquery>

    <partialquery name="ins_docu">
       <querytext>
                insert
                  into coimdocu 
                     ( cod_documento
                     , tipo_documento
                     , data_documento
                     , data_ins
                     , data_mod
                     , utente)
                values 
                     (:cod_documento
                     ,:tipo_documento
                     ,current_date
                     ,current_date
                     ,current_date
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_docu">
       <querytext>
                   update coimdocu
                      set data_documento = current_date
                        , data_mod       = current_date
                        , utente         = :id_utente
                    where cod_documento  = :cod_documento
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

    <fullquery name="sel_docu_next">
        <querytext>
           select nextval('coimdocu_s') as cod_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_contenuto">
       <querytext>
          select contenuto as docu_contenuto_check
            from coimdocu
           where cod_documento = :cod_documento
       </querytext>
    </fullquery>


</queryset>
