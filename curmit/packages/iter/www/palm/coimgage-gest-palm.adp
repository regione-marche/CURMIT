<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>
<center>
@dett_tab;noquote@

<table width="240" cellspacing=0 class=func-menu>
   <tr>
      <td width="50%" nowrap class=func-menu>
         <a href="coimgage-list-palm?@link_list;noquote@" class=func-menu>Ritorna</a>
      </td>

      <td width="50%" nowrap class=@func_v;noquote@>
         <a href="coimgage-gest-palm?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
   </tr>
   <tr>
      <td width="50%" nowrap class=@func_m;noquote@>
         <a href="coimgage-gest-palm?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>

      <td width="50%" nowrap class=@func_d;noquote@>
         <a href="coimgage-gest-palm?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </tr>

   <tr>
   <if @sw_ins_dimp@ eq "t">
       <td width="50%" nowrap class=func-menu>
           <a href="coimdimp-gest-palm?funzione=I&@link_dimp;noquote@" class=func-menu>Inserimento Mod. H</a>
       </td>
   </if>
   <else>
       <td width="50%" nowrap class=func-menu>
           <a href="coimdimp-gest-palm?funzione=V&@link_dimp;noquote@" class=func-menu>Gestione Mod. H</a>
       </td>
   </else>
   <if @sw_ins_dimp@ eq "t" and @cod_dimp@ ne "">
       <td width="50%" nowrap class=func-menu>
           <a href="coimdimp-gest-palm?funzione=V&@link_dimp;noquote@" class=func-menu>Ultimo Mod. H</a>
       </td>
   </if>
   <else>
       <td width="50%" class=func-menu>&nbsp;</td>
   </else>
   </tr>
</table>

<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_key">
<formwidget   id="cod_opma">
<formwidget   id="cod_impianto">
<formwidget   id="data_ins">
<formwidget   id="stato">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>


<tr><td valign=top align=right class=form_title>Stato</td>
    <td valign=top><formwidget id="stato_ed">
        <formerror  id="stato_ed"><br>
        <span class="errori">@formerror.stato_ed;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Data prevista</td>
    <td valign=top><formwidget id="data_prevista">
        <formerror  id="data_prevista"><br>
        <span class="errori">@formerror.data_prevista;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Data esecuzione</td>
    <td valign=top><formwidget id="data_esecuzione">
        <formerror  id="data_esecuzione"><br>
        <span class="errori">@formerror.data_esecuzione;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Note</td>
    <td valign=top><formwidget id="note">
        <formerror  id="note"><br>
        <span class="errori">@formerror.note;noquote@</span>
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

