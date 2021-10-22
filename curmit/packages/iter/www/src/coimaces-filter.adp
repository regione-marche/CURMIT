<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<if @flag_ente@ eq "C">
    <formwidget id="f_comune">
</if>

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
<tr>
   <td align=right colspan=2><a href="#" onclick="javascript:window.open('coimaces-help', 'help', 'scrollbars=yes, resizable=yes, width=570, height=320').moveTo(110,140)"><b>Help</b></a>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Codice dichiarazione</td>
    <td valign=top nowrap><formwidget id="f_cod_acts">
        <formerror  id="f_cod_acts"><br>
        <span class="errori">@formerror.f_cod_acts;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Codice utenza</td>
    <td valign=top nowrap><formwidget id="f_cod_aces_est">
        <formerror  id="f_cod_aces_est"><br>
        <span class="errori">@formerror.f_cod_aces_est;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <if @flag_ente@ eq "P">
       <td valign=top align=right class=form_title>Comune</td>
       <td valign=top><formwidget id="f_comune">
          <formerror  id="f_comune"><br>
          <span class="errori">@formerror.f_comune;noquote@</span>
          </formerror>
       </td>
    </if>
</tr>

<tr>
    <td valign=top align=right class=form_title>Indirizzo</td>
    <td valign=top><formwidget id="f_indirizzo">
        <formerror  id="f_indirizzo"><br>
        <span class="errori">@formerror.f_indirizzo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Cognome intestatario</td>
    <td valign=top nowrap><formwidget id="f_cognome">
        <formerror  id="f_cognome"><br>
        <span class="errori">@formerror.f_cognome;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Natura giuridica</td>
    <td valign=top nowrap><formwidget id="f_natura_giuridica">
        <formerror  id="f_matura_giuridica"><br>
        <span class="errori">@formerror.f_natura_giuridica;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Combustibile</td>
    <td valign=top nowrap><formwidget id="f_cod_combustibile">
        <formerror  id="f_cod_combustibile"><br>
        <span class="errori">@formerror.f_cod_combustibile;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Stato del nominativo acquisito</td>
    <td valign=top nowrap><formwidget id="f_stato">
        <formerror  id="f_stato"><br>
        <span class="errori">@formerror.f_stato;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<tr><td colspan=2 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>


