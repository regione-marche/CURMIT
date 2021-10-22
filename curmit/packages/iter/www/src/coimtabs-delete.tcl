ad_page_contract {cancella tupla da coimtabs} {nome_tabella nome_colonna}
db_dml query {delete from coimtabs where nome_tabella = :nome_tabella and nome_colonna = :nome_colonna}
ad_returnredirect "coimtabs-list"
ad_script_abort

