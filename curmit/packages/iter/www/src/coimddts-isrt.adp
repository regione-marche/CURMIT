<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>


<center>
@link_head;noquote@
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title width="30%">Data partenza</td>
    <td valign=top width="20%"><formwidget id="dat_prev">
        <formerror  id="dat_prev"><br>
        <span class="errori">@formerror.dat_prev;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title width="15%">Ora partenza</td>
    <td valign=top width="35%"><formwidget id="ora_prev">
        <formerror  id="ora_prev"><br>
        <span class="errori">@formerror.ora_prev;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Sottoscritto sig.</td>
    <td valign=top colspan=3><formwidget id="intestatario">
        <formerror  id="intestatario"><br>
        <span class="errori">@formerror.intestatario;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>in qualit&agrave; di</td>
    <td valign=top colspan=3><formwidget id="titolo">
        <formerror  id="titolo"><br>
        <span class="errori">@formerror.titolo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Della ditta</td>
    <td valign=top colspan=3><formwidget id="cod_distr">
        <formerror  id="cod_distr"><br>
        <span class="errori">@formerror.cod_distr;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Data rif. archivio</td>
    <td valign=top><formwidget id="data_rif">
        <formerror  id="data_rif"><br>
        <span class="errori">@formerror.data_rif;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data documento</td>
    <td valign=top ><formwidget id="data_docu">
        <formerror  id="data_docu"><br>
        <span class="errori">@formerror.data_docu;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Num. protocollo</td>
    <td valign=top><formwidget id="protocollo_01">
        <formerror  id="protocollo_01"><br>
        <span class="errori">@formerror.protocollo_01;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Data protocollo</td>
    <td valign=top><formwidget id="data_protocollo">
        <formerror  id="data_protocollo"><br>
        <span class="errori">@formerror.data_protocollo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Anno di competenza</td>
    <td valign=top colspan=3><formwidget id="anno_competenza">
        <formerror  id="anno_competenza"><br>
        <span class="errori">@formerror.anno_competenza;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Note</td>
    <td valign=top colspan=3><formwidget id="note">
        <formerror  id="note"><br>
        <span class="errori">@formerror.note;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=5>&nbsp;</td></tr>

<tr>
    <td valign=top align=right class=form_title>Data caricamento</td>
    <td valign=top><formwidget id="data_caric">
        <formerror  id="data_caric"><br>
        <span class="errori">@formerror.data_caric;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>File da importare</td>
    <td valign=top colspan=3 nowrap><formwidget id="file_name">
        <formerror  id="file_name"><br>
        <span class="errori">@formerror.file_name;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=5>&nbsp;</td></tr>

<tr><td colspan=5 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

