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
<formwidget   id="last_cod_impianto">
<formwidget   id="cod_impianto">
<formwidget   id="data_fin_valid">
<formwidget   id="url_list_aimp">
<formwidget   id="url_aimp">
<formwidget   id="dummy">
<formwidget   id="f_cod_via">

<if @funzione@ ne D>
   <if @funzione@ ne M>
      <formwidget   id="data_ini_valid">
   </if>
</if>

<if @flag_ente@ ne P>
    <formwidget   id="cod_comune">
</if>

@link_tab;noquote@
@dett_tab;noquote@
<table width="100%" cellspacing=0  class=func-menu>
<tr>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimaimp-ubic?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </else>
</tr>
</table>



<%=[iter_form_iniz]%>
<!-- Inizio della form colorata -->
<table>
<tr>
        <td valign=top align=right class=form_title>Comune</td>

        <if @flag_ente@ eq P>
            <td valign=top><formwidget id="cod_comune">
                <formerror  id="cod_comune"><br>
                <span class="errori">@formerror.cod_comune;noquote@</span>
            </formerror>
            </td>
        </if>
        <else>
            <td valign=top><formwidget id="descr_comune"></td>
	</else>
</tr><tr>
        <td valign=top align=right class=form_title>Localit&agrave;</td>
        <td colspan=1 valign=top><formwidget id="localita">
            <formerror  id="localita"><br>
            <span class="errori">@formerror.localita;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=right class=form_title>CAP</td>
        <td colspan=1 valign=top><formwidget id="cap">
            <formerror  id="cap"><br>
            <span class="errori">@formerror.cap;noquote@</span>
            </formerror>
        </td>
</tr>

<tr>
        <td valign=top align=right class=form_title>Unit&agrave; urbana</td>
        <td colspan=1 valign=top><formwidget id="cod_urb">
            <formerror  id="cod_urb"><br>
            <span class="errori">@formerror.cod_urb;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=right class=form_title>Quartiere</td>
        <td colspan=1 valign=top><formwidget id="cod_qua">
            <formerror  id="cod_qua"><br>
            <span class="errori">@formerror.cod_qua;noquote@</span>
            </formerror>
        </td>
</tr>

<tr>
    <td valign=top align=right colspan=6><table width=100%><tr>
        <td valign=top align=right class=form_title>Indirizzo</td>
            <td valign=top nowrap colspan=2><formwidget id="descr_topo">
	    <formwidget id="descr_via">@cerca_viae;noquote@
            <formerror  id="descr_via"><br>
            <span class="errori">@formerror.descr_via;noquote@</span>
            </formerror>
            <formerror  id="descr_topo"><br>
            <span class="errori">@formerror.descr_topo;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=right nowrap class=form_title>N&deg; Civ.</td>
        <td valign=top nowrap><formwidget id="numero">/<formwidget id="esponente">
            <formerror  id="numero"><br>
            <span class="errori">@formerror.numero;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=right class=form_title>Scala</td>
        <td valign=top><formwidget id="scala">
            <formerror  id="scala"><br>
            <span class="errori">@formerror.scala;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=right class=form_title>Piano</td>
        <td valign=top><formwidget id="piano">
            <formerror  id="piano"><br>
            <span class="errori">@formerror.piano;noquote@</span>
            </formerror>
        </td>
</tr>
<tr>
        <td colspan="3">&nbsp;</td>
        <td valign=top align=right class=form_title>Int.</td>
        <td valign=top><formwidget id="interno">
            <formerror  id="interno"><br>
            <span class="errori">@formerror.interno;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=right class=form_title>Palazzo</td>
        <td valign=top colspan="2"><formwidget id="palazzo">
            <formerror  id="palazzo"><br>
            <span class="errori">@formerror.palazzo;noquote@</span>
            </formerror>
        </td>

    </tr></table></td>
</tr>
<tr>
        <td valign=top align=right class=form_title>Destinaz d'uso</td>
        <td valign=top><formwidget id="cod_tpdu">
            <formerror  id="cod_tpdu"><br>
            <span class="errori">@formerror.cod_tpdu;noquote@</span>
            </formerror>
        </td>
</tr>

<tr>
        <td valign=top align=right class=form_title>Ultima variazione</td>
        <td valign=top colspan=3><formwidget id="data_variaz">
            <formerror  id="data_variaz"><br>
            <span class="errori">@formerror.data_variaz;noquote@</span>
            </formerror>
        </td>
</tr>

<tr>
        <if @funzione@ ne V>
          <if @funzione@ ne I>
            <td valign=top align=right class=form_title>Data validit&agrave;</td>
            <td valign=top colspan=3><formwidget id="data_ini_valid">
                <formerror  id="data_ini_valid"><br>
                <span class="errori">@formerror.data_ini_valid;noquote@</span>
                </formerror>
            </td>
          </if>
        </if>
</tr>
<tr>
     <td valign=top align=right class=form_title>Coordinate geografiche GB X</td>
     <td valign=top  colspan=3><formwidget id="gb_x">
        <formerror  id="gb_x"><br>
        <span class="errori">@formerror.gb_x;noquote@</span>
        </formerror>
     </td>
</tr>
<tr>
     <td valign=top align=right class=form_title>Coordinate geografiche GB Y</td>
     <td valign=top  colspan=3><formwidget id="gb_y">
        <formerror  id="gb_y"><br>
        <span class="errori">@formerror.gb_y;noquote@</span>
        </formerror>
     </td>
</tr>
<tr><td colspan=6>&nbsp;</td></tr>
<if @funzione@ ne "V">
<tr>
    <td colspan=6 align=center><formwidget id="submit"></td>
</tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

