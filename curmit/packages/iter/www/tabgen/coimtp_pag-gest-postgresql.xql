<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_tp_pag">
       <querytext>
                insert
                  into coimtp_pag 
                     ( cod_tipo_pag
                     , descrizione
                     , ordinamento
                     , data_ins
                     , utente)
                values 
                     (upper(:cod_tipo_pag)
                     ,upper(:descrizione)
                     ,:ordinamento
                     , current_date
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_tp_pag">
       <querytext>
                update coimtp_pag
                   set descrizione = upper(:descrizione)
                      ,ordinamento = :ordinamento
                      ,data_mod   =  current_date
                      ,utente     = :id_utente
                 where cod_tipo_pag = upper(:cod_tipo_pag)
       </querytext>
    </partialquery>

    <partialquery name="del_tp_pag">
       <querytext>
                delete
                  from coimtp_pag
                 where cod_tipo_pag = upper(:cod_tipo_pag)
       </querytext>
    </partialquery>

    <fullquery name="sel_tp_pag">
       <querytext>
             select descrizione
                  , ordinamento
               from coimtp_pag
              where cod_tipo_pag = upper(:cod_tipo_pag)
       </querytext>
    </fullquery>

    <fullquery name="sel_tp_pag_2">
       <querytext>
             select count(*) as conta
               from coimtp_pag
              where cod_tipo_pag = upper(:cod_tipo_pag)
             $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_tp_pag_check">
       <querytext>
        select '1'
          from coimtp_pag
         where cod_tipo_pag = upper(:cod_tipo_pag)
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_check">
       <querytext>
        select '1'
          from coimdimp
         where tipologia_costo = upper(:cod_tipo_pag)
        limit 1
       </querytext>
    </fullquery>

</queryset>

