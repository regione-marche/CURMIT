<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimtano-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimtano-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimtano-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimtano-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
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
<formwidget   id="last_cod_tano">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Codice</td>
    <td valign=top><formwidget id="cod_tano">
        <formerror  id="cod_tano"><br>
        <span class="errori">@formerror.cod_tano;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Descrizione</td>
    <td valign=top><formwidget id="descr_tano">
        <formerror  id="descr_tano"><br>
        <span class="errori">@formerror.descr_tano;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Descrizione breve</td>
    <td valign=top><formwidget id="descr_breve">
        <formerror  id="descr_breve"><br>
        <span class="errori">@formerror.descr_breve;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Pericoloso</td>
    <td valign=top><formwidget id="flag_scatenante">
        <formerror  id="flag_scatenante"><br>
        <span class="errori">@formerror.flag_scatenante;noquote@</span>
        </formerror>
    </td>
</tr>
<if @flag_enti_compet@ eq T>
    <tr><td valign=top align=right class=form_title>Norma</td>
        <td valign=top><formwidget id="norma">
            <formerror  id="norma"><br>
            <span class="errori">@formerror.norma;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Giorni per l'adattamento</td>
        <td valign=top><formwidget id="gg_adattamento">
            <formerror  id="gg_adattamento"><br>
            <span class="errori">@formerror.gg_adattamento;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Genera esito</td>
        <td valign=top><formwidget id="flag_stp_esito">
            <formerror  id="flag_stp_esito"><br>
            <span class="errori">@formerror.flag_stp_esito;noquote@</span>
            </formerror>
        </td>
    </tr>
    <tr><td valign=top align=right class=form_title>Conteggia nelle statistiche</td>
        <td valign=top><formwidget id="flag_report">
            <formerror  id="flag_report"><br>
            <span class="errori">@formerror.flag_report;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Modello di riferimento</td>
        <td valign=top><formwidget id="flag_modello">
            <formerror  id="flag_modello"><br>
            <span class="errori">@formerror.flag_modello;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Data fine validit&agrave;</td>
        <td valign=top><formwidget id="data_fine_valid">
            <formerror  id="data_fine_valid"><br>
            <span class="errori">@formerror.data_fine_valid;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Tipo criticit&agrave;</td>
        <td valign=top><formwidget id="flag_tipo_ispezione">
            <formerror  id="flag_tipo_ispezione"><br>
            <span class="errori">@formerror.flag_tipo_ispezione;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Ente competente</td>
        <td valign=top><formwidget id="ente_competente">
            <formerror  id="ente_competente"><br>
            <span class="errori">@formerror.ente_competente;noquote@</span>
            </formerror>
        </td>
    </tr>

</if>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

