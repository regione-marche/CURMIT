<!--
USER  DATA       MODIFICHE
===== ========== ==========================================================================
sim02 27/06/2016 Aggiunte colonne flag_tariffa_impianti_vecchi, anni_fine_tariffa_base e
sim02            tariffa_impianti_vecchi per gestire le tariffe della Regione Calabria
-->
<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimtari-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td class=func-menu width="75%">
          Tariffe associate al listino: <b>@cod_listino;noquote@ - @descrizione;noquote@</b>
      </td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimtari-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimtari-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimtari-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </tr>
   <tr>
      <td class=func-menu colspan=4>
          Tariffe associate al listino: <b>@cod_listino;noquote@ - @descrizione;noquote@</b>
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
<formwidget   id="last_tari">
<formwidget   id="cod_listino">
<if @funzione@ ne I>
    <formwidget   id="tipo_costo">
    <formwidget   id="cod_potenza">
</if>


<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<!-- TODO: Ricordare di posizionare gli eventuali link ai pgm di zoom -->
<if @funzione@ eq I>
    <tr><td valign=top align=right class=form_title>Tipo costo</td>
        <td valign=top><formwidget id="tipo_costo">
            <formerror  id="tipo_costo"><br>
            <span class="errori">@formerror.tipo_costo;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Fascia potenza</td>
         <td valign=top><formwidget id="cod_potenza">
             <formerror  id="cod_potenza"><br>
             <span class="errori">@formerror.cod_potenza;noquote@</span>
            </formerror>
         </td>
    </tr>
</if>
<else>
    <tr><td valign=top align=right class=form_title>Tipo costo</td>
        <td valign=top><formwidget id="tipo_costo_dett">
    </tr>
    <tr><td valign=top align=right class=form_title>Fascia potenza</td>
         <td valign=top><formwidget id="cod_potenza_dett">
    </tr>
</else>
<tr><td valign=top align=right class=form_title>Data inizio validit&agrave;</td>
    <td valign=top><formwidget id="data_inizio">
        <formerror  id="data_inizio"><br>
        <span class="errori">@formerror.data_inizio;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Importo</td>
    <td valign=top><formwidget id="importo">
        <formerror  id="importo"><br>
        <span class="errori">@formerror.importo;noquote@</span>
        </formerror>
    </td>
</tr>
<!-- inizio sim02 -->
<tr><td valign=top align=right class=form_title>Si prevede una 2&deg; tariffa per impianti vecchi?</td>
    <td valign=top><formwidget id="flag_tariffa_impianti_vecchi">
        <formerror  id="flag_tariffa_impianti_vecchi"><br>
        <span class="errori">@formerror.flag_tariffa_impianti_vecchi;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>N&deg; anni oltre i quali applicare la 2&deg; tariffa</td>
    <td valign=top><formwidget id="anni_fine_tariffa_base">
        <formerror  id="anni_fine_tariffa_base"><br>
        <span class="errori">@formerror.anni_fine_tariffa_base;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Importo tariffa per impianti vecchi</td>
    <td valign=top><formwidget id="tariffa_impianti_vecchi">
        <formerror  id="tariffa_impianti_vecchi"><br>
        <span class="errori">@formerror.tariffa_impianti_vecchi;noquote@</span>
        </formerror>
    </td>
</tr>
<!-- fine sim02 -->

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

