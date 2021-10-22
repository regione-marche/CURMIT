<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

	<fullquery name="sel_anom">
       	<querytext>
        	select a.*, b.denominazione
        	from $nome_tab_anom a
        	left join coimtabs b on b.nome_colonna = a.nome_colonna
        	where a.id_riga = :id_riga
        	and b.nome_tabella = :modello
        	and a.nome_colonna <> 'cod_impianto_est'
            and a.nome_colonna <> 'matricola'
            and a.nome_colonna <> 'modello'
            and a.nome_colonna <> 'potenza_foc_nom'
            and a.nome_colonna <> :pot_nom
            and a.nome_colonna <> 'toponimo'
            and a.nome_colonna <> 'indirizzo'
            and a.nome_colonna <> 'combustibile'
            and a.nome_colonna <> 'marca'
    	</querytext>
	</fullquery>
	
	<fullquery name="sel_value_anom">
       	<querytext>
        	select $nome_colonna as value
           	from $nome_tab_cari a
        	where a.id_riga = :id_riga
       	</querytext>
	</fullquery>
	
	<fullquery name="upd_imp_cari_ok">
		<querytext>
        	update $nome_tab_cari
            set $nome_colonna = upper(btrim(:value_campo,' '))
            where id_riga = :id_riga 
		</querytext>
	</fullquery>
	
	<fullquery name="upd_imp_anom_scarta">
		<querytext>
        	update $nome_tab_cari
            set flag_stato = 'S'
			where id_riga = :id_riga
		</querytext>
	</fullquery>

</queryset>
