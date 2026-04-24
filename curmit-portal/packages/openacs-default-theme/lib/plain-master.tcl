ad_page_contract {
  This is the highest level site specific master template.

  Properties allowed
  doc(title) HTML title
  head code to be entered into head of document
  body 
  focus HTML id of form element to focus
  skip_link href of link to skip to. Should be of format #skip_link
  main_content_p if true wrap in the main content divs (if false, provide your own
    page structure, for instance two or three columns of content per page)

  @author Lee Denison (lee@xarg.co.uk)
  @author Don Baccus (dhogaza@pacifier.com)

  $Id: plain-master.tcl,v 1.4 2009/02/23 20:53:37 jeffd Exp $

    USER  DATA       MODIFICHE
    ===== ========== ====================================================================================
    rom05 10/10/2023 Aggiunta variabile sw_ammi_cond_p per gli Amministratori di Condominio

    rom04 03/11/2021 Aggiunta variabile sw_soft_house_p per le software-house.

    rom03 19/12/2018 modificato messaggio per login cittadino.

    nic02 06/12/2018 Letto parametro login_cohesion_marche_p che serve all'adp.
    
    nic01 13/11/2018 Se un utente si e' collegato con Cohesion e non con Openacs, faccio
    nic01            comparire il link Esci.
    
    rom02 26/06/2018 Aggiunta variabile sw_distr_p per i distributori.

    rom01 09/05/2018 Aggiunto il parametro login_cittadino_p per fare vedere il link "Accedi ai servizi come cittadino"
    rom01            solo se il parametro vale 0

    gac02 04/05/2018 Aggiunto id_citizen per modficare link "Sei gia registrato? Accedi ai servizi" a seconda
    gac02            del tipo di utente 

    gac01 27/04/2018 Aggiunto db_get_database per attuare delle modifiche all'adp solo per regione marche

}

if { ![info exists main_content_p] } {
    set main_content_p 1
}

#
# Set some basic variables
#
set system_name [ad_system_name]
set subsite_name [lang::util::localize [subsite::get_element -element instance_name]]

set db_name [db_get_database];#gac01

set page_url    [ad_conn url]
set package_url [apm_package_key_from_id [ad_conn package_id]]

if {$package_url in [list xowiki news faq iter-portal acs-subsite] || $page_url eq "/"} {
    set show_menu_p 1
} else {
    set show_menu_p 0
}

if {$page_url eq "/"} {
    set system_url ""
} else {
    set system_url [ad_url]
}

if {[template::util::is_nil title]} {
    # TODO: decide how best to set the lang attribute for the title
    set title [ad_conn instance_name]
}

#
# Organize standard top level navigation, if any, for output by groups (rows of
# horizontal tabs by default)
#
if { [template::multirow exists navigation] } {
    if { ![info exists navigation_groups] } {
        set navigation_groups [list]
    }
    for {set i 1} {$i <= [template::multirow size navigation]} {incr i} {
        template::multirow get navigation $i
        if { [lsearch -exact $navigation_groups $navigation(group)] < 0} {
            lappend navigation_groups $navigation(group)
        }
    }
}

# 
# User information and top level navigation links
#
set user_id [ad_conn user_id]
set untrusted_user_id [ad_conn untrusted_user_id]
set sw_admin_p 0
set sw_cait_p 0
set sw_distr_p 0;#rom02
set sw_soft_house_p 0;#rom04
set sw_ammi_cond_p  0;#rom05

if {[db_0or1row check_maint "select 1 from iter_cait where cait_id = :user_id"]} {;#sim01
    set sw_cait_p 1
}
if {[db_0or1row check_distr "select 1 from iter_distributors where distributor_id = :user_id"]} {#rom02
    set sw_distr_p 1
}
if {[db_0or1row check_distr "select 1 from iter_software_houses where software_house_id = :user_id"]} {#rom04 Aggiunta if e suo contenuto
    set sw_soft_house_p 1
}
if {[db_0or1row check_distr "select 1 from iter_trustees where trustee_id  = :user_id"]} {#rom04 Aggiunta if e suo contenuto
    set sw_ammi_cond_p 1
}

set login_cittadino_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cittadino_p];#rom01
set is_cittadino [group::member_p -user_id $user_id -group_name "Cittadino"  -cascade];#gac02

set login_cohesion_marche_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cohesion_marche_p];#nic02

#nic02: Imposto la url per richiamare la pagina di registrazione del cittadino
#rom03set messaggio "Per registrarti come cittadino, devi cliccare sul bottone \"Registrati\" sotto riportato.";#nic02
set messaggio "Per registrarti come cittadino, devi cliccare sul bottone \"Registrati\" sotto riportato: verrai rimandato al servizio di autenticazione Cohesion della Regione Marche (che permette di creare un'identit&agrave; digitale unica di accesso ai servizi online della Pubblica Amministrazione).<br>
 L&igrave; dovrai cliccare su ENTRA CON COHESION –> ACCEDI CON ALTRE MODALITÀ –-> PASSWORD COHESION –> REGISTRATI.<br>
Per una guida completa alla procedura di registrazione, consulta il <a href=\"http://cohesion.regione.marche.it/cohesioninformativo/Modalit%C3%A0-Autenticazione/Password-Cohesion\">link</a>";#rom03

set url_registrati_come_cittadino [export_vars -base "/iter-portal/login-cohesion-cittadino" {messaggio {context "Registrati"}}];#nic02

set token_cohesion [ad_get_client_property iter token_cohesion];#nic01
if { $untrusted_user_id == 0 } {
    if {$token_cohesion ne ""} {#nic01
	set logout_url [ad_get_logout_url];#nic01
    } else {#nic01
	# The browser does NOT claim to represent a user that we know about
	set login_url [ad_get_login_url -return]
    };#nic01
} else {
    # The browser claims to represent a user that we know about
    set user_name [person::name -person_id $untrusted_user_id]
    set pvt_home_url [ad_pvt_home]
    set pvt_home_name [_ acs-subsite.Your_Account]
    set logout_url [ad_get_logout_url]

    # Site-wide admin link
    set admin_url {}

    set sw_admin_p [acs_user::site_wide_admin_p -user_id $untrusted_user_id]

    if { $sw_admin_p } {
        set admin_url "/acs-admin/"
        set devhome_url "/acs-admin/developer"
        set locale_admin_url "/acs-lang/admin"
    } else {
        set subsite_admin_p [permission::permission_p \
            -object_id [subsite::get_element -element object_id] \
            -privilege admin \
            -party_id $untrusted_user_id]

        if { $subsite_admin_p  } {
            set admin_url "[subsite::get_element -element url]admin/"
        }
    }
}

#
# User messages
#
util_get_user_messages -multirow user_messages

# 
# Set acs-lang urls
#
set acs_lang_url [apm_package_url_from_key "acs-lang"]
set num_of_locales [llength [lang::system::get_locales]]

if {$acs_lang_url eq ""} {
    set lang_admin_p 0
} else {
    set lang_admin_p [permission::permission_p \
        -object_id [site_node::get_element \
            -url $acs_lang_url \
            -element object_id] \
        -privilege admin \
        -party_id [ad_conn untrusted_user_id]]
}

set toggle_translator_mode_url [export_vars \
    -base ${acs_lang_url}admin/translator-mode-toggle \
    {{return_url [ad_return_url]}}]

set package_id [ad_conn package_id]
if { $num_of_locales > 1 } {
    set change_locale_url [export_vars -base $acs_lang_url {package_id}]
}

#
# Change locale link
#
if {[llength [lang::system::get_locales]] > 1} {
    set change_locale_url [export_vars -base "/acs-lang/" {package_id}]
}

#
# Who's Online
#
set num_users_online [lc_numeric [whos_online::num_users]]
set whos_online_url "[subsite::get_element -element url]shared/whos-online"

#
# Context bar
#
if {[info exists context]} {
    set context_tmp $context
    unset context
} else {
    set context_tmp {}
}

ad_context_bar_multirow -- $context_tmp

# Context bar separator
set subsite_id [ad_conn subsite_id]
set separator [parameter::get -package_id $subsite_id -parameter ContextBarSeparator -default ":"]

#
# Curriculum specific bar
#   TODO: remove this and add a more systematic / package independent way 
#   TODO  of getting this content here
#
set curriculum_bar_p [expr {
    [site_node::get_package_url -package_key curriculum] ne ""
}]

if {![info exists skip_link]} {
    set skip_link "#content-wrapper"
}

template::head::add_style -title "Css per menu" -media all -style {
    .menu {padding-left: 5px;}
    .menu ul {margin: 0; padding: 0;}
    .menu ul li {display: block; margin-left: 15px;}
    .menu ul li a {text-decoration: none; color: blue;}
    .menu ul li a :hover {color: #033;}
    .menu ul li #active {color: #033;background-color: #CCCCCC;}
}

