ad_library {
    Provides various functions for the package.

    @author Giulio Laurenzi
    @cvs-id iter-edit-procs.tcl

    USER  DATA       MODIFICHE
    ===== ========== ======================================================================

}

ad_proc -private iter_edit_crlf {stringa_inp} {
    Accetta in ingresso una stringa e trasforma i crlf, i cr ed i lf in <br> perche' vengano
    esposti correttamente in html.
} {
    set stringa_out [regsub -all \r\n $stringa_inp <br>]
    set stringa_out [regsub -all \r   $stringa_out <br>]
    set stringa_out [regsub -all   \n $stringa_out <br>]

    return $stringa_out
}
