ad_page_contract {

    Delete a message

    @author Lars Pind (lars@collaboraid.biz)

    @creation-date 2003-08-15
    @cvs-id $Id: message-delete.tcl,v 1.5.8.1 2013/08/27 12:20:36 gustafn Exp $

} {
    locale
    package_key
    message_key
    show:optional
    confirm_p:optional
}


# We rename to avoid conflict in queries
set current_locale $locale
set default_locale en_US

set locale_label [lang::util::get_label $current_locale]
set default_locale_label [lang::util::get_label $default_locale]

set page_title "Delete Message"
set context [list [list "package-list?[export_vars { locale }]" $locale_label] \
                 [list "message-list?[export_vars { locale package_key show }]" $package_key] \
                 $page_title]

set form_export_vars [export_vars -form { locale package_key message_key show {confirm_p 1} }]


if { ([info exists confirm_p] && $confirm_p ne "") && [template::util::is_true $confirm_p] } {
    lang::message::delete \
        -package_key $package_key \
        -message_key $message_key \
        -locale $locale

    ad_returnredirect "message-list?[export_vars { locale package_key show }]"
    ad_script_abort
}
