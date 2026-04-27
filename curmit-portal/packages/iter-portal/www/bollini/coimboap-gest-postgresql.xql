<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_boll">
       <querytext>
select a.cod_bollini
     , iter_edit_data(a.data_consegna)   as data_consegna_edit
     , coalesce (b.cognome, ' ') ||' '|| coalesce (b.nome, ' ') as manutentore
     , a.cod_manutentore
     , a.matricola_da
     , a.matricola_a
  from coimboll a
  left outer join coimmanu b on b.cod_manutentore = a.cod_manutentore
 where cod_bollini = :cod_bollini
       </querytext>
    </partialquery>


    <partialquery name="ins_boap">
       <querytext>
                insert
                  into coimboap 
                     ( cod_boap
                     , cod_bollini
                     , cod_manutentore_da
                     , cod_manutentore_a
                     , nr_bollini
                     , matr_da
                     , matr_a
                     , note
                     , data_ins
                     , utente_ins)
                values 
                     (:cod_boap
                     ,:cod_bollini
                     ,:cod_manutentore
                     ,:f_cod_manu
                     ,:nr_bollini
                     ,:matr_da
                     ,:matr_a
                     ,:note
                     , current_date
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_boap">
       <querytext>
                update coimboap
                   set nr_bollini      = :nr_bollini
                     , matr_da    = :matr_da
                     , matr_a     = :matr_a
                     , note            = :note
                     , data_mod        = current_date
                     , utente_mod          = :id_utente
                 where cod_boap     = :cod_boap
       </querytext>
    </partialquery>

    <partialquery name="del_boap">
       <querytext>
                delete
                  from coimboap
                 where cod_boap = :cod_boap
       </querytext>
    </partialquery>

    <fullquery name="sel_boap">
       <querytext>
             select cod_boap
                  , cod_bollini
                  , iter_edit_num(a.nr_bollini, 0)      as nr_bollini
                  , a.matr_da
                  , a.matr_a
                  , a.note
                  , a.cod_manutentore_a as f_cod_manu
               from coimboap a
              where a.cod_boap      = :cod_boap
       </querytext>
    </fullquery>

    <fullquery name="sel_boap_check">
       <querytext>
        select '1'
          from coimboap
         where cod_boap = :cod_boap
       </querytext>
    </fullquery>

    <fullquery name="sel_dual_boap">
       <querytext>
        select nextval('coimboap_s') as cod_boap
       </querytext>
    </fullquery>


    <partialquery name="cognome_nome">
       <querytext>
             substr(coalesce(cognome,'')||' '||coalesce(nome,''),1,50)
       </querytext>
    </partialquery>

    
    <fullquery name="sel_manu">
       <querytext>
             select cod_manutentore as cod_manu_db
               from coimmanu
              where upper(cognome)   $eq_cognome
                and upper(nome)      $eq_nome
       </querytext>
    </fullquery>
    

</queryset>
