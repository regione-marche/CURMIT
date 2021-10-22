<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>


<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="dummy">
<formwidget   id="cod_manutentore">
<if @flag_ente@ eq C>
    <formwidget id="f_cod_comune">
</if>
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>


<tr><td valign=top align=right class=form_title>Da data Inserimento Dichiarazione</td>
    <td valign=top><formwidget id="f_data_da">
        <formerror  id="f_data_da"><br>
        <span class="errori">@formerror.f_data_da;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>A data Inserimento Dichiarazione</td>
    <td valign=top nowrap><formwidget id="f_data_a">
        <formerror  id="f_data_a"><br>
        <span class="errori">@formerror.f_data_a;noquote@</span>
        </formerror>
    </td>
</tr>

<if @flag_ente@ ne C>
    <tr><td valign=top align=right class=form_title>Comune</td>
        <td valign=top><formwidget id="f_cod_comune">
            <formerror  id="f_cod_comune"><br>
            <span class="errori">@formerror.f_cod_comune;noquote@</span>
            </formerror>
        </td>
    </tr>
</if>

<tr><td valign=top align=right class=form_title>Fascia di Potenza</td>
    <td valign=top><formwidget id="cod_potenza">
        <formerror  id="cod_potenza"><br>
        <span class="errori">@formerror.cod_potenza;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>Combustibile</td>
    <td valign=top><formwidget id="cod_combustibile">
        <formerror  id="cod_combustibile"><br>
        <span class="errori">@formerror.cod_combustibile;noquote@</span>
        </formerror>
    </td>
<tr>
    <td valign=top align=right class=form_title>Manutentore</td>
    <td valign=top colspan=3><formwidget id="cognome_manu"><formwidget id="nome_manu">@cerca_manu;noquote@
        <formerror  id="cognome_manu"><br>
        <span class="errori">@formerror.cognome_manu;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Da data controllo</td>
    <td valign=top><formwidget id="f_data_controllo_iniz">
        <formerror  id="f_data_controllo_iniz"><br>
        <span class="errori">@formerror.f_data_controllo_iniz;noquote@</span>
        </formerror>
    </td>   
</tr>

<tr><td valign=top align=right class=form_title>A data controllo</td>
    <td valign=top><formwidget id="f_data_controllo_fine">
        <formerror  id="f_data_controllo_fine"><br>
        <span class="errori">@formerror.f_data_controllo_fine;noquote@</span>
        </formerror>
    </td>   
</tr>

<if @coimtgen.ente@ eq "PGO"
and @cod_manutentore@ eq "">
<tr>
    <td valign=top align=right class=form_title>Utente Emmegi - digitare 01/02/..</td>
    <td valign=top colspan=3><formwidget id="ute_emmegi">
        <formerror  id="ute_emmegi"><br>
        <span class="errori">@formerror.ute_emmegi;noquote@</span>
        </formerror>
    </td>
</tr>
</if>
<else>
    <formwidget id="ute_emmegi">
</else>

<if @id_ruolo@ eq admin>
  <tr>
    <td valign=top align=right class=form_title>Utente</td>
    <td valign=top colspan=3><formwidget id="f_utente">
	<formerror  id="f_utente"><br>
	  <span class="errori">@formerror.f_utente;noquote@</span>
	</formerror>
    </td>   
</if>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ eq "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

