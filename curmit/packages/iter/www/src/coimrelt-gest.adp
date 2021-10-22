<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>
<property name="riga_vuota">f</property>

<table width="100%" cellspacing=0 class=func-menu>
<tr>
   <td width="25%" nowrap class=func-menu>
       <a href="coimrelt-list?@link_list;noquote@" class=func-menu>Ritorna</a>
   </td>
   <if @funzione@ eq "I">
      <td width="75%" nowrap class=func-menu>&nbsp;</td>
   </if>
   <else>
      <td width="25%" nowrap class=@func_v;noquote@>
         <a href="coimrelt-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
      </td>
      <td width="25%" nowrap class=@func_m;noquote@>
         <a href="coimrelt-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
      </td>
      <td width="25%" nowrap class=@func_d;noquote@>
         <a href="coimrelt-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
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
<formwidget   id="last_sezione">
<formwidget   id="cod_relg">
<formwidget   id="cod_relt">
<formwidget   id="sezione">

<if @funzione@ ne "I">
    <formwidget   id="obj_refer">
    <formwidget   id="id_pot">
    <formwidget   id="id_per">
    <formwidget   id="id_comb">
</if>

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<if @funzione@ eq "I">

    <tr><td valign=top align=right class=form_title>Sezione</td>
        <td valign=top><formwidget id="des_sezione">
            <formerror  id="des_sezione"><br>
            <span class="errori">@formerror.des_sezione;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Descrizione</td>
        <td valign=top><formwidget id="id_clsnc">
            <formerror  id="id_clsnc"><br>
            <span class="errori">@formerror.id_clsnc;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Oggetto</td>
        <td valign=top><formwidget id="obj_refer">
            <formerror  id="obj_refer"><br>
            <span class="errori">@formerror.obj_refer;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Potenza</td>
        <td valign=top><formwidget id="id_pot">
            <formerror  id="id_pot"><br>
            <span class="errori">@formerror.id_pot;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Periodo</td>
        <td valign=top><formwidget id="id_per">
            <formerror  id="id_per"><br>
            <span class="errori">@formerror.id_per;noquote@</span>
            </formerror>
        </td>
    </tr>

    <tr><td valign=top align=right class=form_title>Combustibile</td>
        <td valign=top><formwidget id="id_comb">
            <formerror  id="id_comb"><br>
            <span class="errori">@formerror.id_comb;noquote@</span>
            </formerror>
        </td>
    </tr>
</if>
<else>
    <tr><td valign=top align=right class=form_title>Sezione</td>
        <td valign=top><formwidget id="des_sezione"></td>
    </tr>

    <tr><td valign=top align=right class=form_title>Descrizione</td>
        <td valign=top><formwidget id="des_clsnc"></td>
    </tr>

    <tr><td valign=top align=right class=form_title>Oggetto</td>
        <td valign=top><formwidget id="des_obj_refer"></td>
    </tr>

    <tr><td valign=top align=right class=form_title>Potenza</td>
        <td valign=top><formwidget id="des_pot"></td>
    </tr>

    <tr><td valign=top align=right class=form_title>Periodo</td>
        <td valign=top><formwidget id="des_per"></td>
    </tr>

    <tr><td valign=top align=right class=form_title>Combustibile</td>
        <td valign=top><formwidget id="des_comb"></td>
    </tr>
</else>


<tr><td valign=top align=right class=form_title>Numero</td>
    <td valign=top><formwidget id="n">
        <formerror  id="n"><br>
        <span class="errori">@formerror.n;noquote@</span>
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

