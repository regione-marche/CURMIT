<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimacts-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimacts-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimacts-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimacts-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </else>
</tr>
<tr>
   <if @funzione@ eq "I">
      <td width="100%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=func-menu>
         <a href="coimdocu-gest?funzione=V&@link_docu;noquote@">Documento</a>
      </td>
      <td colspan=3 width="75%" nowrap class=func-menu>&nbsp;</td>
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
<formwidget   id="last_cod_acts">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Codice</td>
    <td valign=top><formwidget id="cod_acts">
        <formerror  id="cod_acts"><br>
        <span class="errori">@formerror.cod_acts;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>&nbsp; &nbsp;&nbsp; &nbsp;</td>

    <td valign=top align=right class=form_title>Data caricamento</td>
    <td valign=top><formwidget id="data_caric">
        <formerror  id="data_caric"><br>
        <span class="errori">@formerror.data_caric;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>Documento</td>
    <td valign=top><formwidget id="cod_documento">
        <formerror  id="cod_documento"><br>
        <span class="errori">@formerror.cod_documento;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top align=right class=form_title>Fornitore di Energia</td>
    <td valign=top colspan=6><formwidget id="cod_distr">
        <formerror  id="cod_distr"><br>
        <span class="errori">@formerror.cod_distr;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=7>&nbsp;</td></tr>

<tr><td valign=top align=right class=form_title><b>Input</b></td>
<tr><td valign=top align=right class=form_title>Caricati</td>
    <td valign=top><formwidget id="caricati">su<formwidget id="totale">
        <formerror  id="caricati"><br>
        <span class="errori">@formerror.caricati;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>&nbsp; &nbsp;&nbsp; &nbsp;</td>

    <td valign=top align=right class=form_title>Scartati</td>
    <td valign=top><formwidget id="scartati">su<formwidget id="totale">
        <formerror  id="scartati"><br>
        <span class="errori">@formerror.scartati;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title><b>Elaborati</b></td></tr>
<tr>
    <td valign=top align=right class=form_title>Da analizzare</td>
    <td valign=top><formwidget id="da_analizzare">su<formwidget id="caricati">
        <formerror  id="da_analizzare"><br>
        <span class="errori">@formerror.da_analizzare;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right colspan=2 class=form_title>Invariati</td>
    <td valign=top><formwidget id="invariati">
        <formerror  id="invariati"><br>
        <span class="errori">@formerror.invariati;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top colspan=4 align=right class=form_title>Esportati</td>
    <td valign=top><formwidget id="importati_aimp">
        <formerror  id="importati_aimp"><br>
        <span class="errori">@formerror.importati_aimp;noquote@</span>
        </formerror>
    </td>
</tr>

<tr>
    <td valign=top colspan=4 align=right class=form_title>Chiusura forzata</td>
    <td valign=top><formwidget id="chiusi_forzat">
        <formerror  id="chiusi_forzat"><br>
        <span class="errori">@formerror.chiusi_forzat;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=7>&nbsp;</td></tr>

<tr><td valign=top align=right class=form_title>Stato</td>
    <td valign=top colspan=1><formwidget id="stato">
        <formerror  id="stato"><br>
        <span class="errori">@formerror.stato;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title>&nbsp; &nbsp;&nbsp; &nbsp;</td>

    <td valign=top align=right class=form_title>Percorso file</td>
    <td valign=top colspan=3><formwidget id="percorso_file">
        <formerror  id="percorso_file"><br>
        <span class="errori">@formerror.percorso_file;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Note</td>
    <td valign=top colspan=5><formwidget id="note">
        <formerror  id="note"><br>
        <span class="errori">@formerror.note;noquote@</span>
        </formerror>
    </td>
</tr>

<if @funzione@ ne "V">
    <tr><td colspan=7 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

