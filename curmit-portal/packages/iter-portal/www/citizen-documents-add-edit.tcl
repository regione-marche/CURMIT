ad_page_contract {
    Add/Edit/ form per la tabella "citizen-documents"
    @author          Romitti Luca
    @creation-date   30/10/2018
    
        USER  DATA       MODIFICHE
    ===== ========== ============================================================================================

} {
    {cod_cittadino ""}
    {cod_impianto_est ""}
    {cod_impianto ""}
    {targa ""}
    dbn_iter
    flag_type_document
} -properties {
    form_name:onevalue
}

if {[db_0or1row q "select 1 
                     from citizen_documents
                    where flag_type_document = :flag_type_document"] == 1} {
    set funzione "V"
} else {
    set funzione "I"
}
    
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
}

set id_utente [iter::script_init_cittadino]
iter_get_coimtgen -dbn $dbn_iter
iter_get_coimdesc -dbn $dbn_iter

#tiro fuori i dati del cittadino
db_1row q "select last_name || first_name as nome_cittadino
                , address1 as localita
             from iter_citizens
            where citizen_id = :id_utente"

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimdimp"
set focus_field  ""
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

switch $funzione {
    "I" {set readonly_key \{\}
	set readonly_fld \{\}
	set disabled_fld \{\}
    }
    "M" {set readonly_fld \{\}
	set disabled_fld \{\}
    }
}
if {$funzione_stn eq "I"} {
    set readonly_key \{\}
    set readonly_fld \{\}
    set disabled_fld \{\}
}
form create $form_name \
    -html    $onsubmit_cmd

element create $form_name soggetto_esecutore \
    -label   "Soggetto esecutore" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name flag_soggetto_esecutore \
    -label "flag_soggetto_esecutore" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \

element create $form_name ufficio_soggetto_esecutore \
    -label "Ufficio" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name indirizzo_soggetto_esecutore \
    -label "Via" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name citta_soggetto_esecutore \
    -label "Città"
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name nome_cittadino \
    -label "Nome cittadino" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name indirizzo_cittadino \
    -label "Via cittadino" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name provincia_cittadino \
     -label "Provincia cittadino" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name localita \
    -label "Località cittadino" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name flag_responsabile \
    -label "flag_responsabile" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \

element create $form_name piva_responsabile \
    -label "pive_responsabile" \
    -widget   text \
    -datatype text \
    -html    "size 16 maxlength 100 $readonly_fld {} class form_element" \
    -optional \

element create $form_name cod_fisc_responsabile \
    -label "cod_fisc_responsabile" \
    -widget   text \
    -datatype text \
    -html    "size 16 maxlength 100 $readonly_fld {} class form_element" \
    -optional \

element create $form_name denominazione_responsabile \
    -label "cod_fisc_responsabile" \
    -widget   text \
    -datatype text \
    -html    "size 16 maxlength 100 $readonly_fld {} class form_element" \
    -optional \

element create $form_name cod_impianto_est \
    -label "Codice impianto" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name indirizzo_impianto \
    -label "Indirizzo impianto" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name comune_impianto \
    -label "Comune impianto" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name provincia_impianto\
    -label "provincia_impianto" \
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name note_intervento_manutenzione \
    -label "Note" \
    -widget text \
    -dataype textarea \
    -html  "cols 70 rows 3 $readonly_fld {} class form_element" \
    -optional

element create $form_name data_adeguamento \
    -label  "Data adeguamento"
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name data_ispezione \
    -label  "Data ispezione"
    -widget   text \
    -datatype text \
    -html    "size 15 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name numero_ispezione \
    -label  "Numero ispezione"
    -widget   text \
    -datatype text \
    -html    "size 4 maxlength 4 $readonly_fld {} class form_element" \
    -optional

element create $form_name firma_cittadino \
    -label  "Firma"
    -widget   text \
    -datatype text \
    -html    "size 30 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name data_documento \
    -label  "Data documento"
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name cod_impianto     -widget hidden -datatype text -optional
element create $form_name document_id      -widget hidden -datatype text -optional
element create $form_name citizen_id       -widget hidden -datatype text -optional
element create $form_name cod_responsabile -widget hidden -datatype text -optional


if {[form is_request $form_name]} {


};#fine is_request

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    set error_num 0


    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    switch $funzione {
	M { set return_url   "citizen-documents-add-edit?funzione=V&$link_gest"
	}
	I {set return_url   "citizen-documents-add-edit?funzione=V&$link_gest"
	}
    }


    ad_returnredirect $return_url
    ad_script_abort
};#fine is_valid
 
ad_return_template

