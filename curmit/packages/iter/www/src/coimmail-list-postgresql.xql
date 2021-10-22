<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
       <querytext>
                   select a.id_mail
		        , a.mittente
                        , a.destinatario
			, a.cc
			, a.oggetto
			, a.testo
			, allegato
                        , a.nome_file 
                        , to_char(a.data_ins,'DD/MM/YYYY') as data_ins
                     from coimmail a
		    where 1 = 1
		   $where_last
		   $where_word
		    order by id_mail desc                  
       </querytext>
    </partialquery>

</queryset>
