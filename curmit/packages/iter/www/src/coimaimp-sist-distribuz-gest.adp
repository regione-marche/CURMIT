<!--
    USER  DATA       MODIFICHE
    ====  ========== =========================================================================
    rom01 07/11/2018 Aggiunti titoli per sezioni 6.1 e 6.2.
    rom01            Rinominate le liste "Vasi di espansione" e "Pompe di circolazione 
    rom01            (se non incorporate nel generatore)"; faccio vedere le liste anche se 
    rom01            sono in modifica.

    sim01 01/08/2017 Modificato la dicitura "Lista Pompe di Calore" in "
    sim01            "Lista pompe di circolazione (se non incorporate nel generatore)"   

    gab01 16/08/2016 Aggiunte liste visibili solo in Visualizzazione
-->

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
<formwidget   id="extra_par">
<formwidget   id="cod_impianto">
<formwidget   id="url_list_aimp">
<formwidget   id="url_aimp">


@link_tab;noquote@
@dett_tab;noquote@
<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="50%" nowrap class=@func_v;noquote@>
      <a href="coimaimp-sist-distribuz-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
   </td>
   <td width="50%" nowrap class=@func_m;noquote@>
      <a href="coimaimp-sist-distribuz-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
   </td>
</tr>
</table>

<table width="80%"><!--rom01 aggiunto titolo per sezione 6.1-->
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td class="func-menu-yellow2" align="center"><b>6.1 - Tipo di distribuzione</b></td>
  </tr>
  <tr><td>&nbsp;</td></tr>
</table>

<table border=0 width="100%">
  <tr><td valign=top align=right class=form_title width=30%>Tipo di distribuzione</td>
    <td valign=top><formwidget id="sistem_dist_tipo">
        <formerror  id="sistem_dist_tipo"><br>
          <span class="errori">@formerror.sistem_dist_tipo;noquote@</span>
        </formerror>
    </td>
  </tr>
  
  <tr>
    <td valign=top align=right class=form_title>Note Altro</td>
    <td valign=top><formwidget id="sistem_dist_note_altro">
        <formerror  id="sistem_dist_note_altro"><br>
          <span class="errori">@formerror.sistem_dist_note_altro;noquote@</span>
        </formerror>
    </td>
  </tr>
</table>

<table width="80%"><!--rom01 aggiunto titolo per sezione 6.2-->
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td class="func-menu-yellow2" align="center"><b>6.2 - Coibentazione rete di distribuzione</b></td>
  </tr>
  <tr><td>&nbsp;</td></tr>
</table>

<table width="100%" border=0>
  <tr>
    <td valign=top align=right class=form_title width=30%>Coibentazione rete di distribuzione</td>
    <td valign=top><formwidget id="sistem_dist_coibentazione_flag">
        <formerror  id="sistem_dist_coibentazione_flag"><br>
          <span class="errori">@formerror.sistem_dist_coibentazione_flag;noquote@</span>
        </formerror>
    </td>
  </tr>
  
  <tr>
    <td valign=top align=right class=form_title>Note</td>
    <td valign=top><formwidget id="sistem_dist_note">
        <formerror  id="sistem_dist_note"><br>
          <span class="errori">@formerror.sistem_dist_note;noquote@</span>
        </formerror>
    </td>
  </tr>
  
</table>

<!-- gab01 aggiunte liste "Vasi di Espansione" e "Pompe di Calore" visibili solo in Visualizzazione-->
<!--rom01 Rinominate le liste "Lista Vasi di Espansione" e " Lista pompe di circolazione (se non incorporate nel generatore)" 
    rom01 in "Vasi di Espansione" e "Pompe di circolazione (se non incorporate nel generatore)".
    rom01 Faccio vedere le liste anche se sono in modifica. Spostato il "submit" dopo le 2 liste-->

<!--rom01 if @funzione@ eq "V"-->
<table border=0>
  <!-- genero la prima tabella -->
  <tr>
    <td>
      <b>Vasi di Espansione</b>
      <br>@link_aggiungi_1;noquote@
    </td>
  </tr>
  <tr>
    <td>@table_result_1;noquote@</td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  
  <!-- genero la seconda tabella -->
  <tr>
    <td>
      <b>Pompe di circolazione (se non incorporate nel generatore)</b>
      <br>@link_aggiungi_2;noquote@
      </td>
  </tr>
  <tr>
    <td>@table_result_2;noquote@</td>
  </tr>
  <tr><td>&nbsp;</td></tr>

  <if @funzione@ ne "V"><!--rom01-->
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
  </if>
  
</table>
<!--rom01 /if -->
</formtemplate>
<p>
</center>

