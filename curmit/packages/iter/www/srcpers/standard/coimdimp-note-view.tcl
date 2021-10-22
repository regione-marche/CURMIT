ad_page_contract {
    Pagina di sfondo.

    @author Giulio Laurenzi
    @date   18/03/2004

    @cvs_id coimdimp-note-view.tcl
} {
    {cod_dimp ""}
} -properties {
    form_name:onevalue
}

set logo_url [iter_set_logo_dir_url]
set css_url  [iter_set_css_dir_url]

set form_name "coimdimpnote"
form create $form_name 

element create $form_name cognome_manu \
-label   "Cognome manutentore" \
-widget   text \
-datatype text \
    -html    "size 20 maxlength 40 readonly {} class form_element" \
-optional

element create $form_name nome_manu \
-label   "Nome manutentore" \
-widget   text \
-datatype text \
    -html    "size 20 maxlength 40 readonly {} class form_element" \
-optional

element create $form_name data_controllo \
-label   "Data controllo" \
-widget   text \
-datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
-optional

element create $form_name osservazioni \
-label   "Osservazioni" \
-widget   textarea \
-datatype text \
    -html    "cols 32 rows 3 readonly {} class form_element" \
-optional

element create $form_name raccomandazioni \
-label   "Raccomandazioni" \
-widget   textarea \
-datatype text \
    -html    "cols 32 rows 3 readonly {} class form_element" \
-optional

element create $form_name prescrizioni \
-label   "Prescrizioni" \
-widget   textarea \
-datatype text \
    -html    "cols 32 rows 3 readonly {} class form_element" \
-optional


db_1row sel_anom_count ""
if {$conta_anom < 5} {
    set conta_anom 5
}

set conta 0
multirow create multiple_form conta

while {$conta < $conta_anom} {
    incr conta
    multirow append multiple_form $conta

    element create $form_name desc.$conta \
    -label    "anomalia" \
    -widget   text \
    -datatype text \
	-html     "size 85 readonly {} class form_element" \
    -optional 

    element create $form_name data_ut_int.$conta \
    -label    "data utile intervento" \
    -widget   text \
    -datatype text \
	-html     "size 10 readonly {} class form_element" \
    -optional 
}

if {[db_0or1row sel_dimp_esito ""] == 1} {
    switch $flag_status {
	"P" {set esit "Positivo"}
	"N" {set esit "<font color=red><b>Negativo</b></font>"}
	default {set esit ""}
    }
    set esito "<tr>
             <td colspan=3 >Esito controllo: $esit</td>
              </tr>"   
} else {
    set esito ""
}

# leggo riga
if {[db_0or1row sel_dimp ""] == 0} {
    iter_return_complaint "Record non trovato"
}

element set_properties $form_name data_controllo    -value $data_controllo
element set_properties $form_name osservazioni      -value $osservazioni
element set_properties $form_name raccomandazioni   -value $raccomandazioni
element set_properties $form_name prescrizioni      -value $prescrizioni
element set_properties $form_name cognome_manu      -value $cognome_manu
element set_properties $form_name nome_manu         -value $nome_manu

set conta     0
set list_anom_old [list]
db_foreach sel_anom "" {
    incr conta
    lappend list_anom_old $cod_tanom
    if {[db_0or1row sel_tano_desc ""] == 0} {
	set descrizione_anom ""
    }
    element set_properties $form_name desc.$conta   -value $descrizione_anom
    element set_properties $form_name data_ut_int.$conta -value $dat_utile_inter
}

ad_return_template
