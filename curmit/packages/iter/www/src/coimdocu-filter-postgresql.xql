<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_resp">
       <querytext>
       select nome    as nome_resp
            , cognome as cogn_resp
         from coimcitt
        where cod_cittadino = :f_cod_sogg
       </querytext>
    </fullquery>

    <fullquery name="sel_count_sogg">
       <querytext>
       select count(*) as conta_sogg
         from coimcitt
        where cognome like upper(:f_cogn_resp)
          and nome    like upper(:f_nome_resp)
       </querytext>
    </fullquery>

    <fullquery name="get_cod_sogg">
       <querytext>
       select cod_cittadino as f_cod_sogg
         from coimcitt
        where cognome like upper(:f_cogn_resp)
          and nome    like upper(:f_nome_resp)
       </querytext>
    </fullquery>

    <fullquery name="get_cod_aimp">
       <querytext>
       select cod_impianto
         from coimaimp
        where cod_impianto_est = :f_cod_impianto_est
       </querytext>
    </fullquery>

    <fullquery name="get_nome_manu">
       <querytext>
       select cognome
            , nome 
         from coimmanu
        where cod_manutentore = :cod_manutentore
          and coalesce(flag_attivo,'S') <> 'N'
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
       select cod_manutentore as cod_manu_db
         from coimmanu
        where cognome   $eq_cognome
          and nome      $eq_nome
          and coalesce(flag_attivo, 'S') <> 'N'
       </querytext>
    </fullquery>
  
    <partialquery name="nominativo">
        <querytext>
	cognome||' '||coalesce(nome, '')
        </querytext>
    </partialquery> 


</queryset>
