ns_log Notice "claudio-login;inizio"

set ReturnUrl     "https://portal-marche-dev.iter-web.it/iter-portal/claudio-login-2"
set redirect_url  [export_vars -base "http://34.244.115.149:8080/CohesionServlet/Authentication" {ReturnUrl}]
#set redirect_url [export_vars -base "http://localhost:8080/CohesionServlet/Authentication" {ReturnUrl}]
#set redirect_url [export_vars -base "http://portal.marche.iter-web.it:8080/CohesionServlet/Authentication" {ReturnUrl}]

ns_log Notice "claudio-login;faccio ad_returnredirect -allow_complete_url $redirect_url"

ad_returnredirect -allow_complete_url $redirect_url

ns_log Notice "claudio-login;fine"

ad_script_abort

#with_catch errmsg {
    #exec curl -F ReturnUrl=http://portal.marche.iter-web.it/iter-portal/claudio-login-2 http://34.249.16.44:8080/CohesionServlet/Authentication
#   exec curl -G -d ReturnUrl=http://portal.marche.iter-web.it/iter-portal/claudio-login-2 http://localhost:8080/CohesionServlet/Authentication
#} {
    #ns_return 200 text/plain "$errmsg"
#}
#ad_script_abort
