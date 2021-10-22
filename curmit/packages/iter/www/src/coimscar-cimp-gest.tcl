ad_page_contract {
    @author          dob
    @creation-date   05/2009
} {
    {funzione        "I"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {f_cod_enve        ""}
    {f_cod_tecn        ""}
    {nome_file_2       ""}
    {nome_dir          ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

ns_log notice "prova dob inizio coimscar-cimp-gest nome_funz = $nome_funz nome_funz_caller $nome_funz_caller $f_cod_enve $f_cod_tecn"


switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set link_gest [export_url_vars nome_funz nome_funz_caller caller]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# leggo la tabella dei dati generali
iter_get_coimtgen

# imposto la directory degli permanenti ed il loro nome.
set permanenti_dir     [iter_set_permanenti_dir]
set permanenti_dir_url [iter_set_permanenti_dir_url]


# imposto il nome dei file
set nome_file     "Scarica verifiche"
set nome_file     [iter_temp_file_name -permanenti $nome_file]

set file_csv      "$permanenti_dir/$nome_file.csv"
set file_csv_url  "$permanenti_dir_url/$nome_file.csv"

ns_log notice "prova dob 2 file_csv = $file_csv file_csv_url = $file_csv_url"

set file_id       [open $file_csv w]
fconfigure $file_id -encoding iso8859-15

#ns_log notice "prova dob dopo la open"

set     head_cols ""
lappend head_cols "NUMERO PROTOCOLLO"
lappend head_cols "POTENZA FOCOLARE NOMINALE IMPIANTO"
#lappend head_cols "ORA INIZIO VERIFICA"
#lappend head_cols "ORA FINE VERIFICA"
lappend head_cols "DATA INSERIMENTO"
#lappend head_cols "DATA MODIFICA"
lappend head_cols "NOTE CONFORMITA"
lappend head_cols "RIFERIMENTI PAGAMENTO"
lappend head_cols "LIBRETTO USO E MANUTENZIONE IMPIANTO - CALDAIA"
#lappend head_cols "CERTIFICATO PREVENZIONE INCENDI PER IMPIANTI > 116,3 kW"
lappend head_cols "DATA PROTOCOLLO"
lappend head_cols "PENDENZA CANALI"
lappend head_cols "DICHIARAZIONE CONFORMITA IMPIANTO"
#lappend head_cols "NUMERO RAPPORTO DI VERIFICA"
lappend head_cols "TIPO DOCUMENTO"
lappend head_cols "UTENTE ULTIMA MODIFICA"
lappend head_cols "PROGRESSIVO GENERATORE"
lappend head_cols "DATA TARATURA STRUMENTO"
lappend head_cols "DISPOSITIVI DI REGOLAZIONE CLIMA PRESENTI"
lappend head_cols "DISPOSITIVI DI REGOLAZIONE DEL CLIMA FUNZIONANTE"
lappend head_cols "DATA ULTIMA MANUTENZIONE"
lappend head_cols "RENDIMENTO COMBUSTIONE"
lappend head_cols "AUTOCERTIFICAZIONE ESISTENTE"
lappend head_cols "NOTE"
lappend head_cols "AUTOCERTIFICAZIONE CON PRESCRIZIONE"
lappend head_cols "DESCRIZIONE STRUMENTO"
lappend head_cols "MARCA STRUMENTO"
lappend head_cols "MODELLO STRUMENTO"
lappend head_cols "MATRICOLA STRUMENTO" 
lappend head_cols "TEMPERATURA FLUIDO IN MANDATA MISURAZIONE 1"
lappend head_cols "TEMPERATURA  FLUIDO IN MANDATA MISURAZIONE 2"
lappend head_cols "TEMPERATURA  FLUIDO IN MANDATA MISURAZIONE 3"
lappend head_cols "TEMPERATURA  FLUIDO IN MANDATA MISURAZIONE MED"
lappend head_cols "TEMPERATURA ARIA COMBURENTE MISURAZIONE 1"
lappend head_cols "TEMPERATURA ARIA COMBURENTE MISURAZIONE 2"
lappend head_cols "TEMPERATURA ARIA COMBURENTE MISURAZIONE 3"
lappend head_cols "TEMPERATURA ARIA COMBURENTE MISURAZIONE MED"
lappend head_cols "TEMPERATURA FUMI MISURAZIONE 1"
lappend head_cols "TEMPERATURA FUMI MISURAZIONE 2"
lappend head_cols "TEMPERATURA FUMI MISURAZIONE 3"
lappend head_cols "DISPOSITIVI DI CONTROLLO PRESENTI"
lappend head_cols "ACCESSO ALLA CENTRALE"
lappend head_cols "MEZZI ANTINCENDIO"
lappend head_cols "8A MANUTENZIONE"
lappend head_cols "MANUTENZIONE ANNI PRECEDENTI"
lappend head_cols "CO RILEVATO"
lappend head_cols "8B CO NEI FUMI SECCHI"
lappend head_cols "INDICE FUMOSITA MISURAZIONE MEDIA"
lappend head_cols "8C INDICE FUMOSITA"
lappend head_cols "RENDIMENTO MINIMO"
lappend head_cols "8D RENDIMENTO COMBUSTIBILE"
lappend head_cols "PERICOLOSITA IMPIANTO"
lappend head_cols "NOTE VERIFICATORE"
lappend head_cols "NOTE RESPONSABILE"
lappend head_cols "METODO DI PAGAMENTO"
lappend head_cols "COSTO VERIFICA"
#lappend head_cols "DICHIARAZIONE CONFORMITA IMPIANTO ELETTRICO"
lappend head_cols "CODICE IMPIANTO"
lappend head_cols "PORTATA COMBUSTIBILE m3/h kg/h"
lappend head_cols "FUMOSITA MISURAZIONE 3"
lappend head_cols "VERIFICA SCARICO"
lappend head_cols "PRESENZA FORO"
lappend head_cols "FORO CORRETTO"
lappend head_cols "STATO COIBENTAZIONE"
lappend head_cols "FORO ACCESSIBILE"
lappend head_cols "CONFORMITA DEL LOCALE"
lappend head_cols "DISPOSITIVI DI CONTROLLO FUNZIONANTI"
lappend head_cols "VERIFICA AREAZIONE"
lappend head_cols "ESITO VERIFICA"
lappend head_cols "APERTURA DI VENTILAZIONE LIBERA"
lappend head_cols "ASSENZA MATERIALI ESTRANEI"
lappend head_cols "CARTELLONISTICA PREVISTA"
lappend head_cols "PRESENZA LIBRETTO"
lappend head_cols "LIBRETTO CORRETTO"
lappend head_cols "FUMOSITA MISURAZIONE 1"
lappend head_cols "TEMPERATURA FUMI MISURAZIONE MED"
lappend head_cols "MISURAZIONE C0 MISURAZIONE 1"
lappend head_cols "MISURAZIONE C0 MISURAZIONE 2"
lappend head_cols "MISURAZIONE C0 MISURAZIONE 3"
lappend head_cols "MISURAZIONE C0 MISURAZIONE MED"
lappend head_cols "MISURAZIONE C02 MISURAZIONE 1"
lappend head_cols "MISURAZIONE C02 MISURAZIONE 2"
lappend head_cols "MISURAZIONE C02 MISURAZIONE 3"
lappend head_cols "MISURAZIONE C02 MISURAZIONE MED"
lappend head_cols "MISURAZIONE 02 MISURAZIONE 1"
lappend head_cols "MISURAZIONE 02 MISURAZIONE 2"
lappend head_cols "MISURAZIONE 02 MISURAZIONE 3"
lappend head_cols "MISURAZIONE 02 MISURAZIONE MED"
lappend head_cols "TEMPERATURA MANTELLO MISURAZIONE 1"
lappend head_cols "TEMPERATURA MANTELLO MISURAZIONE 2"
lappend head_cols "TEMPERATURA MANTELLO MISURAZIONE 3"
lappend head_cols "TEMPERATURA MANTELLO MISURAZIONE MED"
lappend head_cols "ECCESSO ARIA PERCENTUALE MISURAZIONE 1"
lappend head_cols "ECCESSO ARIA PERCENTUALE MISURAZIONE 2"
lappend head_cols "ECCESSO ARIA PERCENTUALE MISURAZIONE 3"
lappend head_cols "ECCESSO ARIA PERCENTUALE MISURAZIONE MED"
lappend head_cols "COMBUSTIBILE"
lappend head_cols "INTERRUTTORE GENERALE ESTRENO"
lappend head_cols "DATA VERIFICA"
lappend head_cols "FUMOSITA MISURAZIONE 2"
lappend head_cols "COGNOME VERIFICATORE O RAGIONE SOCIALE"
lappend head_cols "NOME VERIFICATORE"
lappend head_cols "DATA ULTIMA AUTOCERTIFICAZIONE"
lappend head_cols "DATA PAGAMENTO ULTIMA AUTOCERTIFICAZIONE"
lappend head_cols "NOME RESPONSABILE"
lappend head_cols "COGNOME RESPONSABILE"
lappend head_cols "INDIRIZZO RESPONSABILE"
lappend head_cols "COMUNE RESPONSABILE"
lappend head_cols "PROVINCIA RESPONSABILE"
lappend head_cols "NATURA GIURIDICA RESPONSABILE"
lappend head_cols "CAP RESPONSABILE"
lappend head_cols "IDENTIFICATIVO FISCALE RESPONSABILE"
lappend head_cols "TELEFONO RESPONSABILE"
lappend head_cols "EVENTUALE DELEGATO"
lappend head_cols "VOLUMETRIA RISCALDATA"
lappend head_cols "CONSUMI ULTIMA STAGIONE"
lappend head_cols "POTENZA FOCOLARE NOMINALE"
lappend head_cols "POTENZA UTILE NOMINALE"
lappend head_cols "DATA ULTIMA ANALISI DEL COMBUSTIBILE"
#lappend head_cols "LIBRETTO USO E MANUTENZIONE BRUCIATORE"
lappend head_cols "RUBINETTO INTERCETTAZIONE"
lappend head_cols "ANOMALIE RISCONTRATE"

set     file_cols ""
lappend file_cols "n_prot"             
lappend file_cols "mis_pot_focolare"   
#lappend file_cols "ora_inizio"         
#lappend file_cols "ora_fine"           
lappend file_cols "data_ins"           
#lappend file_cols "data_mod"           
lappend file_cols "note_conf"          
lappend file_cols "riferimento_pag"    
lappend file_cols "libretto_manutenz"  
#lappend file_cols "doc_prev_incendi"   
lappend file_cols "data_prot"          
lappend file_cols "pendenza"           
lappend file_cols "dich_conformita"    
#lappend file_cols "verb_n"       
lappend file_cols "flag_tracciato"        
lappend file_cols "utente"                
lappend file_cols "gen_prog"              
lappend file_cols "dt_tar_strum"          
lappend file_cols "new1_disp_regolaz"     
lappend file_cols "disp_reg_clim_funz"    
lappend file_cols "new1_data_ultima_manu" 
lappend file_cols "rend_comb_conv"        
lappend file_cols "new1_dimp_pres"        
lappend file_cols "new1_note_manu"        
lappend file_cols "new1_dimp_prescriz"    
lappend file_cols "strumento"             
lappend file_cols "marca_strum"           
lappend file_cols "modello_strum"         
lappend file_cols "matr_strum"            
lappend file_cols "temp_h2o_out_1a"       
lappend file_cols "temp_h2o_out_2a"       
lappend file_cols "temp_h2o_out_3a"       
lappend file_cols "temp_h2o_out_md"       
lappend file_cols "t_aria_comb_1a"        
lappend file_cols "t_aria_comb_2a"        
lappend file_cols "t_aria_comb_3a"        
lappend file_cols "t_aria_comb_md"        
lappend file_cols "temp_fumi_1a"          
lappend file_cols "temp_fumi_2a"          
lappend file_cols "temp_fumi_3a"          
lappend file_cols "disp_reg_cont_pre"     
lappend file_cols "new1_conf_accesso"     
lappend file_cols "new1_pres_mezzi"       
lappend file_cols "manutenzione_8a"       
lappend file_cols "new1_manu_prec_8a"     
lappend file_cols "new1_co_rilevato"      
lappend file_cols "co_fumi_secchi_8b"     
lappend file_cols "indic_fumosita_md"     
lappend file_cols "indic_fumosita_8c"     
lappend file_cols "rend_comb_min"         
lappend file_cols "rend_comb_8d"          
lappend file_cols "new1_flag_peri_8p"     
lappend file_cols "note_verificatore"     
lappend file_cols "note_resp"             
lappend file_cols "tipologia_costo"       
lappend file_cols "costo"                 
#lappend file_cols "conf_imp_elettrico"    
lappend file_cols "cod_impianto_est"      
lappend file_cols "mis_port_combust"      
lappend file_cols "indic_fumosita_3a"     
lappend file_cols "effic_evac"            
lappend file_cols "new1_foro_presente"    
lappend file_cols "new1_foro_corretto"    
lappend file_cols "stato_coiben"          
lappend file_cols "new1_foro_accessibile" 
lappend file_cols "new1_conf_locale"      
lappend file_cols "disp_reg_cont_funz"    
lappend file_cols "verifica_areaz"        
lappend file_cols "esito_verifica"        
lappend file_cols "ventilaz_lib_ostruz"   
lappend file_cols "new1_asse_mate_estr"   
lappend file_cols "new1_pres_cartell"     
lappend file_cols "presenza_libretto"     
lappend file_cols "libretto_corretto"     
lappend file_cols "indic_fumosita_1a"     
lappend file_cols "temp_fumi_md"          
lappend file_cols "co_1a"                 
lappend file_cols "co_2a"                 
lappend file_cols "co_3a"                 
lappend file_cols "co_md"                 
lappend file_cols "co2_1a"                
lappend file_cols "co2_2a"                
lappend file_cols "co2_3a"                
lappend file_cols "co2_md"                
lappend file_cols "o2_1a"                 
lappend file_cols "o2_2a"                 
lappend file_cols "o2_3a"                 
lappend file_cols "o2_md"                 
lappend file_cols "temp_mant_1a"          
lappend file_cols "temp_mant_2a"          
lappend file_cols "temp_mant_3a"          
lappend file_cols "temp_mant_md"          
lappend file_cols "eccesso_aria_perc"     
lappend file_cols "eccesso_aria_perc_2a"  
lappend file_cols "eccesso_aria_perc_3a"  
lappend file_cols "eccesso_aria_perc_md"  
lappend file_cols "cod_combustibile"      
lappend file_cols "new1_pres_interrut"    
lappend file_cols "data_controllo"        
lappend file_cols "indic_fumosita_2a"     
lappend file_cols "cognome_veri"          
lappend file_cols "nome_veri"             
lappend file_cols "new1_data_dimp"        
lappend file_cols "new1_data_paga_dimp"   
lappend file_cols "nome_resp"             
lappend file_cols "cognome_resp"          
lappend file_cols "indirizzo_resp"        
lappend file_cols "comune_resp"           
lappend file_cols "provincia_resp"        
lappend file_cols "natura_giuridica_resp" 
lappend file_cols "cap_resp"              
lappend file_cols "cod_fiscale_resp"      
lappend file_cols "telefono_resp"         
lappend file_cols "nominativo_pres"       
lappend file_cols "volumetria"            
lappend file_cols "comsumi_ultima_stag"   
lappend file_cols "pot_focolare_nom"      
lappend file_cols "pot_utile_nom"         
lappend file_cols "new1_data_ultima_anal" 
#lappend file_cols "libr_manut_bruc"       
lappend file_cols "new1_pres_intercet"    


set sw_primo_rec "t"

db_foreach sel_cimp "" {
    set file_col_list ""

    if {$sw_primo_rec == "t"} {
	set sw_primo_rec "f"
	iter_put_csv $file_id head_cols |
    }

    #itero i generatori del sistema
    foreach column_name $file_cols {

   	regsub -all \n $new1_note_manu "" new1_note_manu
   	regsub -all \n $note_verificatore "" note_verificatore
   	regsub -all \n $note_resp "" note_resp
   	regsub -all \n $note_conf "" note_conf
   	regsub -all \n $nominativo_pres "" nominativo_pres

   	regsub -all \r $new1_note_manu "" new1_note_manu
   	regsub -all \r $note_verificatore "" note_verificatore
   	regsub -all \r $note_resp "" note_resp
   	regsub -all \r $note_conf "" note_conf
   	regsub -all \r $nominativo_pres "" nominativo_pres
	
	lappend file_col_list [set $column_name]
    }
    set tanom_list ""
    db_foreach list_anom "" {
	lappend tanom_list "$cod_tanom,"
    }

    lappend file_col_list $tanom_list
    iter_put_csv $file_id file_col_list |

} if_no_rows {
    set msg_err      "Nessun impianto attivo presente in archivio"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list |
}

ad_returnredirect $file_csv_url
ad_script_abort

