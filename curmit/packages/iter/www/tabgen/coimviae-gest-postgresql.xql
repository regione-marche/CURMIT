<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    gab01 02/05/2016 Aggiunta colonna cod_zona
-->

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="del_viae">
       <querytext>
                   delete
                     from coimviae
                    where cod_via    = :cod_via
                      and cod_comune = :cod_comune
       </querytext>
    </partialquery>

    <partialquery name="upd_viae">
       <querytext>
                   update coimviae
                      set descrizione  = trim(:descrizione)
                        , descr_topo   = trim(:descr_topo)
                        , descr_estesa = trim(:descr_estesa)
                        , cap          = :cap
                        , da_numero    = :da_numero
                        , a_numero     = :a_numero
                        , cod_qua      = :cod_qua
                        , cod_zona     = upper(trim(:cod_zona)) -- gab01
                    where cod_via      = :cod_via
                      and cod_comune   = :cod_comune
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp">
      <querytext>
	update coimaimp
	   set cod_qua    = :cod_qua
	 where cod_via    = :cod_via
	   and cod_comune = :cod_comune
      </querytext>
    </partialquery>


    <partialquery name="ins_viae">
       <querytext>
                   insert
                     into coimviae 
                        ( cod_via
                        , cod_comune
                        , descrizione
                        , descr_topo
                        , descr_estesa
			, cap
			, da_numero
			, a_numero
                        , cod_qua
                        , cod_zona --gab01
                        )
                   values 
                        (:cod_via
                        ,:cod_comune
                        ,trim(:descrizione)
                        ,trim(:descr_topo)
                        ,trim(:descr_estesa)
			,:cap
			,:da_numero
			,:a_numero
                        ,:cod_qua
                        ,upper(trim(:cod_zona)) --gab01
                        )
       </querytext>
    </partialquery>

    <fullquery name="sel_check_viae">
       <querytext>
                    select '1'
                      from coimviae
                     where cod_via    = upper(:cod_via)
                       and cod_comune = :cod_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_check_viae_2">
       <querytext>
                    select '1'
                      from coimviae
                     where cod_comune  = :cod_comune
                       and trim(descrizione) = trim(upper(:descrizione))
                       and trim(descr_topo)  = trim(upper(:descr_topo))
                       and cod_via_new is null
                     $where_cod
       </querytext>
    </fullquery>

    <fullquery name="sel_viae">
       <querytext>
                    select descrizione
                         , descr_topo
                         , descr_estesa	
			 , cap
			 , da_numero
			 , a_numero
                         , cod_qua
                         , cod_zona -- gab01
		      from coimviae
                     where cod_via    = :cod_via
                       and cod_comune = :cod_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp">
       <querytext>
                    select count(*) as conta_aimp
                      from coimaimp
                     where cod_via    = :cod_via
                       and cod_comune = :cod_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_cod">
        <querytext>
           select nextval('coimviae_s') as cod_via
       </querytext>
    </fullquery>

    <fullquery name="sel_comu">
       <querytext>
                    select denominazione as denom_comune
                      from coimcomu
                     where cod_comune = :cod_comune 
       </querytext>
    </fullquery>

    <fullquery name="sel_d_cqua">
       <querytext>
        select '1'
          from coimcqua
         where cod_qua    = :cod_qua
           and cod_comune = :cod_comune
       </querytext>
    </fullquery>

</queryset>
