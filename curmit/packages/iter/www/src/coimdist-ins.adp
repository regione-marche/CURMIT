<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimdist-reg?@link_list;noquote@ class=func-menu>Ritorna</a>
   </td>
   <td width="75%" nowrap class=func-menu>&nbsp;</td>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_cod_distr">
<formwidget   id="cod_comune">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<!-- TODO: Ricordare di posizionare gli eventuali link ai pgm di zoom -->
<if @funzione@ ne I>
    <tr><td valign=top align=right class=form_title>Codice</td>
        <td valign=top colspan=3><formwidget id="cod_distr">
            <formerror  id="cod_distr"><br>
            <span class="errori">@formerror.cod_distr;noquote@</span>
            </formerror>
        </td>
    </tr>
</if>

<tr><td valign=top align=right class=form_title>Ragione sociale</td>
    <td valign=top colspan=3><formwidget id="ragione_01">
        <formerror  id="ragione_01"><br>
        <span class="errori">@formerror.ragione_01;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Indirizzo</td>
    <td valign=top><formwidget id="indirizzo">
        <formerror  id="indirizzo"><br>
        <span class="errori">@formerror.indirizzo;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Civico</td>
    <td valign=top><formwidget id="numero">
        <formerror  id="numero"><br>
        <span class="errori">@formerror.numero;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Comune</td>
    <td valign=top><formwidget id="comune">@cerca_com;noquote@
        <formerror  id="comune"><br>
        <span class="errori">@formerror.comune;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Localit&agrave;</td>
    <td valign=top><formwidget id="localita">
        <formerror  id="localita"><br>
        <span class="errori">@formerror.localita;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Provincia</td>
    <td valign=top><formwidget id="provincia">
        <formerror  id="provincia"><br>
        <span class="errori">@formerror.provincia;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>C.A.P</td>
    <td valign=top><formwidget id="cap">@link_cap;noquote@
        <formerror  id="cap"><br>
        <span class="errori">@formerror.cap;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Cod. Fiscale</td>
    <td valign=top><formwidget id="cod_fiscale">
        <formerror  id="cod_fiscale"><br>
        <span class="errori">@formerror.cod_fiscale;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>P. IVA</td>
    <td valign=top><formwidget id="cod_piva">
        <formerror  id="cod_piva"><br>
        <span class="errori">@formerror.cod_piva;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Telefono</td>
    <td valign=top><formwidget id="telefono">
        <formerror  id="telefono"><br>
        <span class="errori">@formerror.telefono;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Cellulare</td>
    <td valign=top><formwidget id="cellulare">
        <formerror  id="cellulare"><br>
        <span class="errori">@formerror.cellulare;noquote@</span>
        </formerror>
    </td>
</tr>


<tr><td valign=top align=right class=form_title>E-mail</td>
    <td valign=top><formwidget id="email">
        <formerror  id="email"><br>
        <span class="errori">@formerror.email;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Fax</td>
    <td valign=top><formwidget id="fax">
        <formerror  id="fax"><br>
        <span class="errori">@formerror.fax;noquote@</span>
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

<tr><td valign=top align=right class=form_title>Tracciato record</td>
    <td valign=top colspan=3><formwidget id="tracciato">
        <formerror  id="tracciato"><br>
        <span class="errori">@formerror.tracciato;noquote@</span>
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

