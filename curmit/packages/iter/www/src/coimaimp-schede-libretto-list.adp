<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom05 16/04/2019 Aggiunti immagini che indicano se all'interno delle schede sono presenti
    rom05            dati obbligatori non compilati.

    rom04 08/01/2019 Modificata label per scheda 4, in base al flag_tipo_impianto mostro 
    rom04            messaggi diversi.

    gac02 10/12/2018 ora la scheda 1.6 è stata unita alla scheda 1.1 quindi devo togliore i 
    gac02            link "inserisci/modifica" e dargli un messaggio diverso.

    rom03 15/11/2018 Aggiunti titoli per Schede 11, 12, 13 e 14

    rom02 28/08/2018 Modificata label per Scheda 4.1, 4.1bis, 4.2 su richiesta delle Marche.

    rom01 07/08/2018 Modificate label su richiesta della Regione Marche.

    gac01 02/07/2018 Modificate label

    gab01 17/08/2016 Gestite nuove pagine del libretto (8.1, 9.1, 9.2, 9.3, 9.4 ).
-->
<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>
@link_tab;noquote@
@dett_tab;noquote@

<br>
<center>

<table border=0>
  <tr>
      <!--rom01	<b>Scheda 1: Dati Tecnici</b> -->
    <td align=right>@img_imp;noquote@</td><!--rom05-->
    <td>
      <b>Scheda 1: Scheda identificativa dell'impianto (parziale)</b><!--rom01-->
      <br>@link_scheda_1;noquote@
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td align=right>@img_imp_1bis;noquote@</td><!--rom05-->
     <td>
	<b>Scheda 1Bis: Dati Generali - Scheda 1.6: Soggetti che operano sull'impianto</b>
     	<br>@link_scheda_1bis;noquote@
     </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td align=right>@img_ubic;noquote@</td><!--rom05-->
     <td>
	<b>Scheda 1.2: Ubicazione</b>
     	<br>@link_scheda_1_2;noquote@
     </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td>&nbsp;</td>
    <td>
      <b>Scheda 1.6: Soggetti che operano sull'impianto</b><!--gac01-->
      <!--gac02     	<br>@link_scheda_1_6;noquote@-->
      <br>Scheda a compilazione automatica, derivante dall'inserimento della 
      <br>Scheda 1Bis: Dati Generali e visualizzabile nella "Stampa Libretto".
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  
<!--Sandro al momento vuole mantenere separatte le schede principali dal precedente programma altre schede. Se bisognerà farle insieme basta scommentare 
  <tr>
     <td>
	<b>Scheda 2: Trattamento acqua</b>
     	<br>@link_modifica;noquote@
     </td>
  </tr>
  <tr>
  </tr>
  <tr><td>&nbsp;</td></tr>
-->

<if @uten@ ne "enve" and @uten@ ne "opve" and  @uten@ ne "coop_resp" and  @uten@ ne "coop_modh" and  @uten@ ne "coop_rappv">
  <tr>
    <td align=right>@img_resp;noquote@</td><!--rom05-->
     <td>
	<b>Scheda 3: Nomina Terzo Responsabile</b>
     	<br>@link_scheda_3;noquote@
     </td>
  </tr>

  <tr><td>&nbsp;</td></tr>
</if>
  <tr>
    <td align=right>@img_gen;noquote@</td><!--rom05-->
    <td>
      <if @flag_tipo_impianto@ eq "R"><!--rom04 aggiunta if ma non contenuto-->
	<!--rom02<b>Scheda 4 / 4.1 bis Generatori</b> -->
	<b>Schede 4.1, 4.1 bis: Gruppi Termici - Scheda 4.2: Bruciatori</b><!--rom02 Modificata label su richiesta della Regione Marche-->
      </if>
      <if @flag_tipo_impianto@ eq "F"><!--rom04 aggiunta if e contenuto-->
	<b>Schede 4.4, 4.4 bis: Macchine frigorifere / Pompe di calore</b>
      </if>
      <if @flag_tipo_impianto@ eq "T"><!--rom04 aggiunta if e contenuto-->
	<b>Schede 4.5, 4.5 bis:</b>
      </if>
      <if @flag_tipo_impianto@ eq "C"><!--rom04 aggiunta if e contenuto-->
	<b>Schede 4.6., 4.6 bis:</b>
      </if>
     	<br>@link_scheda_4;noquote@
     </td>
  </tr>
  <tr><td>&nbsp;</td></tr>

<!--Sandro al momento vuole mantenere separatte le schede principali dal precedente programma altre schede. Se bisognerà farle insieme basta scommentare 
  <tr>
     <td>
	<b>Scheda 4.3: Lista Recuperatori/condensatori</b>
     	<br>@link_aggiungi;noquote@
     </td>
  </tr>
  <tr>
     <td>@table_result;noquote@</td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <tr>
     <td>
         <b>Scheda 4.7: Lista Campi Solari</b>
	 <br>@link_aggiungi_2;noquote@
     </td>
  </tr>
  <tr>
     <td>@table_result_2;noquote@</td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <tr>
     <td>
        <b>Scheda 4.8: Lista Altri Generatori</b>
	<br>@link_aggiungi_3;noquote@
     </td>
  </tr>
  <tr>
     <td>@table_result_3;noquote@</td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <tr>
     <td>
        <b>Scheda 5: Regolazione e contabilizzazione</b>
	<br>@link_modifica_2;noquote@
     </td>
  </tr>
  <tr>

  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr>
     <td>
        <b>Scheda 6: Sistemi di Distribuz.</b>
	<br>@link_modifica_3;noquote@
     </td>
  </tr>
  <tr>

  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr>
     <td>
        <b>Scheda 7: Sistema di Emiss.</b>
	<br>@link_modifica_4;noquote@
     </td>
  </tr>
  <tr>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <tr>
     <td>
        <b>Scheda 8: Lista Accumuli</b>
        <br>@link_aggiungi_4;noquote@
     </td>
  </tr>
  <tr>
     <td>@table_result_4;noquote@</td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <tr>
     <td>
        <b>Scheda 9.1: Lista Torri Evaporative</b>
        <br>@link_aggiungi_5;noquote@
     </td>
  </tr>
  <tr>
     <td>@table_result_5;noquote@</td>
  </tr>
  <tr><td>&nbsp;</td></tr>  


  <tr>
     <td>
        <b>Scheda 9.2: Lista Raffreddatori di Liquido</b>
        <br>@link_aggiungi_6;noquote@
     </td>
  </tr>
  <tr>
     <td>@table_result_6;noquote@</td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <tr>
     <td>
        <b>Scheda 9.3: Lista Scambiatori di Calore Intermedi</b>
        <br>@link_aggiungi_7;noquote@
     </td>
  </tr>
  <tr>
     <td>@table_result_7;noquote@</td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <tr>
     <td>
        <b>Scheda 9.4: Lista Circuiti Interrati a Condensazione/Espansione Diretta</b>
        <br>@link_aggiungi_8;noquote@
     </td>
  </tr>
  <tr>
     <td>@table_result_8;noquote@</td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <tr>
     <td>
      <b>Scheda 9.5: Lista Unità di Trattamento Aria</b>
      <br>@link_aggiungi_9;noquote@
     </td>
  </tr>
  <tr>
     <td>@table_result_9;noquote@</td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <tr>
     <td>
      <b>Scheda 9.6: Lista Recuperatori di Calore</b>
      <br>@link_aggiungi_10;noquote@
     </td>
  </tr>
  <tr>
     <td>@table_result_10;noquote@</td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <tr>
     <td>
      <b>Scheda 10.1: Lista Impianti di Ventilazione Meccanica Controllata</b>
      <br>@link_aggiungi_11;noquote@
     </td>
  </tr>
  <tr>
     <td>@table_result_11;noquote@</td>
  </tr>
  <tr><td>&nbsp;</td></tr>
-->

<if @uten@ ne "coop_rappv">
  <tr>
    <td>&nbsp;</td>
    <td>
      <b>@label_dichiarazioni;noquote@</b>
      <!--rom03 <br>@link_scheda_11;noquote@-->
      <br>Scheda a compilazione automatica, derivante dall'Inserimento dei moduli RCEE
      <br>(men&ugrave; "inserisci moduli regionali") e visualizzabile nella "Stampa libretto".<!--rom03 modificata frase -->
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td>&nbsp;</td>
    <td>
      <b>Scheda 12</b>
      <br>Scheda a compilazione automatica, derivante dall'Inserimento dei moduli RCEE
      <br>(men&ugrave; "inserisci moduli regionali") e visualizzabile nella "Stampa libretto".<!--rom03 Aggiunta frase per Scheda 12-->
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
</if>
  <tr>
    <td align=right>&nbsp;</td><!--rom05-->
    <td>
      <b>Scheda 13: Rapp. Ispezione</b>
      <br>Scheda a compilazione automatica, derivante dall'Inserimento dei
      <br>Rapporti di ispezione e visualizzabile nella "Stampa libretto".<!--rom03 modificata frase-->
      <br>@link_scheda_13;noquote@
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td>&nbsp;</td>
    <td>
      <b>Scheda 14</b>
      <br>Scheda a compilazione automatica, derivante dall'Inserimento dei moduli RCEE
      <br>(men&ugrave; "inserisci moduli regionali") e visualizzabile nella "Stampa libretto".<!--rom03 Aggiunta frase per Scheda 14-->
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
</table>













