<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="upd_aimp_tecn">
       <querytext>
           update coimaimp
              set cod_manutentore  = :cod_manutentore
                , cod_installatore = :cod_installatore
                , cod_distributore = :cod_distributore
                , cod_progettista  = :cod_progettista
                , cod_amag         = :cod_amag
                , data_mod         =  sysdate
                , utente           = :id_utente                 
            where cod_impianto     = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="ins_rife">
       <querytext>
           insert
             into coimrife 
                ( cod_impianto
                , ruolo
                , data_fin_valid
                , cod_soggetto
                , data_ins           
                , utente)             
           values
                (:cod_impianto
                ,:ruolo
                ,:data_fin_valid
                ,:db_cod_soggetto
                , sysdate        
                ,:id_utente)   
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_tecn">
       <querytext>
           select a.cod_impianto
                , a.cod_manutentore
                , a.cod_installatore
                , a.cod_distributore
                , a.cod_progettista
                , a.cod_amag
                , iter_edit.data(a.data_installaz)  as data_installaz
                , b.cognome as cognome_manu
                , b.nome    as nome_manu
                , c.cognome as cognome_inst
                , c.nome    as nome_inst
                , d.ragione_01 
                , e.cognome as cognome_prog
                , e.nome    as nome_prog
             from coimaimp a
                , coimmanu b
                , coimmanu c 
                , coimdist d
                , coimprog e
            where a.cod_impianto       =  :cod_impianto
              and b.cod_manutentore (+)= a.cod_manutentore
              and c.cod_manutentore (+)= a.cod_installatore
              and d.cod_distr       (+)= a.cod_distributore
              and e.cod_progettista (+)= a.cod_progettista
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
           select cod_manutentore as cod_manu_db
             from coimmanu
            where cognome $eq_cognome
              and nome    $eq_nome
       </querytext>
    </fullquery>

    <fullquery name="sel_prog">
       <querytext>
           select cod_progettista
             from coimprog
            where cognome $eq_cognome
              and nome    $eq_nome
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_db">
       <querytext>
           select cod_manutentore  as db_cod_manutentore
                , cod_installatore as db_cod_installatore
                , cod_distributore as db_cod_distributore
                , cod_progettista  as db_cod_progettista
                , cod_amag         as db_cod_amag
             from coimaimp 
            where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_rife_check">
       <querytext>
           select '1'
             from coimrife
            where cod_impianto   = :cod_impianto
              and ruolo          = :ruolo
              and data_fin_valid = :data_fin_valid
       </querytext>
    </fullquery>

    <fullquery name="sel_rife_max_data">
       <querytext>
           select to_char(max(data_fin_valid), 'yyyymmdd')
             from coimrife
            where cod_impianto  = :cod_impianto
              and ruolo        in ('M', 'I', 'D', 'G')
       </querytext>
    </fullquery>

    <fullquery name="sel_ruolo_manu">
       <querytext>
           select '1'
             from coimmanu
            where (cognome = upper(:cognome_manu) $eq_nome_manu)
              and (flag_ruolo = 'M' or flag_ruolo = 'T' or flag_ruolo is null) 
       </querytext>
    </fullquery>

    <fullquery name="sel_ruolo_inst">
       <querytext>
           select '1'
             from coimmanu
            where (cognome = upper(:cognome_inst) $eq_nome_inst)
              and (flag_ruolo = 'I' or flag_ruolo = 'T' or flag_ruolo is null) 
       </querytext>
    </fullquery>

</queryset>
