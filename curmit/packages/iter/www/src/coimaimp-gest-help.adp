<!--
    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    rom03  03/08/2021 Aggiunta dicitura per gli impianti ibridi su richiesta di Regione Marche.

    sim02  10/12/2019 Aggiunta nota per inserimento allegati 286

    rom01  05/02/2019 Aggiunta nota per tiraggio_fumi di coimdimp-rct-gest

    rom02  15/11/2018 Aggiunta nota per i DFM.

    gac01  06/11/2018 Aggiunto vedi nota per osservazioni, controllo combustibile e prescrizioni
    gac01             per campi della coimdimp-rct-gest e coimdimp-fr-gest

    rom01M  16/10/2018 Aggiunta parte del testo visibile solo se caller è 'ibrido' e una parte
    rom01M             visibile solo se il caller è 'tipo_int'

    sim01  10/09/2014 Aggiunto nuovo campo cod_impianto_princ
-->




<html>
<head>
<title>Help Selezione Impianti</title>
<link rel="stylesheet" href="@css_url;noquote@/header.css" type="text/css">
</head>

<body>

<table><tr><td>
<if @caller@ eq ""><!--rom01 aggiunta if ma non contenuto-->
<br></br>
<p><b>Le date devono essere scritte nel formato gg/mm/aaaa oppure nel formato ggmmaaaa</b>
<p>
</if>
<if @caller@ ne "ibrido" and @caller@ ne "tipo_int" and @caller@ ne "rend_comb" and @caller@ ne "osservaz" and @caller@ ne "raccomandaz" and @caller@ ne "prescriz" and @caller@ ne "cont_rend" and @caller@ ne "rct-assenza-per-comb" and @caller@ ne "rct-idonea-tenuta" and @caller@ ne "tiraggio-fumi" and @caller@ ne "flag-clima-e-prod" and @caller@ ne "flag-pag" and @caller@ ne "aggiungi-dich" and @caller@ ne "dfm" and @caller@ ne "cont_rend_fr" and @caller@ ne "data_ultima_manu" and @caller@ ne "ins-sogg" and @caller@ ne "aggiungi-dich-286"><!--rom01M aggiunta if--><!--sim02 aggiunto aggiungi-dich-286-->
<br></br>
<p><b>Alcune chiarimenti sulle Nomenclature</b>
<p>
<br></br>
<p><b>Conformità: </b>Indica se l'impianto è o meno conforme alle vigenti norme e non ha prescrizioni 
<p>
<br></br>
<p><b>Dichiarato: </b>Sigla per indicare un impianto è dichiarato tramite Documenti regionali (Si) oppure è stato creato acquisendo i dati da altre fonti, ed è in attesa dei documenti 
<p>
<br></br>
<p><b>Impianto di provenienza:</b>Codice del vecchio impianto dimesso
<p>
<br>
<br></br>
<p><b>Stato:</b>Stato dell'impianto (attivo, non attivo, da accatastare, da controllo esterno, rottamato, annullato, Da controllare , rifiutato), è possibile opeare ed inserre la documentazione per i soli impianti attivi
</if>
<if @caller@ eq "ibrido"><!--rom01M aggiunta if e contenuto-->
<br></br>
<p><b>Sistemi Ibridi</b>
<p>Per i sistemi ibridi, occorre compilare solo le schede relative al gruppo termico (GT).</p>
<p><b>Attenzione!</b> non occorre inserire l'RCEE di tipo 2 per la pompa di calore.</p><!--rom03-->
</if>
<if @caller@ eq "tipo_int"><!--rom01M aggiunta if e contenuto-->
<br></br>
<p><b>Tipologia intervento</b>
<p>Quando si inserisce un nuovo impianto <b>appena installato</b>, occorre selezionare  esclusivamente “Nuova Installazione” e riportare la data dell’installazione. 
<p>Quando l’impianto <b>non &egrave; nuovo</b> e, o non &egrave; in CURMIT o &egrave; presente in CURMIT ma solo con dati parziali, occorre compilare il libretto e quindi:
<p>1. se l’impianto non ha ancora il nuovo libretto cartaceo (DM 10 febbraio 2014), selezionare “Compilazione libretto esistente” e mettere la data odierna.
<p>2. se l’impianto ha un libretto cartaceo DM 10 febbraio 2014, occorre copiare in CURMIT il tipo di intervento e la data riportati nel libretto cartaceo.
</if><!--rom01M-->

<!--gac01 da qui gac-->
<if @caller@ eq "rend_comb"><!--gac01 aggiunta if e contenuto-->
  <br></br>
  <p><b>Rend.to di combustione(%)</b>
  <p>Riportare il valore letto, corretto dai 2 punti percentuali previsti dalla normativa UNI 10389-1
</if>

<if @caller@ eq "osservaz"><!--gac01 aggiunta if e contenuto-->
  <br></br>
  <p><b>Osservazioni</b>
  <p>Indicare le cause dei dati negativi rilevati e gli eventuali intervanti manutentivi eseguiti per risolvere il problema.
</if>

<if @caller@ eq "raccomandaz"><!--gac01 aggiunta if e contenuto-->
  <br></br>
  <p><b>Raccomandazioni</b>
  <p>Raccomandazione dettagliata finalizzata alla risoluzione di carenze riscontrate e non eliminate, ma tali comunque da non arrecare immediato pericolo alle persone, agli animali domestici e ai beni. In particolare devono essere indicate le operazioni necessarie per il ripristino delle normali condizioni di funzionamento dell'impianto, alle quali il responsabile deve provvedere entro breve tempo.
</if>

<if @caller@ eq "prescriz"><!--gac01 aggiunta if e contenuto-->
  <br></br>
  <p><b>Prescrizioni</b>
  <p>Indicare detagliatamente le operazioni necessarie al ripristino delle condizioni di sicurezza dell'impianto. Le carenze riscontrate devono essere tali da arrecare un immediato pericolo alle persone, agli animali domestici, ai beni, e da richiedere la <b>messa fuori servizio</b> dell'apparecchio e la <b>diffida di utilizzo</b> dello stesso nei confronti del responsabile.
</if>

<if @caller@ eq "cont_rend"><!--gac01 aggiunta if e contenuto-->
  <br></br>
  <p><b>Controllo del rendimento di combustione</b>
  <p>Attenzione: è possibile effettuare il controllo del rendimento di combustione solo se il combustibile è uno tra i seguenti: gas naturale, propano, GPL, butano, gasolio, olio combustibile, in quanto per gli altri manca una norma UNI di riferimento.
</if>

<if @caller@ eq "rct-assenza-per-comb"><!--gac01 aggiunta if e contenuto-->
  <br></br>
  <p><b>Assenza di perdite di combustibile liquido</b>
  <p>Solo per impianti alimentati a combustibile liquido, da verificare nel tratto visibile della tubazione di adduzione e in particolare all'interno della centrale termica.
</if>

<if @caller@ eq "rct-idonea-tenuta"><!--gac01 aggiunta if e contenuto-->
  <br></br>
  <p><b>Idonea tenuta dell'impianto interno e raccordi con il generatore</b>
  <p>Solo per impianti alimentati a gas. Utilizzare UNI 11137.
</if>

<if @caller@ eq "tiraggio-fumi"><!--rom01 aggiunta if e contenuto-->
  <br></br>
  <p><b>Depressione canale da Fumo (Pa)</b>
  <p>Indicare solo per generatori a tiraggio naturale alimentati a gas: utilizzare UNI 10845.
  <p>Attenzione la misura deve essere espressa in Pascal.
</if>

<if @caller@ eq "flag-clima-e-prod"><!--gac01 aggiunta if e contenuto-->
  <br></br>
  <p><b>Climatizzazione invernale e Produzione di acqua calda sanitaria</b>
  <p>In caso di uso promiscuo, viene indicato per entrambi i campi "Climatizzazione invernale" e "Produzione di acqua calda sanitaria" la voce "Sì".
</if>

<if @caller@ eq "flag-pag"><!--gac01 aggiunta if e contenuto-->
  <br></br>
  <p><b>Segno identificativo pagato</b>
  <p>Se il motivo del controllo è "Cadenza secondo Allegato 3 - L.R. 19/2015", il pagamento del segno identificativo è sempre obbligatorio e quindi, per questo campo, si può selezionare l'opzione "No" solo "per rifiuto del responsabile d'impianto a corrispondere il contributo". Se i motivi del controllo sono: "Prima messa in servizio (nuova installazione)", "Sostituzione del generatore", "Ristrutturazione dell'impianto", "Riattivazione dell'impianto", "Manutenzione straordinaria passibile di modificare l'efficienza energetica", il pagamento del segno identificativo non è mai dovuto e quindi, per questo campo si può selezionare solo l'opzione "No, perchè non dovuto".
</if>
<if @caller@ eq "aggiungi-dich"><!--gac01 aggiunta if e contenuto-->
  <br></br>
  <p><b>Aggiungi dichiarazione art.284 del D.Lgs. 152/2006 (impianti superiori a 35 kW)</b>
  <p>La dichiarazione va redatta dagli installatori per i nuovi impianti e dai manutentori per gli impianti esistenti.
</if>
<if @caller@ eq "aggiungi-dich-286"><!--sim02 aggiunta if e contenuto-->
  <br></br>
  <p><b>Aggiungi dichiarazione art.286 del D.Lgs. 152/2006 - verifica periodica delle emissioni (impianti superiori a 35 kW)</b>
  <p>I controlli annuali dei valori di emissione di cui all'articolo 286, comma 2, e le verifiche di cui all'articolo 286, comma 4, non sono richiesti se l'impianto utilizza i combustibili di cui all'allegato X, parte I, sezione II, paragrafo I, lettere a) (metano), b) (gas di città), c) (GPL), d) (gasolio, kerosene, ecc.), e) (emulsioni acqua-gasolio, acqua-kerosene, ecc.) o i) (biodiesel), e se sono regolarmente eseguite le operazioni di manutenzione periodica previste dal DPR 74/2013. Dal 1° gennaio 2029, gli impianti di cui sopra aventi una potenza nominale al focolare pari o superiore a 1 MW (medi impianti), sono soggetti al controllo di cui all'articolo 286, comma 2 con frequenza triennale. Fino al 31/12/2028, per tali impianti i controlli di cui all'articolo 286, comma 2, non sono richiesti; un controllo è in tutti i casi effettuato entro quattro mesi dalla registrazione di cui all'articolo 284, comma 2-quater.
</if>
<if @caller@ eq "cont_rend_fr"><!--gac01 aggiunta if e contenuto-->
  <br></br>
  <p><b>Controllo del rendimento di combustione</b>
  <p>Attenzione: poichè non è ancora disponibile la norma UNI di riferimento, il controllo del rendimento di combustione non va effettuato.
</if>

<if @caller@ eq "dfm"><!--rom02 if e contenuto-->
  <br></br>
  <p><b>ATTENZIONE:</b>
  <p align="justify">in caso di pi&ugrave; generatori, vanno indicate le funzioni dell'intero impianto(e non di un singolo generatore).
</if> 

<if @caller@ eq "data_ultima_manu">
  <br></br>
  <p><b>Data ultima manutenzione ordinaria effettuata</b>
  <p>In caso di nuova installazione/ristrutturazione/sostituzione del generatore, riportare in questo campo la data del presente controllo.
</if>

<if @caller@ eq "ins-sogg">
  <br></br>
  <p>Inserisci soggetto indicando qui Nome e Cognome
</if>


<br>
<div align=center><input type=button onClick="javascript:window.close();" value ="Chiudi"></input></div>
</br>
</td></tr></table>
</body>
<html>

