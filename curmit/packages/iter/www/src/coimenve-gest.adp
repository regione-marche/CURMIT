<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimenve-list?@link_list;noquote@ class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimenve-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimenve-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimenve-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </else>
</tr>
<if @funzione@ ne I>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimopve-list?@link_opve;noquote@ class=func-menu>Operatori</a>
   </td>
</tr>
</if>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_cod_enve">
<formwidget   id="cod_comune">
<formwidget   id="url_enve">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<if @funzione@ ne I>
    <tr><td valign=top align=right class=form_title>Codice</td>
        <td valign=top colspan=3><formwidget id="cod_enve">
            <formerror  id="cod_enve"><br>
            <span class="errori">@formerror.cod_enve;noquote@</span>
            </formerror>
        </td>
    </tr>
</if>

<tr><td valign=top align=right class=form_title>Rag.soc.1</td>
    <td valign=top><formwidget id="ragione_01">
        <formerror  id="ragione_01"><br>
        <span class="errori">@formerror.ragione_01;noquote@</span>
        </formerror>
    </td>
<td valign=top align=right class=form_title>Rag.soc.2</td>
    <td valign=top><formwidget id="ragione_02">
        <formerror  id="ragione_02"><br>
        <span class="errori">@formerror.ragione_02;noquote@</span>
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
    <td valign=top nowrap><formwidget id="comune">@cerca_com;noquote@
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

