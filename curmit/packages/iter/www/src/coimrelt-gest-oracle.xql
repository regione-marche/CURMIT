<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_tano">
       <querytext>
           select cod_tano
             from coimtano
         order by cod_tano
       </querytext>
    </fullquery>
  
    <partialquery name="ins_relt">
       <querytext>
           insert
             into coimrelt 
                ( cod_relg
                , cod_relt
                , sezione
                , id_clsnc
                , id_stclsnc
                , obj_refer
                , id_pot
                , id_per
                , id_comb
                , n
                , data_ins
                , data_mod
                , utente)
           values 
                (:cod_relg
                ,:cod_relt
                ,:sezione
                ,:id_clsnc
                ,:id_stclsnc
                ,:obj_refer
                ,:id_pot
                ,:id_per
                ,:id_comb
                ,:n
                , sysdate
                , null
                ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_relt">
       <querytext>
           update coimrelt
              set n          = :n
                , data_mod   =  sysdate
                , utente     = :id_utente
            where cod_relg   = :cod_relg
              and cod_relt   = :cod_relt
       </querytext>
    </partialquery>

    <partialquery name="del_relt">
       <querytext>
           delete
             from coimrelt
            where cod_relg   = :cod_relg
              and cod_relt   = :cod_relt
       </querytext>
    </partialquery>

    <fullquery name="sel_relt">
       <querytext>
           select sezione
                , id_clsnc
                , id_stclsnc
                , obj_refer
                , id_pot
                , id_per
                , id_comb
                , iter_edit.num(n, 0) as n
             from coimrelt
            where cod_relg = :cod_relg
              and cod_relt = :cod_relt
       </querytext>
    </fullquery>

    <fullquery name="sel_relt_check">
       <querytext>
           select '1'
             from coimrelt
            where cod_relg   = :cod_relg
              and id_clsnc   = :id_clsnc
              and id_stclsnc = :id_stclsnc
              and obj_refer  = :obj_refer
              and id_pot     = :id_pot
              and id_per     = :id_per
              and id_comb    = :id_comb
       </querytext>
    </fullquery>

    <fullquery name="sel_relt_cod">
       <querytext>
           select nvl(max(cod_relt),0) + 1
             from coimrelt
            where cod_relg   = :cod_relg
       </querytext>
    </fullquery>

    <fullquery name="sel_relt_sum">
       <querytext>
           select nvl(sum(n),0)
             from coimrelt
            where cod_relg   = :cod_relg
	      and sezione    = :sezione
              and id_clsnc   = :id_clsnc
              and id_stclsnc = :id_stclsnc
              and obj_refer  = :obj_refer
       </querytext>
    </fullquery>

    <fullquery name="del_relt_cons">
       <querytext>
           delete
             from coimrelt
            where cod_relg   = :cod_relg
              and sezione    = :sezione
              and id_clsnc   = :id_clsnc
              and id_stclsnc = :id_stclsnc
              and obj_refer  = :obj_refer
	      and id_pot     = :id_pot
	      and id_per     = :id_per
	      and id_comb    = :id_comb
       </querytext>
    </fullquery>
</queryset>
