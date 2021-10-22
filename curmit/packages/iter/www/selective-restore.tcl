ad_page_contract {

    Legge la lista prodotta dall'esecuzione di 'pg_restore' con l'opzione -l ed elimina tutte le righe
    che non riguardano 'iter', in modo da poter fare un restore selettivo su un database OpenACS appena creato.
    Viene creata una nuova lista, da usare nel 'pg_restore' con l'opzione -L    


    @author Claudio Pasolini
    @date   20/03/2012

    @cvs_id selective-restore.tcl
} {
    {input "/tmp/iter-portal-demo-list.txt"}
    {output "/tmp/iter-r3-list.txt"}
}

ad_require_permission

set fdi  [open $input r]
set data [read $fdi]
close $fdi

set fdo [open $output w]

foreach line [split $data \n] {

    # mantengo solo i commenti (cominciano con ;) e le righe che contengono le stringhe: coim ESTRAZIONE BLOB
    # inoltre mantengo le righe con 'FUNCTION public iter' e la riga successiva
    # infine mantengo le funzioni di compatibilità con Oracle
    if {[regexp {^;|coim|ESTRAZIONE|BLOB|public dow_to_int|public to_interval|public next_day|public add_months|public last_day} $line]} {
	puts $fdo $line
	set function_p 0
	continue
    }

    if {[regexp {FUNCTION public iter} $line]} {
	puts $fdo $line
	set function_p 1
	continue
    }

    if {[regexp {iter} $line] && $function_p} {
	puts $fdo $line
	set function_p 0
	continue
    }

    continue
}

close $fdo

ns_return 200 text/plain "La lista $output è pronta per il restore selettivo."
