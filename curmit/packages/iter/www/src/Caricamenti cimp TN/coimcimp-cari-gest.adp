<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>


<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="current_date">
<formwidget   id="current_time">

<!-- Inizio della form colorata -->

<if @funzione@ eq I>
<table border=0 width="100%">
<tr><td>&nbsp;</td></tr>
<tr>
    <td valign=top align=right class=form_title>Controlli inferiori a 35 kW da importare</td>
    <td valign=top><formwidget id="file_name">
        <formerror  id="file_name"><br>
        <span class="errori">@formerror.file_name;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Controlli superiori a 35 kW da importare</td>
    <td valign=top><formwidget id="file_name2">
        <formerror  id="file_name2"><br>
        <span class="errori">@formerror.file_name2;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Schede rilievo gasolio da importare</td>
    <td valign=top><formwidget id="file_name3">
        <formerror  id="file_name3"><br>
        <span class="errori">@formerror.file_name3;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Schede rilievo metano da importare</td>
    <td valign=top><formwidget id="file_name4">
        <formerror  id="file_name4"><br>
        <span class="errori">@formerror.file_name4;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Schede rilievo serb. gasolio da importare</td>
    <td valign=top><formwidget id="file_name5">
        <formerror  id="file_name5"><br>
        <span class="errori">@formerror.file_name5;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->

<if @funzione@ eq "I">

<tr><td valign=top class=form_title colspan=2>
<br><br>    Da questa pagina &egrave; possibile caricare nuovi controlli/schede di rilievo utilizzando un file csv.
<br> Le varie colonne del file devono essere seperate da separatore di elenco punto e virgola (;).
</td></tr>

</if>
</table>
</if>
<if @funzione@ eq "V">
<table border=0 cellspacing=0 cellpadding=0 align="center">
<tr><td><br></td></tr>
<tr><td valign=top colspan="3" align="center"><b>Controlli inferiori a 35 kW<b></td></tr>
<tr><td valign=top>controlli caricati:</td><td width="30" align="center">@conta_c_inf;noquote@</td></tr>
<tr><td valign=top>controlli non caricati:</td><td width="30" align="center">@righe_con_errori;noquote@</td><td><a href="../spool/rapporti-ver-inf.txt">Scarica file cvs</a></td></tr>
<tr><td valign=top>errori riscontrati:</td><td width="30" align="center">@conta_c_inf_err;noquote@</td></tr>
<tr><td valign=top>&nbsp;</td></tr>

<tr><td valign=top colspan="3" align="center"><b>Controlli superiori a 35 kW<b></td></tr>
<tr><td valign=top>controlli caricati:</td><td width="30" align="center">@conta_sup;noquote@</td></tr>
<tr><td valign=top>controlli non caricati:</td><td width="30" align="center">@righe_con_errori2;noquote@</td><td><a href="../spool/rapporti-ver-sup.txt">Scarica file cvs</a></td></tr>
<tr><td valign=top>errori riscontrati:</td><td width="30" align="center">@conta_sup_err;noquote@</td></tr>
<tr><td valign=top>&nbsp;</td></tr>

<tr><td valign=top colspan="3" align="center"><b>Schede rilievo metano<b></td></tr>
<tr><td valign=top>controlli caricati:</td><td width="30" align="center">@conta_schemet;noquote@</td></tr>
<tr><td valign=top>controlli non caricati:</td><td width="30" align="center">@conta_schemet_err;noquote@</td><td><a href="../spool/scheda-ril-metano.txt">Scarica file cvs</a></td></tr>
<tr><td valign=top>&nbsp;</td></tr>

<tr><td valign=top colspan="3" align="center"><b>Schede rilievo gasolio<b></td></tr>
<tr><td valign=top>controlli caricati:</td><td width="30" align="center">@conta_schegas;noquote@</td></tr>
<tr><td valign=top>controlli non caricati:</td><td width="30" align="center">@conta_schegas_err;noquote@</td><td><a href="../spool/scheda-ril-gasolio.txt">Scarica file cvs</a></td></tr>
<tr><td valign=top>&nbsp;</td></tr>

<tr><td valign=top colspan="3" align="center"><b>Schede rilievo serbatoi gasolio<b></td></tr>
<tr><td valign=top>controlli caricati:</td><td width="30" align="center">@conta_scheserb;noquote@</td></tr>
<tr><td valign=top>controlli non caricati:</td><td width="30" align="center">@conta_scheserb_err;noquote@</td><td><a href="../spool/scheda-serb-gasolio.txt">Scarica file cvs</a></td></tr>

</table>
<p>
<center>
<a href="coimcimp-cari-gest-up?nome_funz=cari-up&uno=rapporti-ver-inf-chr.txt&due=rapporti-ver-sup-chr.txt&tre=scheda-ril-metano-chr.txt&quattro=scheda-ril-gasolio-chr.txt&cinque=scheda-serb-gasolio-chr.txt">Carica i dati corretti</a>
</center><br>
- Per visionare gli errori che hanno impedito ai file di essere caricati scaricare i file csv, <b>in coda alle righe indicate sono segnalati gli errori per cui la riga è stata scartata</b>, il marcatore delle righe scartate è il carattere <b>';'</b>.<br>
- Per poter scaricare il file csv premere con il <b>tasto destro del mouse sul link che si desidera scaricare</b>, scegliere quindi <b>'Salva oggetto con nome'</b>, scegliere dove salvare il file e quindi premere su <b>'OK'</b>.<br>
</p>
</if>

</formtemplate>
<p>
</center>

