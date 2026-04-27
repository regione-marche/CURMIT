set page_title "Amministrazione portale"
set context [list [list ../admin "Amministrazione Portale"] "$page_title"]

# ( Rendo dinamica la scelta della porta in base a dove mi trovo: 'SVILUPPO' o 'PRODUZIONE' )
if {[db_get_database] eq "curit-dev"} {
    #set port 8010
    set base_url "http://wallet.sviluppo.curit.it"
} elseif {[db_get_database] eq "curit-sta"} {
    set base_url "http://wallet.staging.curit.it"
} else {
   # set port 8009
    set base_url "http://wallet.curit.it"
}
