<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_manu">
       <querytext>
select cod_manutentore
     , cognome
     , Nvl (cognome, ' ') ||' '|| Nvl (nome, ' ') as rag_soc
     , indirizzo
     , localita
     , provincia
     , cap
     , comune
     , cod_fiscale
     , cod_piva
     , telefono
     , cellulare
     , fax
     , email
     , reg_imprese
     , localita_reg
     , rea
     , localita_rea
     , capit_sociale
     , note
     , decode (flag_convenzionato
             ,'S', 'Si'
             ,'N', 'No'
             ,'') as flag_convenzionato
     , prot_convenzione
     , iter_edit.data(prot_convenzione_dt) as prot_convenzione_dt
     , decode (flag_ruolo
             ,'M', 'Manutentore'
             ,'I', 'Installatore'
             ,'T', 'Manutentore/Installatore'
             ,'') as flag_ruolo
     , iter_edit.data(data_inizio) as data_inizio
     , iter_edit.data(data_fine) as data_fine
  from coimmanu
 where 1=1
 $where_cognome
 $where_nome
 $where_cod_manutentore
 $where_ruolo
 $where_convenzionato
 $where_stato
order by cognome
       </querytext>
    </partialquery>

</queryset>
