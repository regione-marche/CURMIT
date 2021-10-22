<html>
<head>
<title>Help Inserimento modello stampa</title>
<link rel="stylesheet" href="@css_url;noquote@/header.css" type="text/css">
</head>

<body>

<table><tr><td>
<br></br>
<p>Di seguito verranno specificati la descrizione dei dati
da inserire e la relativa variabile da utilizzare. Si ricorda che la variabile
deve essere preceduta dal<b>simbolo $</b><br>

<ol>
    <li><b>Dati dellimpianto</b>
    <br>Codice Impianto  = $codice_impianto
    <br>Codice impianto provenienza =  $codice_impianto_originale
    <br>Descrizione Impianto = $descrizione_impianto
    <br>Potenza nominale = $potenza_nominale
    <br>Potenza utile =  $potenza_utile
    <br>Data Installazione = $data_installazione
    <br>Data Rottamazione = $data_rottamazione
    <br>Note =  $note_impianto
    <br>Stato impianto = $stato_impianto
    <br>Stato impianto = $stato_impianto
    <br>Impianto Dichiarato =  $dichiarato
    <br>Data prima dichiarazione = $data_prima_dichiarazione
    <br>Data ultima dichiarazione = $data_ultima_dichiarazione
    <br>Consumo annuo = $consumo_annuo
    <br>Generatori  =  $numero_generatori
    <br>Conformità = $conformita
    <br>Figura_responsabile = $figura_responsabile
    <br>Località = $localita_impianto
    <br>Indirizzo impianto =  $indirizzo_impianto
    <br>Cap impianto =  $cap_impianto
    <br>Impianto soggetto a DPR 412 = $dpr412
    <br>Codice utenza = $codice_utenza
    <br>&nbsp;
    </li>
    
    <li><b>Responsabile</b>
    <br>Natura giuridica = $natura_resp
    <br>Nome = $nome_resp
    <br>Indirizzo = $indirizzo_resp
    <br>Cap = $cap_resp
    <br>Località = $localita_resp
    <br>Comune = $comune_resp
    <br>Provincia = $provincia_resp
    <br>Indirizzo allineato a sinistra = $indirizzo_resp_aln
    <br>Codice fiscale o P.IVA = $codice_fiscale_resp
    <br>Telefono =  $telefono_resp
    <br>Data di nascita = $data_nascita_resp
    <br>Comune =  $comune_nascita_resp
    <br>Note = $note_resp
    <br>&nbsp;
    </li>

    <li><b>Occupante</b>
    <br>Natura giuridica = $natura_occu
    <br>Nome = $nome_occu
    <br>Indirizzo = $indirizzo_occu
    <br>Cap = $cap_occu
    <br>Località = $localita_occu
    <br>Comune = $comune_occu
    <br>Provincia =  $provincia_occu
    <br>Codice fiscale o P.IVA = $codice_fiscale_occu
    <br>Telefono =  $telefono_occu
    <br>Data di nascita = $data_nascita_occu
    <br>Comune =  $comune_nascita_occu
    <br>Note = $note_occu
    <br>&nbsp;
    </li>

    <li><b>Intestatario</b>
    <br>Natura giuridica = $natura_inte
    <br>Nome = $nome_inte
    <br>Indirizzo = $indirizzo_inte
    <br>Cap = $cap_inte
    <br>Località = $localita_inte
    <br>Comune = $comune_inte
    <br>Provincia =  $provincia_inste
    <br>Codice fiscale o P.IVA = $codice_fiscale_inte
    <br>Telefono =  $telefono_inte
    <br>Data di nascita = $data_nascita_inte
    <br>Comune =  $comune_nascita_inte
    <br>Note = $note_inte
    <br>&nbsp;
    </li>

    <li><b>Proprietario</b>
    <br>Natura giuridica = $natura_prop
    <br>Nome = $nome_prop
    <br>Indirizzo = $indirizzo_prop
    <br>Cap = $cap_prop
    <br>Località = $localita_prop
    <br>Comune = $comune_prop
    <br>Provincia =  $provincia_prop
    <br>Codice fiscale o P.IVA = $codice_fiscale_prop
    <br>Telefono =  $telefono_prop
    <br>Data di nascita = $data_nascita_prop
    <br>Comune =  $comune_nascita_prop
    <br>Note = $note_prop
    <br>&nbsp;
    </li>

    <li><b>Manutentore</b>
    <br>Ditta = $nome_manu
    <br>Indirizzo = $indirizzo_manu
    <br>Cap = $cap_manu
    <br>Località = $localita_manu
    <br>Comune = $comune_manu
    <br>Provincia = $provincia_manu
    <br>Codice fiscale / P.IVA = $partita_iva_manu
    <br>Telefono = $telefono_manu
    <br>Note = $note_manu
    <br>&nbsp;
    </li>

    <li><b>Installatore</b>
    <br>Ditta = $nome_inst
    <br>Indirizzo = $indirizzo_inst
    <br>Cap = $cap_inst
    <br>Località = $localita_inst
    <br>Comune = $comune_inst
    <br>Provincia = $provincia_inst
    <br>Codice fiscale / P.IVA = $partita_iva_inst
    <br>Telefono = $telefono_inst
    <br>Note = $note_inst
    <br>&nbsp;
    </li>

    <li><b>Dati ultima ispezione</b>
    <br>Codice ispezione = $cod_cimp
    <br>Numero generatore = $gen_prog
    <br>Codice incontro = $cod_inco
    <br>Data controllo = $data_controllo_rv
    <br>Numero verbale =  $verb_n
    <br>Data verbale = $data_verb
    <br>Ispettore = $verif_cimp
    <br>Telefono ispettore = $telefono_ver
    <br>Cellulare ispettore = $cellulare_ver
    <br>Esito ispezione = $esito_verifica
    <br>&nbsp;
    </li>

    <li><b>Anomalie collegate</b>
    <br>Descrizione = $anomalia
    <br>Data utile per lintervento = $data_interv
    <br>&nbsp;
    </li>

    <li><b>Estrazione/incontro collegato allultima ispezione</b>
    <br>Codice incontro = $cod_inco
    <br>Descrizione = $desc_cinc
    <br>Tipo di estrazione = $tipo_estrazione
    <br>Data estrazione =  $data_estrazione
    <br>Data assegnazione = $data_assegn
    <br>Ispettore = $verif_inco
    <br>Telefono ispettore = $telefono_opve
    <br>Cellulare ispettore = $verif_cel
    <br>Data ispezione = $data_verifica
    <br>Ora ispezione = $ora_verifica
    <br>data avviso = $data_avviso_01
    <br>&nbsp;
    </li>

    <li><b>Dati del documento</b>
    <br>Descrizione = $desc_tdoc
    <br>Data stampa = $data_stampa
    <br>Protocollo = $protocollo_01
    <br>Data protocollo = $data_prot_01
    <br>Notifica =  $flag_notifica
    <br>Note =  $note
    <br>&nbsp;
    </li>

    <li><b>Dati relativi alle ultime 3 sanzioni non pagate</b>
        <br>&nbsp;
        <br><b>Prima sanzione</b>
        <br>Data scadenza = $data_scad_sanz1
	<br>Importo = $importo_sanz1
	<br>Tipo soggetto = $tipo_soggetto_sanz1
	<br>Codice soggetto = $cod_soggetto_sanz1 
	<br>Nominativo soggetto = $soggetto_sanz1
	<br>Prima sanzione = $sanzione_11
	<br>Seconda sanzione = $sanzione_21
	<br>Data richiesta audizione = $data_rich_audiz1
	<br>Data presentazione deduzioni = $data_pres_deduz1
	<br>Data ricorso al giudice = $data_ric_giudice1
	<br>Data primo ricorso = $data_ric_tar1
	<br>Data secondo ricorso = $data_ric_ulter1
	<br>Data ruolo = $data_ruolo1
	<br>Note richiesta audizione = $note_rich_audiz1
	<br>Note presentazione deduzioni = $note_pres_deduz1
	<br>Note ricorso al giudice = $note_ric_giudice1
	<br>Note primo ricorso = $note_ric_tar1
	<br>Note secondo ricorso = $note_ric_ulter1
	<br>Note ruolo = $note_ruolo1
        <br>&nbsp;
        <br><b>Seconda sanzione</b>
        <br>Data scadenza = $data_scad_sanz2
	<br>Importo = $importo_sanz2
	<br>Tipo soggetto = $tipo_soggetto_sanz2
	<br>Codice soggetto = $cod_soggetto_sanz2 
	<br>Nominativo soggetto = $soggetto_sanz2
	<br>Prima sanzione = $sanzione_12
	<br>Seconda sanzione = $sanzione_22
	<br>Data richiesta audizione = $data_rich_audiz2
	<br>Data presentazione deduzioni = $data_pres_deduz2
	<br>Data ricorso al giudice = $data_ric_giudice2
	<br>Data primo ricorso = $data_ric_tar2
	<br>Data secondo ricorso = $data_ric_ulter2
	<br>Data ruolo = $data_ruolo2
	<br>Note richiesta audizione = $note_rich_audiz2
	<br>Note presentazione deduzioni = $note_pres_deduz2
	<br>Note ricorso al giudice = $note_ric_giudice2
	<br>Note primo ricorso = $note_ric_tar2
	<br>Note secondo ricorso = $note_ric_ulter2
	<br>Note ruolo = $note_ruolo2
        <br>&nbsp;
        <br><b>Terza  sanzione</b>
        <br>Data scadenza = $data_scad_sanz3
	<br>Importo = $importo_sanz3
	<br>Tipo soggetto = $tipo_soggetto_sanz3
	<br>Codice soggetto = $cod_soggetto_sanz3 
	<br>Nominativo soggetto = $soggetto_sanz3
	<br>Prima sanzione = $sanzione_13
	<br>Seconda sanzione = $sanzione_23
	<br>Data richiesta audizione = $data_rich_audiz3
	<br>Data presentazione deduzioni = $data_pres_deduz2
	<br>Data ricorso al giudice = $data_ric_giudice3
	<br>Data primo ricorso = $data_ric_tar3
	<br>Data secondo ricorso = $data_ric_ulter3
	<br>Data ruolo = $data_ruolo3
	<br>Note richiesta audizione = $note_rich_audiz3
	<br>Note presentazione deduzioni = $note_pres_deduz3
	<br>Note ricorso al giudice = $note_ric_giudice3
	<br>Note primo ricorso = $note_ric_tar3
	<br>Note secondo ricorso = $note_ric_ulter3
	<br>Note ruolo = $note_ruolo3
        <br>&nbsp;
    </li>
</ol>

<p>
<br>
<div align=center><input type=button onClick="javascript:window.close();" value ="Chiudi"></input></div>
</br>

</td></tr></table>
</body>
<html>

