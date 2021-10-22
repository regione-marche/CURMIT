<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_mail">
        <querytext>
                   select id_mail
		        , mittente
			, destinatario
			, cc
			, oggetto
			, testo
			, allegato
                        , nome_file
		     from coimmail
		    where id_mail = :id_mail
       </querytext>
   </fullquery>


   <fullquery name="sel_dual_date">
        <querytext>
                    select to_char(current_date, 'yyyymmdd')
                        as currente_date
       </querytext>
   </fullquery>
 

    <fullquery name="sel_nextval_comu">
        <querytext>
                   select nextval('coimcomu_s') as cod_comune
       </querytext>
   </fullquery>

    <fullquery name="sel_nextval_comu">
        <querytext>
                   select nextval('coimcomu_s') as cod_comune
       </querytext>
   </fullquery>

    <fullquery name="sel_aimp_count">
        <querytext>
             select count(*) as conta_mail
               from coimmail
	             where id_mail = :id_mail
       </querytext>
   </fullquery>


</queryset>
