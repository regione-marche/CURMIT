<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    gac01 20/12/2018 aggiunto nome e cognome dichiarante che mi servono quando chiamo la lista
    gac01            dalla coimnoveb (dichiarazione art.284)
-->
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_manu">
       <querytext>
       select cod_manutentore
            , a.cognome
            , a.nome
            , coalesce(a.cognome,'')||' '||coalesce(a.nome,'') as rag_soc
            , a.comune
            , a.provincia
            , a.indirizzo
            , a.telefono
            , a.cod_legale_rapp
            , coalesce(b.cognome,'')||' '||coalesce(b.nome,'') as leg_rap
	    , coalesce(b.cognome,'') as cognome_dichiarante --gac01 
	    , coalesce(b.nome,'') as nome_dichiarante --gac01
	    , case a.flag_attivo
              when 'S' then 'S'
              when 'N' then 'N'
              else ''
              end as flag_attivo
            , a.wallet_id --sim02
         from coimmanu a
    left join coimcitt b on b.cod_cittadino = cod_legale_rapp
        where 1 = 1
       $where_att
       $where_last
       $where_word
       $where_nome
       $where_cod_manutentore
       $where_ruolo
       $where_convenzionato
       $where_stato
        order by upper(a.cognome)
               , cod_manutentore
       </querytext>
    </partialquery>

   <fullquery name="sel_conta_manu">
       <querytext>
           select iter_edit_num(count(*),0) as conta_num
             from coimmanu a
           where 1=1
           $where_att
           $where_word
           $where_nome
           $where_cod_manutentore
           $where_ruolo
           $where_convenzionato
           $where_stato
       </querytext>
   </fullquery>
    
</queryset>
