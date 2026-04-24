ad_page_contract {
    Pagina di spiegazione per effettuare il login su Cohesion per la Regione Marche

    @author Nicola Mortonie

    @date   ottobr 2018
    @cvs_id login-cohesion-cittadino

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    rom01 11/03/2022 Giuliodori ha richiesto per mail che il bottone per registrarsi tramite cohesion
    rom01            non si chiami più Registrati ma Accedi.

    sim02 09/04/2021 Per problemi di vulnerabilita' di tipo XSS (Cross-site scripting) non posso
    sim02            passare il parametro ReturnUrl nella url di chiamata a cohesion.
    sim02            Per gestire la cosa, ho dovuto modificare il parametro urlRichiesta presente nel
    sim02            file /opt/tomcat/webapps/CohesionServlet/WEB-INF/web.xml e modificare il
    sim02            programma /opt/tomcat/webapps/CohesionServlet/login.jsp.
    sim02            Non è stato possibile gestire un redirect differente per ambiente di test e ambiente
    sim02            di produzione pertanto il login a cohesion di test fara' sempre il redirect alla url
    sim02            di produzione.

    sim01 15/03/2019 Per motivi di sicurezza i messaggi che poi verranno visualizzati in pagina
    sim01            non possono essere passati via url come parametri.
    sim01            Andrò quindi a passare un codice e sarà poi il programma login-cohesion-cittadino
    sim01            a visualizzare il testo corretto.
    
} {
    messaggio:allhtml
    {context "Accedi"}
}

set messaggio_da_visualizzare "";#sim01
if {$messaggio eq "msg_login"} {#sim01 if e suo contenuto
    set messaggio_da_visualizzare     "Per accedere ai servizi del cittadino &egrave; necessario effettuare la procedura di login cliccando sul bottone \"Accedi\" sotto riportato."	
}

if {$messaggio eq "msg_registrati" || $context eq "Registrati"} {#sim01 if e suo contenuto
    set messaggio_da_visualizzare "Come per i servizi in rete di tutte le pubbliche amministrazioni, per accedere al CURMIT come cittadino non serve registrarsi ma occorre entrare con la propria identità digitale, ovvero utilizzare lo SPID o la Carta d'identità elettronica (CIE).
Clicca sul bottone \"Accedi\" sotto riportato e verrai rimandato alla pagina di autenticazione. <br>Puoi accedere a CURMIT tramite SPID o CIE anche direttamente dalla pagina  \"Sei già registrato? Accedi ai servizi come cittadino\"<br>
Per maggiori informazioni su SPID e CIE consulta il <a href=\"http://www.regione.marche.it/Regione-Utile/Agenda-Digitale/Cittadinanza-digitale/Cohesion#SPID-CIE-CNS\">link</a>"
    set context "Accedi";#rom01
}

set login_button [list [list $context ok]]
#sim01 messo messaggio_da_visualizzare al posto di messaggio
ad_form -name login -html { style "margin: 0px;" } -show_required_p 0 -export context -edit_buttons $login_button -action "[subsite::get_url]iter-portal/login-cohesion-cittadino" -form {
    {messaggio:text(hidden)}
} 

set focus {}

#    ad_form -extend -name login -form [list [list email:text($username_widget),nospell [list label [_ acs-subsite.Email]] [list html [list style "width: 150px"]]]]
#    set user_id_widget_name email
#    if { $email ne "" } {
#        set focus "password"
#    } else {
#        set focus "email"
#    }

#set focus "login.$focus"

ad_form -extend -name login -on_request {
    # Populate fields from local vars

} -on_submit {

    ns_log Notice    "login-cohesion-cittadino;inizio"

    # Leggo dinamicamente il parametro del kernel SystemURL che viene impostato da
    # /admin/site-map Kernel
    # Dovrebbe contenere, ad esempio https://portal-marche-dev.iter-web.it
    set SystemURL    [parameter::get_from_package_key -package_key acs-kernel -parameter SystemURL -default ""]

    # Ora imposto la ReturnUrl alla quale Cohesion deve restituire il token post login
    set ReturnUrl    "$SystemURL/iter-portal/login-cohesion-cittadino-2"

    # Ho fatto milioni di tentativi ma l'unico che funziona e' il seguente con ip pubblico
    # cablato (col dns e con https non funziona).
    set ip_pubblico  [iter::get_ip_pubblico]
#sim02    set redirect_url [export_vars -base "http://$ip_pubblico:8080/CohesionServlet/Authentication" {ReturnUrl}]

    set redirect_url "http://$ip_pubblico:8080/CohesionServlet/Authentication";#sim02
   
    ns_log Notice    "login-cohesion-cittadino;faccio ad_returnredirect -allow_complete_url $redirect_url"

    ad_returnredirect -allow_complete_url $redirect_url

    ns_log Notice    "login-cohesion-cittadino;fine"

    ad_script_abort

}
