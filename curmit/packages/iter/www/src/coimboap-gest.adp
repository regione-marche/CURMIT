<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <if  @funzione@ ne "I">
       <td width="25%" nowrap class=func-menu>
           <a href="@link_ritorna;noquote@" class=func-menu>Ritorna</a>
       </td>

       <if @funzione@ eq "I">
           <td width="75%" nowrap class=func-menu>&nbsp;</td>
       </if>
       <else>
          <td width="25%" nowrap class=@func_v;noquote@>
             <a href="coimboap-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
          </td>
          <td width="25%" nowrap class=@func_m;noquote@>
             <a href="coimboap-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
          </td>
          <td width="25%" nowrap class=@func_d;noquote@>
             <a href="coimboap-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
         </td>
      </else>
   </if>
</tr>
</table>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="extra_par">
<formwidget   id="last_order">
<formwidget   id="cod_bollini">
<formwidget   id="cod_boap">
<formwidget   id="dummy">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>
<tr><td valign=top align=right class=form_title>Nr bollini</td>
    <td valign=top><formwidget id="nr_bollini">
        <formerror id="nr_bollini"><br>
        <span class="errori">@formerror.nr_bollini;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>Al Manutentore</td>
     	<td valign=top><formwidget id="f_manu_cogn">
                       <formwidget id="f_manu_nome">@cerca_manu;noquote@
            <formerror  id="f_manu_cogn"><br>
            <span class="errori">@formerror.f_manu_cogn;noquote@</span>
            </formerror>
        </td>
</tr>
<tr><td valign=top align=right class=form_title>Da matricola</td>
    <td valign=top><formwidget id="matr_da">
        <formerror  id="matr_da"><br>
        <span class="errori">@formerror.matr_da;noquote@</span>
        </formerror>
    </td>
    <td valign=top align=right class=form_title>A matricola</td>
    <td valign=top><formwidget id="matr_a">
        <formerror  id="matr_a"><br>
        <span class="errori">@formerror.matr_a;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td valign=top align=right class=form_title>Note</td>
    <td valign=top colspan=3><formwidget id="note">
        <formerror  id="note"><br>
        <span class="errori">@formerror.note;noquote@</span>
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

