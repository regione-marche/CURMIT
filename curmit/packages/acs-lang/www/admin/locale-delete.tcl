# /packages/acs-lang/www/admin/locale-delete.tcl

ad_page_contract {

    Deletes a locale

    @author Bruno Mattarollo <bruno.mattarollo@ams.greenpeace.org>
    @creation-date 19 march 2002
    @cvs-id $Id: locale-delete.tcl,v 1.5.16.1 2013/08/27 12:20:36 gustafn Exp $
} {
    locale
    confirm_p:optional
}


# We rename to avoid conflict in queries
set current_locale $locale
set default_locale en_US

set locale_label [lang::util::get_label $current_locale]
set default_locale_label [lang::util::get_label $default_locale]

set page_title "Delete $locale_label"
set context [list $page_title]


set form_export_vars [export_vars -form { locale {confirm_p 1} }]


if { ([info exists confirm_p] && $confirm_p ne "") && [template::util::is_true $confirm_p] } {

    db_transaction {

        db_dml delete_messages { delete from lang_messages where locale = :locale }

        db_dml delete_audit { delete from lang_messages_audit where locale = :locale }

        db_dml delete_locale { delete from ad_locales where locale = :locale }

    }

    ad_returnredirect "."
    ad_script_abort
}
