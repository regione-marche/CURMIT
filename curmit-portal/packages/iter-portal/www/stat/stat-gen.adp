<master>
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<p></p>
@link_head;noquote@
<p></p>

<!--mat01 tolto perchè mauve++ restituisce errore<center>-->
<div style="display: flex; justify-content: center;"> <!--mat01-->
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="nome_funz_caller">
<formwidget   id="receiving_element">
<formwidget   id="dummy">

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<tr><td valign=top align=right class=form_title><label for="f_data1">Data controllo da</label></td><!--mat01 aggiunto tag label-->
    <td valign=top colspan=1><formwidget id="f_data1" autocomplete="off"><!--mat01 aggiunto autocomplete="off"-->
        <formerror  id="f_data1"><br>
        <span class="errori">@formerror.f_data1;noquote@</span>
        </formerror>
    </td>

    <td valign=top align=right class=form_title><label for="f_data2">a</label></td><!--mat01 aggiunto tag label-->
    <td valign=top><formwidget id="f_data2" autocomplete="off"><!--mat01 aggiunto autocomplete="off"-->
        <formerror id="f_data2"><br>
        <span class="errori">@formerror.f_data2;noquote@</span>
        </formerror>
    </td>
</tr>

<tr><td colspan=2>&nbsp;</td></tr>

<if @funzione@ ne "V">
    <tr><td colspan=2 align=center><formwidget id="submit"></td></tr>
</if>
<else>
    <tr><td colspan=2 align=center><span class="errori">@page_title;noquote@</span></td></tr>
</else>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
<!--mat01 </center> -->
</div><!--mat01-->

