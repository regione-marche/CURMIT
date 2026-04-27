<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context_bar">@context_bar;noquote@</property>
  <property name="riga_vuota">f</property>
<center>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="cod_impianto">


<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">

<formwidget   id="url_aimp">
<formwidget   id="url_list_aimp">


<table width=100%>
    <tr>
    	<td colspan=10 align="center" class="errori">@errori;noquote@</td>
    </tr>
    <tr>
        <td colspan=1>&nbsp;</td>
    </tr>
    <tr>
        <td align=center class=form_title width=100%><b>Comunicazione cambio del nominativo del responsabile dell'impianto termico</b></td>
    </tr>
    <tr>
        <td align=center class=form_title width=100%>(La dichiarazione deve essere effettuata dal nuovo Responsabile dell'impianto termico)</td>
    </tr>
    <tr>
        <td width=40%>&nbsp;<td>
	<td align=left class=form_title><b>Al (nome del soggetto esecutore)</b> @soggetto_esecutore@</td>
    </tr>
    <tr>
	<td width=40%>&nbsp;<td>
        <td align=left class=form_title><b>soggetto_esecutore</b></td>
    </tr>
    <tr>
        <td width=40%>&nbsp;<td>
	<td align=left class=form_title><b>per i controlli di cui all'articolo 9 del D.Lgs 192/2005</b></td>
    </tr>
    <tr>
        <td width=40%>&nbsp;<td>
	<td align=left class=form_title><b>Ufficio</b> @ufficio_soggetto_esecutore@</td>
    </tr>
    <tr>
        <td width=40%>&nbsp;<td>
	<td align=left class=form_title><b>Via</b> @indirizzo_soggetto_esecutore@</td>
    </tr>
    <tr>
	<td width=40%>&nbsp;<td>
	<td align=left class=form_title><b>Città</b> @citta_soggetto_esecutore@</td>
    </tr>
</table>    
<table width=100%>
<if @flag_type_document@ == "CCR"> 
    <tr>
        <td width=100%><b>Oggetto: Comunicazione cambio nominativo del Responsabile delle'impianto termico</b></td>
    </tr>
    <tr>
        <td width=100%>(Dichiarazione sostitutiva dell'atto di notorietà ai sensi dell'articolo 46 del D.P.R. 28/12/000 n. 445)</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
    </tr>
</if>
    <tr>
        <td>Il/La sottoscritto/a @nome_cittadino@</td>
    </tr>
    <tr>
        <td>Residente in @localita@</td>
	<td>Provincia @provincia_cittadino@</td>
    </tr>
    <tr>
        <td>Via @indirizzo_cittadino@</td>
    </tr>
    <tr>
        <td>Telefono @telefono_cittadino@</td>
	<td>Cellulare @cellulare_cittadino@</td>
	<td>Fax @fax_cittadino@</td>
    </tr>
    <tr>
        <td><i>Consapevole delle responsabilità e delle sanzioni penali stabilite dalla Legge per false attestazioni e mendaci dichiarazioni (articolo 76 del D.P.R. 445/2000), sotto la sua personale responsabilità<i></td>
    </tr>
    <tr>
        <td align=center><b><u>DICHIARA</u></b></td>
    </tr>
    <tr>
        <td>Di essere il Responsabile dell'esercizio e della manutenzione dell'impianto termico:</td>
    </tr>
    <tr>
        <td>Catasto impianto/codice @cod_impianto_est@</td>
    </tr>	
    <tr>
        <td>Sito in via @indirizzo_impianto@</td>
	<td>Comune di @localita_impianto@</td>
	<td>Provincia @provincia_impianto@</td>
    </tr>
    <tr>
        <td>Di potenza termica utile nominale complessiva pari a @pot_utile_nom@ kW</td>
    </tr>
    <tr>
        <td>Dalla data del</td>
	<td align=left>
	    <formwidget id="data_inizio">
	    <formerror  id="data_inizio">
	      <br>
            <span class="errori">@formerror.data_inizio;noquote@</span>
	    </formerror>	
        </td>
    </tr>
    <tr>
        <td>In qualità di:</td>
    </tr>
    <tr>
    </tr>	
    <tr>
        <td>Precedentemente reesoinsabile dell'impianto termico (fino alla data del @data_fine@):
    </tr>
    <tr>
        <td>(nome e cognome o ragione sociale) @vecchio_responsabile@:
    </tr>
    <tr>
	<td><i>Dichiara altresi di essere informato, ai sensi e per gli effetti di cui all'articolo 10 della Legge 675/96, che i dati personali raccoltii saranno trattati, anche con strumenti informatici, esclusivamente nell'ambito del procedimenti per il quale la presente dichiarazione viene resa</i></td>
    </tr>
    <tr>
	<td>Nominativo del fornitore di energia @fornitore_energia@</td>
    </tr>
    <tr>
        <td>Data @data@</td>
	<td>Firma @soggetto_esecutore@</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td><b>Allegato</b>: fotocopia di un documento valido di identità del dichiarante</td>
    </tr>
</if>
      <tr>
	<td align=right>abilitata ad operare per gli impianti di cui alle lettere:</td>
	<td colspan=9>
	  <table width=100%>
	    <tr>
	      <td>a)<formgroup id="flag_a">@formgroup.widget;noquote@</formgroup></td>
	      <td>b)<formgroup id="flag_b">@formgroup.widget;noquote@</formgroup></td>
	      <td>c)<formgroup id="flag_c">@formgroup.widget;noquote@</formgroup></td>
	      <td>d)<formgroup id="flag_d">@formgroup.widget;noquote@</formgroup></td>
	      <td>e)<formgroup id="flag_e">@formgroup.widget;noquote@</formgroup></td>
	      <td>f)<formgroup id="flag_f">@formgroup.widget;noquote@</formgroup></td>
	      <td>g)<formgroup id="flag_g">@formgroup.widget;noquote@</formgroup></td>
	    </tr>
	  </table>
	</td>
      </tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=8 align=center><formwidget id="submit_btn"></td></tr>
</if>

</table>


<!-- Fine della form colorata -->
</formtemplate>
<p>
</center>


