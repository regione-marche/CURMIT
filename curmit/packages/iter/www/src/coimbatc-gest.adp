<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimbatc-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <td width="25%" nowrap class=@func_v;noquote@>
       <a href="coimbatc-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
   </td>
   <if @flg_stat@ eq "A">
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimbatc-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica data/ora partenza</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimbatc-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_m;noquote@>
          Modifica data/ora lancio
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
          Cancella
      </td>
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="last_key">
<formwidget   id="current_date">
<formwidget   id="current_time">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<!-- TODO: Ricordare di posizionare gli eventuali link ai pgm di zoom -->

<tr><td valign=top align=right class=form_title>Codice</td>
    <td valign=top><formwidget id="cod_batc">
        <formerror  id="cod_batc"><br>
        <span class="errori">@formerror.cod_batc;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Lavoro</td>
    <td valign=top><formwidget id="nom">
        <formerror  id="nom"><br>
        <span class="errori">@formerror.nom;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Data partenza</td>
    <td valign=top><formwidget id="dat_prev">
        <formerror  id="dat_prev"><br>
        <span class="errori">@formerror.dat_prev;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Ora partenza</td>
    <td valign=top><formwidget id="ora_prev">
        <formerror  id="ora_prev"><br>
        <span class="errori">@formerror.ora_prev;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Utente</td>
    <td valign=top><formwidget id="cod_uten_sch">
        <formerror  id="cod_uten_sch"><br>
        <span class="errori">@formerror.cod_uten_sch;noquote@</span>
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

