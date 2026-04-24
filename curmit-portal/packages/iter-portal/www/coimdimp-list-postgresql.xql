<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_dimp">
       <querytext>
select a.cod_dimp
     , iter_edit_data(a.data_controllo) as data_controllo_edit
     , a.data_controllo 
     , a.cod_manutentore
     , case 
          when a.flag_status = 'P' then 'Positivo'
          when a.flag_status = 'N' then 'Negativo'
          else ''
       end as flag_status
     , b.cognome||' '||coalesce(b.nome,'') as desc_manutentore
     , c.cognome||' '||coalesce(c.nome,'') as desc_responsabile
     , a.flag_tracciato
     , case a.flag_tracciato
          when 'H'  then 'Mod. H'
          when 'HB' then 'Mod. H bis'
          when 'G'  then 'Mod. G'
          when 'F'  then 'Mod. F'
          when 'R1' then 'RCEE Tipo 1'
	  when '1B' then 'RCEE Tipo 1 Legna'
	  when 'R2' then 'RCEE Tipo 2'
          when 'R3' then 'RCEE Tipo 3'
	  when 'R4' then 'RCEE Tipo 4'
	  when 'DA' then 'Avven. Man.'
          else ''
       end as flag_tracciato_edit,
       case a.stato_dich
          when null then ' '
          when 'R'  then 'Ric. storno'
          when 'S'  then 'Sost.Eff.'
          when 'A'  then 'Storno Acc.'
          when 'X'  then 'Storno Rif.'
          else ''
       end as stato_storno
      , cod_docu_distinta
      , riferimento_pag
      , flag_tipo_impianto
      , case a.flag_tracciato
          when 'R1' then '<a href="$gest_prog?funzione=V&flag_tracciato=' || a.flag_tracciato || '&dbn_iter=$dbn_iter&targa=$targa&cod_dimp=' || a.cod_dimp || '&cod_impianto=' || a.cod_impianto || '">Selez.</a> <a href="coimdimp-rct-layout?$link_gest&flag_ins=N&targa=$targa&dbn_iter=$dbn_iter&cod_dimp=' || a.cod_dimp || '" class=func-menu target="Stampa">Stampa</a>'
	  when '1B' then '<a href="$gest_prog?funzione=V&flag_tracciato=' || a.flag_tracciato || '&dbn_iter=$dbn_iter&targa=$targa&cod_dimp=' || a.cod_dimp || '&cod_impianto=' || a.cod_impianto || '">Selez.</a> <a href="coimdimp-1bis-layout?$link_gest&flag_ins=N&targa=$targa&dbn_iter=$dbn_iter&cod_dimp=' || a.cod_dimp || '" class=func-menu target="Stampa">Stampa</a>' --aggiunto anche se per le Marche non serve. In futuro se servirà andrà gestito il programma
	  when 'R2' then '<a href="$gest_prog?funzione=V&flag_tracciato=' || a.flag_tracciato || '&dbn_iter=$dbn_iter&targa=$targa&cod_dimp=' || a.cod_dimp || '&cod_impianto=' || a.cod_impianto || '">Selez.</a> <a href="coimdimp-fr-layout?$link_gest&flag_ins=N&targa=$targa&dbn_iter=$dbn_iter&cod_dimp=' || a.cod_dimp || '" class=func-menu target="Stampa">Stampa</a>'
          when 'R3' then '<a href="$gest_prog?funzione=V&flag_tracciato=' || a.flag_tracciato || '&dbn_iter=$dbn_iter&targa=$targa&cod_dimp=' || a.cod_dimp || '&cod_impianto=' || a.cod_impianto || '">Selez.</a> <a href="coimdimp-r3-layout?$link_gest&flag_ins=N&targa=$targa&dbn_iter=$dbn_iter&cod_dimp=' || a.cod_dimp || '" class=func-menu target="Stampa">Stampa</a>'
	  when 'R4' then '<a href="$gest_prog?funzione=V&flag_tracciato=' || a.flag_tracciato || '&dbn_iter=$dbn_iter&targa=$targa&cod_dimp=' || a.cod_dimp || '&cod_impianto=' || a.cod_impianto || '">Selez.</a> <a href="coimdimp-r4-layout?$link_gest&flag_ins=N&targa=$targa&dbn_iter=$dbn_iter&cod_dimp=' || a.cod_dimp || '" class=func-menu target="Stampa">Stampa</a>'
	  when 'DA' then '<a href="$gest_prog?funzione=V&flag_tracciato=' || a.flag_tracciato || '&dbn_iter=$dbn_iter&targa=$targa&cod_dimp=' || a.cod_dimp || '&cod_impianto=' || a.cod_impianto || '">Selez.</a> <a href="coimdimp-dam-layout?$link_gest&flag_ins=N&targa=$targa&dbn_iter=$dbn_iter&cod_dimp=' || a.cod_dimp || '" class=func-menu target="Stampa">Stampa</a>'
          else ''
       end as actions_portale

  from coimdimp a
  left outer join  coimmanu b on b.cod_manutentore = a.cod_manutentore
  left outer join  coimcitt c on c.cod_cittadino   = a.cod_responsabile
  left outer join  coimaimp i on i.cod_impianto    = a.cod_impianto  --innes
 where 1 = 1
$where_aimp
$where_last
$where_word
$where_tracciato
order by data_controllo desc, cod_dimp desc
       </querytext>
    </partialquery>

    <partialquery name="sel_nove">
       <querytext>
           select a.cod_nove
                , iter_edit_data(a.data_consegna) as data_consegna
                , b.cognome||' '||coalesce(b.nome,'') as desc_manu
            from coimnove a
 left outer join coimmanu b on b.cod_manutentore = a.cod_manutentore
               , coimaimp i       --innes
--innes    where a.cod_impianto = :cod_impianto
           where a.cod_impianto = i.cod_impianto
--             and i.targa = :targa --innes	   
              $where_aimp --innes
        order by a.data_consegna desc, a.cod_nove desc
       </querytext>
    </partialquery>


    <partialquery name="sel_noveb">
       <querytext>
           select a.cod_noveb
                , iter_edit_data(a.data_consegna) as data_consegna
                , b.cognome||' '||coalesce(b.nome,'') as desc_manu
            from coimnoveb a
 left outer join coimmanu  b on b.cod_manutentore = a.cod_manutentore
	       , coimaimp i       --innes
--innes    where a.cod_impianto = :cod_impianto
           where a.cod_impianto = i.cod_impianto   --innes
    --         and i.targa = :targa                  --innes
             $where_aimp --innes
        order by a.data_consegna desc, a.cod_noveb desc
       </querytext>
    </partialquery>

    <partialquery name="sel_coimdope">
       <querytext>
           select a.cod_dope_aimp
                , iter_edit_data(a.data_dich)         as data_dich
                , b.cognome||' '||coalesce(b.nome,'') as desc_manu
                , case
                  when a.flag_tipo_impianto = 'R' then
                       'Riscaldamento'
                  else
                       'Raffreddamento'
                  end                                 as tipo_dich
             from coimdope_aimp a
  left outer join coimmanu      b on b.cod_manutentore = a.cod_manutentore
	        , coimaimp i                       --innes
--innes     where a.cod_impianto = :cod_impianto
            where a.cod_impianto = i.cod_impianto  --innes
	    --  and i.targa        = :targa          --innes
              $where_aimp --innes
         order by a.data_dich desc, a. cod_dope_aimp desc
       </querytext>
    </partialquery>

    <partialquery name="sel_aimp_potenza">
       <querytext>
          select potenza,
                 flag_tipo_impianto
            from coimaimp 
           where cod_impianto = :cod_impianto
       --    where targa = :targa --innes
       </querytext>
    </partialquery>

</queryset>
