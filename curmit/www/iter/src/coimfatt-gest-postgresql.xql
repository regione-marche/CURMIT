<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_fatt">
       <querytext>
                insert
                  into coimfatt 
                     ( cod_fatt
                     , data_fatt
                     , num_fatt
                     , cod_sogg
                     , tipo_sogg
                     , imponibile
             --gab01 , perc_iva
                     , flag_pag
                     , data_ins
                     , matr_da
                     , matr_a
                     , n_bollini
                     , mod_pag
                     , nota
                     , id_utente
                     , spe_postali --gab02
                     )
                values 
                     (:cod_fatt
                     ,:data_fatt
                     ,:num_fatt
                     ,:cod_sogg
                     ,:tipo_sogg
                     ,:imponibile
             --gab01 ,:perc_iva
                     ,:flag_pag
                     , current_date
                     ,:matr_da
                     ,:matr_a
                     ,:n_bollini
                     ,:mod_pag
                     ,:nota
                     ,:id_utente
                     ,:spe_postali --gab02
                     )
       </querytext>
    </partialquery>

    <fullquery name="sel_cod_fatt">
       <querytext>
            select nextval('coimfatt_s') as cod_fatt
       </querytext>
    </fullquery>

    <partialquery name="upd_fatt">
       <querytext>
                update coimfatt
                   set data_fatt  = :data_fatt
                     , num_fatt   = :num_fatt
                     , cod_sogg   = :cod_sogg
                     , imponibile = :imponibile
             --gab01 , perc_iva   = :perc_iva
                     , flag_pag   = :flag_pag
                     , data_mod   = current_date
                     , matr_da    = :matr_da
                     , matr_a     = :matr_a
                     , n_bollini  = :n_bollini
                     , mod_pag    = :mod_pag
                     , nota       = :nota
                     , id_utente  = :id_utente
                     , spe_postali = :spe_postali --gab02
                 where cod_fatt = :cod_fatt
       </querytext>
    </partialquery>

    <partialquery name="del_fatt">
       <querytext>
                delete
                  from coimfatt
                 where cod_fatt = :cod_fatt
       </querytext>
    </partialquery>

    <fullquery name="sel_fatt">
       <querytext>
             select iter_edit_data(data_fatt) as data_fatt
                  , a.num_fatt
                  , a.cod_sogg
                  , a.tipo_sogg
                  , b.nome as nome_manu
                  , b.cognome as cognome_manu
                  , c.nome as nome_citt
                  , c.cognome as cognome_citt
                  , iter_edit_num(a.imponibile, 2) as imponibile
          --gab01 , iter_edit_num(a.perc_iva, 2) as perc_iva
                  , a.imponibile as imponibile_calc
                  , a.flag_pag
                  , a.matr_da
                  , a.matr_a
                  , a.n_bollini
                  , a.mod_pag
                  , a.nota
                  , iter_edit_num(a.spe_postali,2) as spe_postali --gab02
               from coimfatt a
                    left outer join coimmanu b on b.cod_manutentore = a.cod_sogg
                    left outer join coimcitt c on c.cod_cittadino   = a.cod_sogg
              where cod_fatt = :cod_fatt
       </querytext>
    </fullquery>

    <fullquery name="sel_fatt_check">
       <querytext>
        select '1'
          from coimfatt
         where cod_fatt = :cod_fatt
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
                  , a.data_consegna
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
          from coimfatt
         where to_char(data_fatt, 'yyyy') =  to_char(to_date(:data_fatt,'yyyymmdd'), 'yyyy')
           and num_fatt = :num_fatt
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
