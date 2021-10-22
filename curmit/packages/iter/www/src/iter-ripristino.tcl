ad_page_contract {@author dob} {tipo_modello cod_manutentore}     

db_dml del_manu "delete from coimcari_manu where cod_manutentore = :cod_manutentore"

if {$tipo_modello == "modellof"} {
    set iniz_tabella_dati [db_string query "select 'fcari_'||lower(:cod_manutentore)"]
} else {
    set iniz_tabella_dati [db_string query "select 'gcari_'||lower(:cod_manutentore)"]
}

set iniz_tabella_anom [db_string query "select 'anom_'||lower(:cod_manutentore)"]
set lista_tabelle [db_tables -pattern ${iniz_tabella_dati}%] 
set lista_tabanom [db_tables -pattern ${iniz_tabella_anom}%] 
foreach nome_tabella $lista_tabelle {
    set nome_sequence "${nome_tabella}_s"
    db_dml del_tabella "drop table $nome_tabella"
    db_dml del_seq "drop sequence $nome_sequence"
}
foreach nome_tabanom $lista_tabanom {
    db_dml del_tabanom "drop table $nome_tabanom"
}
ns_return 200 text/html "Rimozione tabelle elaborazioni di caricamento interrotte. <br> Tipo modello: $tipo_modello <br> Manutentore: $cod_manutentore.<br>Tabelle rimosse: $lista_tabelle $lista_tabanom"
return

