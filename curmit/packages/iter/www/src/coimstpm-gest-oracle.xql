<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_stpm_s">
        <querytext>
          select coimstpm_s.nextval as id_stampa
            from dual
       </querytext>
    </fullquery>

    <partialquery name="ins_stpm">
       <querytext>
             insert
                  into coimstpm 
                     ( id_stampa
                     , descrizione
                     , testo
                     , campo1
                     , campo1_testo
                     , campo2
                     , campo2_testo
                     , campo3
                     , campo3_testo
                     , campo4
                     , campo4_testo
                     , campo5
                     , campo5_testo
                     , var_testo
                     , allegato
                     , tipo_foglio
                     , orientamento
                     , tipo_documento)
                values 
                     (:id_stampa
                     ,:descrizione
                     ,:testo
                     ,:campo1
                     ,:campo1_testo
                     ,:campo2
                     ,:campo2_testo
                     ,:campo3
                     ,:campo3_testo
                     ,:campo4
                     ,:campo4_testo
                     ,:campo5
                     ,:campo5_testo
                     ,:var_testo
                     ,:allegato
                     ,:tipo_foglio
                     ,:orientamento
                     ,:tipo_documento)
       </querytext>
    </partialquery>

    <partialquery name="upd_stpm">
       <querytext>
                update coimstpm
                   set descrizione  = :descrizione
                     , testo        = :testo
                     , campo1       = :campo1
                     , campo1_testo = :campo1_testo
                     , campo2       = :campo2
                     , campo2_testo = :campo2_testo
                     , campo3       = :campo3
                     , campo3_testo = :campo3_testo
                     , campo4       = :campo4
                     , campo4_testo = :campo4_testo
                     , campo5       = :campo5
                     , campo5_testo = :campo5_testo
                     , var_testo    = :var_testo
                     , allegato     = :allegato
                     , tipo_foglio  = :tipo_foglio
                     , orientamento = :orientamento
                     , tipo_documento = :tipo_documento
                 where id_stampa    = :id_stampa
       </querytext>
    </partialquery>

    <partialquery name="del_stpm">
       <querytext>
                delete
                  from coimstpm
                 where id_stampa = :id_stampa
       </querytext>
    </partialquery>

    <fullquery name="sel_stpm">
       <querytext>
        select id_stampa
	     , testo
	     , descrizione
	     , campo1
	     , campo1_testo
	     , campo2
             , campo2_testo
	     , campo3
             , campo3_testo
	     , campo4
             , campo4_testo
             , campo5
             , campo5_testo
             , var_testo
             , allegato
             , tipo_foglio
             , orientamento
             , tipo_documento
          from coimstpm
         where id_stampa = :id_stampa
       </querytext>
    </fullquery>

    <fullquery name="check_exists">
       <querytext>
        select '1'
          from coimstpm
         where id_stampa = :id_stampa
       </querytext>
    </fullquery>

</queryset>
