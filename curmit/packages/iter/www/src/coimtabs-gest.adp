<!--
    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    san01  22/08/2014 Gestito campo range_value
-->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimtabs-list?@link_list;noquote@ class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v@>
         <a href="coimtabs-gest?funzione=V&@link_gest@" class=@func_v@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m@>
         <a href="coimtabs-gest?funzione=M&@link_gest@" class=@func_m@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d@>
         <a href="coimtabs-gest?funzione=D&@link_gest@" class=@func_d@>Cancella</a>
      </td>
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>


<tr><td valign=top align=right class=form_title>Nome tabella</td>
    <td valign=top nowrap><formwidget id="nome_tabella">
        <formerror  id="nome_tabella"><br>
        <span class="errori">@formerror.nome_tabella@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Nome colonna</td>
    <td valign=top nowrap><formwidget id="nome_colonna">
        <formerror  id="nome_colonna"><br>
        <span class="errori">@formerror.nome_colonna@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Tipo dato</td>
    <td valign=top nowrap><formwidget id="tipo_dato">
        <formerror  id="tipo_dato"><br>
        <span class="errori">@formerror.tipo_dato@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Dimensione</td>
    <td valign=top nowrap><formwidget id="dimensione">
        <formerror  id="dimensione"><br>
        <span class="errori">@formerror.dimensione@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Obbligatorio (S/N)</td>
    <td valign=top nowrap><formwidget id="obbligatorio">
        <formerror  id="obbligatorio"><br>
        <span class="errori">@formerror.obbligatorio@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Ordinamento</td>
    <td valign=top nowrap><formwidget id="ordinamento">
        <formerror  id="ordinamento"><br>
        <span class="errori">@formerror.ordinamento@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Range Valori</td><!-- san01 -->
    <td valign=top nowrap><formwidget id="range_value"><!-- san01 -->
        <formerror  id="range_value"><br><!-- san01 -->
        <span class="errori">@formerror.range_value@</span><!-- san01 -->
        </formerror><!-- san01 -->
    </td><!-- san01 -->
</tr><!-- san01 -->

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

