<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    gab01 02/05/2016 Aggiunta colonna cod_zona ed esposto quartiere solo per i comuni.
-->

<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width=100% cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href=coimviae-list?@link_list;noquote@ class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimviae-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimviae-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimviae-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
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
<formwidget   id="last_cod_via">
<formwidget   id="cod_comune">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title>Codice</td>
    <td valign=top nowrap><formwidget id="cod_via">
        <formerror  id="cod_via"><br>
        <span class="errori">@formerror.cod_via;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Comune</td>
    <td valign=top nowrap><formwidget id="denom_comune">
        <formerror  id="denom_comune"><br>
        <span class="errori">@formerror.denom_comune;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Tipo Toponom.</td>
    <td valign=top nowrap><formwidget id="descr_topo">
        <formerror  id="descr_topo"><br>
        <span class="errori">@formerror.descr_topo;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Descrizione</td>
    <td valign=top nowrap><formwidget id="descrizione">
        <formerror  id="descrizione"><br>
        <span class="errori">@formerror.descrizione;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Descrizione Estesa</td>
    <td valign=top nowrap><formwidget id="descr_estesa">
        <formerror  id="descr_estesa"><br>
        <span class="errori">@formerror.descr_estesa;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>CAP</td>
    <td valign=top nowrap><formwidget id="cap">
        <formerror  id="cap"><br>
        <span class="errori">@formerror.cap;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>Zone geografiche</td><!--gab01-->
    <td valign=top nowrap><formwidget id="cod_zona">
        <formerror  id="cod_zona"><br>
        <span class="errori">@formerror.cod_zona;noquote@</span>
        </formerror>
    </td><!--gab01-->
</tr><!--gab01-->
<tr><td valign=top align=right class=form_title>Da Numero</td>
    <td valign=top nowrap><formwidget id="da_numero">
        <formerror  id="da_numero"><br>
        <span class="errori">@formerror.da_numero;noquote@</span>
        </formerror>
    </td>
</tr>
<tr><td valign=top align=right class=form_title>A Numero</td>
    <td valign=top nowrap><formwidget id="a_numero">
        <formerror  id="a_numero"><br>
        <span class="errori">@formerror.a_numero;noquote@</span>
        </formerror>
    </td>
</tr>
<if @flag_ente@ eq "C"><!--gab01-->
<tr><td valign=top align=right class=form_title>Quartiere</td>
        <td valign=top><formwidget id="cod_qua">
            <formerror  id="cod_qua"><br>
            <span class="errori">@formerror.clas_funz;noquote@</span>
            </formerror>
        </td>
   </tr>
</if><!--gab01-->
<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

