<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@link_inc;noquote@
@link_tab;noquote@
@dett_tab;noquote@

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coim_d_anom-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coim_d_anom-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coim_d_anom-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coim_d_anom-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
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
<formwidget   id="last_prog_anom">
<formwidget   id="cod_impianto">
<formwidget   id="gen_prog">
<formwidget   id="url_aimp">
<formwidget   id="url_list_aimp">
<formwidget   id="flag_cimp">
<formwidget   id="extra_par_inco">
<formwidget   id="flag_inco">
<formwidget   id="cod_inco">
<formwidget   id="flag_origine">
<if @funzione@ ne I>
    <formwidget   id="cod_tanom">
</if>
<formwidget   id="cod_cimp_dimp">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<if @funzione@ ne I>
<tr>
    <td valign=top align=right class=form_title>Prog.</td>
    <td valign=top><formwidget id="prog_anom">
        <formerror  id="prog_anom"><br>
        <span class="errori">@formerror.prog_anom;noquote@</span>
        </formerror>
    </td>
</tr>
</if>

<tr><td valign=top align=right class=form_title>Tipo anomalia</td>
    <if @funzione@ eq I>
        <td valign=top nowrap><formwidget id="cod_tanom">
            <formerror  id="cod_tanom"><br>
            <span class="errori">@formerror.cod_tanom;noquote@</span>
            </formerror>
        </td>
    </if>
    <else>
        <td valign=top nowrap><formwidget id="desc_tano">
            <formerror  id="desc_tano"><br>
            <span class="errori">@formerror.desc_tano;noquote@</span>
            </formerror>
    </else>
</tr>

<tr><td valign=top align=right class=form_title>Data utile inter.</td>
    <td valign=top><formwidget id="dat_utile_inter">
        <formerror  id="dat_utile_inter"><br>
        <span class="errori">@formerror.dat_utile_inter;noquote@</span>
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

