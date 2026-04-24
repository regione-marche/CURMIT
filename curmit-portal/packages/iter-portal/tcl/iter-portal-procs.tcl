ad_library {
    Provides various functions for the package.

    @author Nicola Mortoni
    @cvs-id iter-portal-adp-procs.tcl

}

ad_proc iter_portal_links_batc {
    nome_funz
    nome_funz_caller
    nom
    {url_caller ""}
} {
    Restituisce una variabile contenente i link utilizzati dai programmi
    di sottomissione lavori e di consultazione coda lavori

    Modificato il 20/01/2014 da Nicola per gestire url_caller per le statistiche del portale.
} {
    set prog [file tail [ns_conn url]]

    set class_ins  "func-menu"
    set class_batc "func-menu"
    set class_esit "func-menu"

    if {$prog == "coimbatc-list"
    ||  $prog == "coimbatc-gest"
    } {
	set class_batc "func-sel"
    } else {
	if {$prog == "coimesit-list"
	||  $prog == "coimesit-gest"
	} {
	    set class_esit "func-sel"
	} else {
	    set class_ins  "func-sel"
	}
    }

    set search_word $nom
    set links "
<table width=\"100%\" cellspacing=0  class=func-menu>
<tr>
    <td width=\"33%\" nowrap class=$class_ins>
        <a href=\"[iter_portal_get_pgm $nome_funz_caller]\" class=$class_ins>Lancio lavori</a>
    </td>
    <td width=\"34%\" nowrap class=$class_batc>
        <a href=\"coimbatc-list?nome_funz=[iter_get_nomefunz coimbatc-list]&[export_url_vars nome_funz_caller search_word]\" class=$class_batc>Consultazione lavori in esecuzione</a>
    </td>
    <td width=\"33%\" nowrap class=$class_esit>
        <a href=\"coimesit-list?nome_funz=[iter_get_nomefunz coimesit-list]&[export_url_vars nome_funz_caller search_word]\" class=$class_esit>Consultazione lavori terminati</a>
    </td>
</tr>
</table>
"
   return $links
}

ad_proc iter_portal_get_pgm {nome_funz} {
} {
    # Restituisce il pgm corrispondente al nome della funzione
    set link ""
    if {[db_0or1row query "
        select azione
             , dett_funz as det
             , parametri
          from coimfunz
         where nome_funz = :nome_funz
           and tipo_funz = 'primario'"] == 1
    } {
        set pack_key [iter_portal_package_key]
        set pack_dir [apm_package_url_from_key $pack_key]
        set link "${pack_dir}${azione}${det}?nome_funz=$nome_funz"
        if {![string equal $parametri ""]} {
            append link "&$parametri"
        }
    }
    return $link
}

ad_proc iter_portal_package_key {} {
    Restituisce la directory del package, che e' anche la package_key
} {
    return "iter-portal"
}
