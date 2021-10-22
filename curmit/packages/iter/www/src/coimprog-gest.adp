<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimprog-list?@link_list;noquote@ class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimprog-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimprog-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimprog-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
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
<formwidget   id="last_cognome">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<if @funzione@ ne I>
    <tr><td valign=top align=right class=form_title>Codice</td>
        <td valign=top colspan=3><formwidget id="cod_progettista">
            <formerror  id="cod_progettista"><br>
            <span class="errori">@formerror.cod_progettista;noquote@</span>
            </formerror>
        </td>
    </tr>
</if>

<tr><td valign=top align=right class=form_title>Cognome</td>
    <td valign=top><formwidget id="cognome">
        <formerror  id="cognome"><br>
        <span class="errori">@formerror.cognome;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Nome</td>
    <td valign=top><formwidget id="nome">
        <formerror  id="nome"><br>
        <span class="errori">@formerror.nome;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Indirizzo</td>
    <td valign=top colspan=3><formwidget id="indirizzo">
        <formerror  id="indirizzo"><br>
        <span class="errori">@formerror.indirizzo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Comune</td>
    <td valign=top nowrap><formwidget id="comune">@link_comune;noquote@
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
    <td valign=top align=right class=form_title>C.A.P.</td>
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

<tr><td valign=top align=right class=form_title>Localit&agrave;  reg imp.</td>
    <td valign=top><formwidget id="localita_reg">
        <formerror  id="localita_reg"><br>
        <span class="errori">@formerror.localita_reg;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Reg. Imprese</td>
    <td valign=top><formwidget id="reg_imprese">
        <formerror  id="reg_imprese"><br>
        <span class="errori">@formerror.reg_imprese;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Localit&agrave; Rea</td>
    <td valign=top><formwidget id="localita_rea">
        <formerror  id="localita_rea"><br>
        <span class="errori">@formerror.localita_rea;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Rea</td>
    <td valign=top><formwidget id="rea">
        <formerror  id="rea"><br>
        <span class="errori">@formerror.rea;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Capitale sociale</td>
    <td valign=top colspan=3><formwidget id="capit_sociale">
        <formerror  id="capit_sociale"><br>
        <span class="errori">@formerror.capit_sociale;noquote@</span>
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


<if @funzione@ ne "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

