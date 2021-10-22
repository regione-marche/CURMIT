<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_todo">
       <querytext>
                insert
                  into coimtodo ( 
                       cod_todo
                     , cod_impianto
                     , cod_cimp_dimp
                     , tipologia
                     , note
                     , data_evento
                     , data_scadenza
                     , flag_evasione
                     , data_evasione)
                values (
                      :cod_todo
                     ,:cod_impianto
                     ,' '
                     ,:tipologia
                     ,:note
                     ,:data_evento
                     ,:data_scadenza
                     ,:flag_evasione
                     ,:data_evasione)
       </querytext>
    </partialquery>

    <partialquery name="upd_todo">
       <querytext>
                update coimtodo
                   set tipologia = :tipologia
                     , note = :note
                     , flag_evasione = :flag_evasione
                     , data_evasione = :data_evasione
                     , data_scadenza = :data_scadenza
                     , data_mod      = current_date
                     , utente        = :id_utente
                 where cod_todo = :cod_todo
       </querytext>
    </partialquery>

    <partialquery name="del_todo">
       <querytext>
                delete
                  from coimtodo
                 where cod_todo = :cod_todo
       </querytext>
    </partialquery>

    <fullquery name="sel_todo">
       <querytext>
             select cod_todo
                  , cod_impianto
                  , cod_cimp_dimp
                  , tipologia
                  , note
                  , flag_evasione
                  , iter_edit_data(data_evasione) as data_evasione
                  , iter_edit_data(data_scadenza) as data_scadenza
                  , iter_edit_data(data_evento)   as data_evento
               from coimtodo
              where cod_todo = :cod_todo
       </querytext>
    </fullquery>

    <fullquery name="sel_cod_todo_dual">
       <querytext>
        select nextval('coimtodo_s') as cod_todo
        </querytext>
    </fullquery>

    <fullquery name="sel_count_dettaglio">
       <querytext>
        select count(*) as count_dettaglio
          from $table
         where $key = :cod_cimp_dimp
       </querytext>
    </fullquery>


</queryset>
