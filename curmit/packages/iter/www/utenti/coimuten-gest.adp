<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimuten-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimuten-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimuten-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimuten-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
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
<formwidget   id="last_utente">
<formwidget   id="password">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<!-- TODO: Ricordare di posizionare gli eventuali link ai pgm di zoom -->

<tr><td valign=top align=right class=form_title>Id utente</td>
    <td valign=top><formwidget id="cod_utente">
        <formerror  id="cod_utente"><br>
        <span class="errori">@formerror.cod_utente;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Cognome</td>
    <td valign=top><formwidget id="cognome">
        <formerror  id="cognome"><br>
        <span class="errori">@formerror.cognome;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Nome</td>
    <td valign=top><formwidget id="nome">
        <formerror  id="nome"><br>
        <span class="errori">@formerror.nome;noquote@</span>
        </formerror>
    </td>
</tr>

<!-- <tr><td valign=top align=right class=form_title>Password</td> -->
<!--    <td valign=top><formwidget id="password"> -->
<!--        <formerror  id="password"><br> -->
<!--        <span class="errori">@formerror.password;noquote@</span> -->
<!--        </formerror> -->
<!--    </td> -->
<!-- </tr> -->

<tr><td valign=top align=right class=form_title>Settore</td>
    <td valign=top><formwidget id="id_settore">
        <formerror  id="id_settore"><br>
        <span class="errori">@formerror.id_settore;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Ruolo</td>
    <td valign=top><formwidget id="id_ruolo">
        <formerror  id="id_ruolo"><br>
        <span class="errori">@formerror.id_ruolo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>E mail</td>
    <td valign=top><formwidget id="e_mail">
        <formerror  id="e_mail"><br>
        <span class="errori">@formerror.e_mail;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Righe per pagina</td>
    <td valign=top><formwidget id="rows_per_page">
        <formerror  id="rows_per_page"><br>
        <span class="errori">@formerror.rows_per_page;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Livello</td>
    <td valign=top><formwidget id="livello">
        <formerror  id="livello"><br>
        <span class="errori">@formerror.livello;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

