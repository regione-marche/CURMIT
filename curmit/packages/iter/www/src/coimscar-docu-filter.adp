<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Data stampa</td>
    <td valign=top><formwidget id="f_data_stampa">
        <formerror  id="f_data_stampa"><br>
        <span class="errori">@formerror.f_data_stampa;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>Tipo documento</td>
    <td valign=top><formwidget id="f_tipo_documento">
        <formerror  id="f_tipo_documento"><br>
        <span class="errori">@formerror.f_tipo_documento;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>Formato</td>
    <td valign=top>
        <table>
        <formgroup id="f_formato">
           <tr><td>@formgroup.widget;noquote@ @formgroup.label;noquote@</td></tr>
        </formgroup>
           <tr>
               <td>
               <formerror id="f_formato">
               <span class="errori">@formerror.f_formato;noquote@</span>
               </formerror>
               </td>
           </tr>
        </table>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>
<tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>


