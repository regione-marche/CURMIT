<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_manu">
       <querytext>
       select a.cod_manutentore
            , a.cognome
            , a.nome
            , nvl(a.cognome,'')||' '||nvl(a.nome,'') as rag_soc
            , a.comune
            , a.provincia
            , a.indirizzo
            , a.telefono
            , coalesce(b.cognome,'')||' '||coalesce(b.nome,'') as leg_rap
            , case a.flag_attivo
              when 'S' then 'S'
              when 'N' then 'N'
              else ''
              end as flag_attivo
         from coimmanu a
    left join coimcitt b on b.cod_cittadino = cod_legale_rapp
        where 1 = 1
       $where_last
       $where_word
       $where_nome
       $where_cod_manutentore
       $where_ruolo
       $where_convenzionato
       $where_stato
        order by upper(a.cognome)
               , a.cod_manutentore
       </querytext>
    </partialquery>

   <fullquery name="sel_conta_manu">
       <querytext>
           select iter_edit.num(count(*),0) as conta_num
             from coimmanu a
           where 1=1
           $where_word
           $where_nome
           $where_cod_manutentore
           $where_ruolo
           $where_convenzionato
           $where_stato
       </querytext>
   </fullquery>

</queryset>
