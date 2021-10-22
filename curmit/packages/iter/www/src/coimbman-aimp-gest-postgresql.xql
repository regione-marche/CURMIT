<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_manu">
        <querytext>
                   select cod_manutentore
                        , coalesce(cognome,'')||' '||coalesce(nome,'') as nominativo
                        , indirizzo
                        , comune
                        , coalesce(cod_fiscale, '&nbsp;') as cod_fiscale
                     from coimmanu
                    where cod_manutentore = :cod_manu
       </querytext>
   </fullquery>

    <partialquery name="upd_aimp">
       <querytext>
          update coimaimp
	     set cod_manutentore = :destinazione
           where cod_manutentore = :cod_manu
       </querytext>
    </partialquery>

    <fullquery name="sel_opma">
        <querytext>
            select nome as nome_opma
                 , cognome as cognome_opma
                 , matricola as matricola_opma
                 , stato as stato_opma
                 , telefono as telefono_opma
                 , cellulare as cellulare_opma
                 , recapito as recapito_opma
                 , codice_fiscale as codice_fiscale_opma
                 , note as note_opma
              from coimopma
             where cod_manutentore = :cod_manu
       </querytext>
   </fullquery>

    <fullquery name="sel_opma_check">
        <querytext>
            select '1'
              from coimopma
             where cod_manutentore = :destinazione
               and nome = :nome_opma
               and cognome = :cognome_opma
       </querytext>
   </fullquery>

   <fullquery name="sel_opma_s">
        <querytext>
            select :destinazione||coalesce(trim(to_char(max(to_number(substr(cod_opma,6,3),'9999999999999000')) + 1, '999000')), '001') as cod_opma
              from coimopma
             where cod_manutentore = :destinazione
       </querytext>
   </fullquery>

    <fullquery name="sel_opma_dimp">
        <querytext>
            select a.cod_dimp
                 , a.cod_opmanu
                 , b.nome as nome_opma_dimp
                 , b.cognome as cognome_opma_dimp
              from coimdimp a
                 , coimopma b
             where a.cod_manutentore = :cod_manu
               and a.cod_opmanu is not null
               and b.cod_opma = a.cod_opmanu
       </querytext>
   </fullquery>

    <fullquery name="sel_opma_dest">
        <querytext>
            select cod_opma as cod_opma_dest
              from coimopma
             where nome = :nome_opma_dimp
               and cognome = :cognome_opma_dimp
               and cod_manutentore = :destinazione
       </querytext>
   </fullquery>

</queryset>
