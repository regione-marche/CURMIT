<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimsanz-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimsanz-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimsanz-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimsanz-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
      </td>
   </tr>
   </else>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="last_sanz">
<br>
<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<!-- TODO: Ricordare di posizionare gli eventuali link ai pgm di zoom -->
   <tr><td valign=top align=right class=form_title>Codice sanzione</td>
        <td valign=top><formwidget id="cod_sanzione">
            <formerror  id="cod_sanzione"><br>
            <span class="errori">@formerror.cod_sanzione;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Descr. breve</td>
         <td valign=top><formwidget id="descr_breve">
             <formerror  id="descr_breve"><br>
             <span class="errori">@formerror.descr_breve;noquote@</span>
            </formerror>
         </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Descr. estesa</td>
         <td valign=top><formwidget id="descr_estesa">
             <formerror  id="descr_estesa"><br>
             <span class="errori">@formerror.descr_estesa;noquote@</span>
            </formerror>
         </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Importo minimo</td>
         <td valign=top><formwidget id="importo_min">
             <formerror  id="importo_min"><br>
             <span class="errori">@formerror.importo_min;noquote@</span>
            </formerror>
         </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Importo massimo</td>
         <td valign=top><formwidget id="importo_max">
             <formerror  id="importo_max"><br>
             <span class="errori">@formerror.importo_max;noquote@</span>
            </formerror>
         </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Tipo soggetto</td>
         <td valign=top><formwidget id="tipo_soggetto">
             <formerror  id="tipo_soggetto"><br>
             <span class="errori">@formerror.tipo_soggetto;noquote@</span>
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

