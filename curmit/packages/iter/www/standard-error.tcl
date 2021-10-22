ad_page_contract {
    Pagina di errore.

    @author Giulio Laurenzi

    @date   31/10/2002
    @cvs_id ut_return_complaint.

    
    USER  DATA       MODIFICHE
    ===== ========== ==============================================================================
    sim01 12/03/2019 Per questioni di sicurezza il messaggio di errore non viene più passato nel link
    sim01            alla pagina ma viene settato in una variabile di sessione.
    sim01            ho quindi tolto dai parametri di input errore.
    sim01            Inoltre il link al login deve essere settato in questo punto altrimenti potrebbero innestare
    sim01            altri link.

    
} {
}  -properties {
   errore:onevalue
}

set errore [ad_get_client_property iter errore_return_complaint];#sim01

if {[string match "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di*" $errore]} {
    set errore "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di <a href=/iter>Login.</a>"
}

if {[string match "Per accedere a questo programma devi prima eseguire la procedura di*" $errore]} {
    set errore "Per accedere a questo programma devi prima eseguire la procedura di <a href=/iter>Login.</a>"
}

#tolgo qualsiasi stringa javascript nell'errore. Se arriva dalla nostra iter_return_complaint è gi stata trasfortmata in java_oasi
regsub -all "javascript" $errore "" errore 

#sim ritrasformo la stinga java_oasi in javascript. Questo serve per essere sicuri che il javascript inseriti nell'errore siano quelli passati da iter_return_complaint e non da quelli esterni
regsub -all "java_oasi" $errore "javascript" errore

set page_title  "Errore"
set context_bar ""

ad_return_template
