<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

@link_tab;noquote@
@dett_tab;noquote@

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="16.66%" nowrap class=func-menu>
       <a href="coimprvv-gest?funzione=I&@link_gest;noquote@" class=func-menu>Nuovo provvedimento</a>
   </td>
   <if @funzione@ eq "I">
      <td width="83.34%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="16.66%" nowrap class=@func_v;noquote@>
         <a href="coimprvv-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="16.66%" nowrap class=@func_m;noquote@>
         <a href="coimprvv-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="16.66%" nowrap class=@func_d;noquote@>
         <a href="coimprvv-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
      <td width="16.66%" nowrap class=func-menu>
         <a target="Stampa provv." href="coimprvv-docu?@link_gest;noquote@" class=func-menu>Documento</a>
      </td>
      <td width="16.66%" nowrap class=func-menu>
         <if @flag_movi@ eq T>
             <a href="coimmovi-gest?funzione=V&@link_movi;noquote@" class=func-menu>Visualizza Movimento</a>
         </if>
         <else>
	     Visualizza Movimento
         </else>
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
<formwidget   id="last_cod_prvv">
<formwidget   id="cod_impianto">
<formwidget   id="url_aimp">
<formwidget   id="url_list_aimp">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<if  @funzione@ ne I>
    <tr><td valign=top align=right class=form_title>Codice</td>
        <td valign=top><formwidget id="cod_prvv">
            <formerror  id="cod_prvv"><br>
            <span class="errori">@formerror.cod_prvv;noquote@</span>
            </formerror>
        </td>
        <td valign=top align=right class=form_title>Documento</td>
        <td valign=top colspan=3><formwidget id="cod_documento">
            <formerror  id="cod_documento"><br>
            <span class="errori">@formerror.cod_documento;noquote@</span>
            </formerror>
        </td>
    </tr>
</if>

<tr><td valign=top align=right class=form_title>Data provvedimento</td>
    <td valign=top><formwidget id="data_provv">
        <formerror  id="data_provv"><br>
        <span class="errori">@formerror.data_provv;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Causale</td>
    <td valign=top nowrap><formwidget id="causale">
        <formerror  id="causale"><br>
        <span class="errori">@formerror.causale;noquote@</span>
        </formerror>
    </td>
</tr>
<if @funzione@ eq I>
   <tr>
       <td valign=top align=right class=form_title>Importo</td>
       <td valign=top><formwidget id="importo">
          <formerror  id="importo"><br>
          <span class="errori">@formerror.importo;noquote@</span>
          </formerror>
       </td>
       <td valign=top align=right class=form_title>Tipo pagamento</td>
       <td valign=top><formwidget id="tipo_pag">
          <formerror  id="tipo_pag"><br>
          <span class="errori">@formerror.tipo_pag;noquote@</span>
          </formerror>
       </td>
   </tr>
   <tr>
       <td valign=top align=right class=form_title>Data limite pagamento</td>
       <td valign=top><formwidget id="data_scad">
          <formerror  id="data_scad"><br>
          <span class="errori">@formerror.data_scad;noquote@</span>
          </formerror>
       </td>
   <tr>
</if>

<tr><td valign=top align=right class=form_title>Nota</td>
    <td valign=top colspan=3><formwidget id="nota">
        <formerror  id="nota"><br>
        <span class="errori">@formerror.nota;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=4>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

