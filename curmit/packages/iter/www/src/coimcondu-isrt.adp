<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom01 17/12/2018 Aggiunto asterisco rosso sui campi obbligatori
-->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@js_function;noquote@
<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="dummy">
<formwidget   id="receiving_element">
<formwidget   id="cod_comune">
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>


<tr><td valign=top align=right class=form_title>Cognome<font color=red>*</font></td>
    <td valign=top><formwidget id="cognome">
        <formerror  id="cognome"><br>
        <span class="errori">@formerror.cognome;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Nome<font color=red>*</font></td>
    <td valign=top><formwidget id="nome">
        <formerror  id="nome"><br>
        <span class="errori">@formerror.nome;noquote@</span>
        </formerror>
    </td>
</tr>
<tr>
   <td valign=top align=right class=form_title>Cod.Fisc.<font color=red>*</font></td>
   <td valign=top><formwidget id="cod_fiscale">
       <formerror  id="cod_fiscale"><br>
       <span class="errori">@formerror.cod_fiscale;noquote@</span>
       </formerror>
   </td>
</tr>

<tr>
   <td valign=top align=right class=form_title>Data Patentino<font color=red>*</font></td>
   <td valign=top><formwidget id="data_patentino">
       <formerror  id="data_patentino"><br>
       <span class="errori">@formerror.data_patentino;noquote@</span>
       </formerror>
   </td>
   <td valign=top align=right class=form_title>Ente rilascio patentino<font color=red>*</font></td>
   <td valign=top><formwidget id="ente_rilascio_patentino">
       <formerror  id="ente_rilascio_patentino"><br>
       <span class="errori">@formerror.ente_rilascio_patentino;noquote@</span>
       </formerror>
   </td>
</tr>

<tr><td valign=top align=right class=form_title>Indirizzo<font color=red>*</font></td>
    <td valign=top ><formwidget id="indirizzo">
        <formerror  id="indirizzo"><br>
        <span class="errori">@formerror.indirizzo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Comune<font color=red>*</font></td>
    <td valign=top nowrap><formwidget id="comune">@link_comune;noquote@
        <formerror  id="comune"><br>
        <span class="errori">@formerror.comune;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Provincia<font color=red>*</font></td>
    <td valign=top><formwidget id="provincia">
        <formerror  id="provincia"><br>
        <span class="errori">@formerror.provincia;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>C.A.P.<font color=red>*</font></td>
    <td valign=top><formwidget id="cap">
        <formerror  id="cap"><br>
        <span class="errori">@formerror.cap;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Telefono<font color=red>*</font></td>
    <td valign=top><formwidget id="telefono">
        <formerror  id="telefono"><br>
        <span class="errori">@formerror.telefono;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Cellulare<font color=red>*</font></td>
    <td valign=top><formwidget id="cellulare">
        <formerror  id="cellulare"><br>
        <span class="errori">@formerror.cellulare;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>E-mail<font color=red>*</font></td>
    <td valign=top><formwidget id="email">
        <formerror  id="email"><br>
        <span class="errori">@formerror.email;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Fax<font color=red>*</font></td>
    <td valign=top><formwidget id="fax">
        <formerror  id="fax"><br>
        <span class="errori">@formerror.fax;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Pec<font color=red>*</font></td>
    <td valign=top><formwidget id="pec">
        <formerror  id="pec"><br>
        <span class="errori">@formerror.pec;noquote@</span>
        </formerror>
    </td>
</tr>

<if @funzione@ ne "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>


<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

