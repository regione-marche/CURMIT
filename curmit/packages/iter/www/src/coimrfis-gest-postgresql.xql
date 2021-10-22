<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_rfis">
       <querytext>
                insert
                  into coimrfis 
                     ( cod_rfis
                     , data_rfis
                     , num_rfis
                     , cod_sogg
                     , tipo_sogg
                     , imponibile
                     , perc_iva
                     , flag_pag
                     , data_ins
                     , matr_da
                     , matr_a
                     , n_bollini
                     , mod_pag
                     , nota
                     , id_utente)
                values 
                     (:cod_rfis
                     ,:data_rfis
                     ,:num_rfis
                     ,:cod_sogg
                     ,:tipo_sogg
                     ,:imponibile
                     ,:perc_iva
                     ,:flag_pag
                     , current_date
                     ,:matr_da
                     ,:matr_a
                     ,:n_bollini
                     ,:mod_pag
                     ,:nota
                     ,:id_utente)
       </querytext>
    </partialquery>

    <fullquery name="sel_cod_rfis">
       <querytext>
            select nextval('coimrfis_s') as cod_rfis
       </querytext>
    </fullquery>

    <partialquery name="upd_rfis">
       <querytext>
                update coimrfis
                   set data_rfis  = :data_rfis
                     , num_rfis   = :num_rfis
                     , cod_sogg   = :cod_sogg
                     , imponibile = :imponibile
                     , perc_iva   = :perc_iva
                     , flag_pag   = :flag_pag
                     , data_mod   = current_date
                     , matr_da    = :matr_da
                     , matr_a     = :matr_a
                     , n_bollini  = :n_bollini
                     , mod_pag    = :mod_pag
                     , nota       = :nota
                     , id_utente  = :id_utente
                 where cod_rfis = :cod_rfis
       </querytext>
    </partialquery>

    <partialquery name="del_rfis">
       <querytext>
                delete
                  from coimrfis
                 where cod_rfis = :cod_rfis
       </querytext>
    </partialquery>

    <fullquery name="sel_rfis">
       <querytext>
             select iter_edit_data(data_rfis) as data_rfis
                  , a.num_rfis
                  , a.cod_sogg
                  , a.tipo_sogg
                  , b.nome as nome_manu
                  , b.cognome as cognome_manu
                  , c.nome as nome_citt
                  , c.cognome as cognome_citt
                  , iter_edit_num(a.imponibile, 2) as imponibile
                  , iter_edit_num(a.perc_iva, 2) as perc_iva
                  , a.imponibile as imponibile_calc
                  , a.flag_pag
                  , a.matr_da
                  , a.matr_a
                  , a.n_bollini
                  , a.mod_pag
                  , a.nota
               from coimrfis a
                    left outer join coimmanu b on b.cod_manutentore = a.cod_sogg
                    left outer join coimcitt c on c.cod_cittadino   = a.cod_sogg
              where cod_rfis = :cod_rfis
       </querytext>
    </fullquery>

    <fullquery name="sel_rfis_check">
       <querytext>
        select '1'
          from coimrfis
         where cod_rfis = :cod_rfis
       </querytext>
    </fullquery>

    <fullquery name="sel_boll">
       <querytext>
             select cod_bollini
                  , iter_edit_num(a.nr_bollini, 0) as nr_bollini
                  , costo_unitario
                  , a.matricola_da
                  , a.matricola_a
                  , a.pagati
                  , a.cod_manutentore
                  , b.cognome as cognome_manu
                  , b.nome as nome_manu
               from coimboll a
		    left outer join coimmanu b on b.cod_manutentore = a.cod_manutentore
              where a.cod_bollini      = :cod_bollini
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp">
       <querytext>
             select nome as nome_citt
                  , cognome as cognome_citt
               from coimcitt
               where cod_cittadino = :cod_responsabile
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_est">
       <querytext>
             select cod_impianto_est
               from coimaimp
               where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_num_check">
       <querytext>
        select '1'
          from coimrfis
         where to_char(data_rfis, 'yyyy') =  to_char(to_date(:data_rfis,'yyyymmdd'), 'yyyy')
           and num_rfis = :num_rfis
         $where_mod
       </querytext>
    </fullquery>

    <fullquery name="sel_sogg_manu">
       <querytext>
             select cod_manutentore as cod_sogg_db
               from coimmanu
              where cognome   $eq_cognome
                and nome      $eq_nome
       </querytext>
    </fullquery>

    <fullquery name="sel_sogg_citt">
       <querytext>
             select cod_cittadino as cod_sogg_db
               from coimcitt
              where cognome   $eq_cognome
                and nome      $eq_nome
       </querytext>
    </fullquery>

</queryset>
