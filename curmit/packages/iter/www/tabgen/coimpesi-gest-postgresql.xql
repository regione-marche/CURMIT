<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="upd_pesi">
       <querytext>
                update coimpesi
                   set codice_esterno     = :codice_esterno
                     , descrizione_uten   = :descrizione_uten
                     , peso               = :peso
                     , cod_raggruppamento = :cod_raggruppamento
                 where nome_campo = :nome_campo
                   and tipo_peso  = :tipo_peso
       </querytext>
    </partialquery>

    <partialquery name="del_ragr">
       <querytext>
                delete
                  from coimpesi
                 where nome_campo = :nome_campo
                   and tipo_peso  = :tipo_peso
       </querytext>
    </partialquery>

    <fullquery name="sel_pesi">
       <querytext>
         select nome_campo
              , codice_esterno
              , descrizione_uten
              , descrizione_dimp
              , iter_edit_num(peso, 0) as peso
              , cod_raggruppamento
              , case tipo_peso
                 when 'N' then 'No'
                 when 'C' then 'N.C.'
                 when 'A' then 'N.A.'
                else ''
               end as tipo_peso_ed
           from coimpesi
          where nome_campo = :nome_campo
            and tipo_peso  = :tipo_peso
       </querytext>
    </fullquery>

</queryset>
