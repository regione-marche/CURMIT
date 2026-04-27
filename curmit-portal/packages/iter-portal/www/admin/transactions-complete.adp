<master>
  <property name="context">@context;noquote@</property>
  <property name="title">@page_title;noquote@</property>

<br>
<h1>@page_title@</h1>

<center>
<formtemplate id="@form_name;noquote@">
<formwidget   id="funzione">
<formwidget   id="caller">
<formwidget   id="nome_funz">
<formwidget   id="extra_par">
<formwidget   id="tran_id">
<table width="100%" cellspacing=0 class=func-menu>
  <tr>
     <td width="25%" nowrap class=func-menu>
       <a href="../admin/transactions?@extra_par@" class=func-menu>Ritorna</a>
     </td>
  </tr>
</table>

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<if @database@ ne  "iter-portal-prrc">
<tr>
<td>Numero reversale</td>
<td valign=top><formwidget id="num_reversale"> 
        <formerror  id="num_reversale"><br>
        <span class="errori">@formerror.num_reversale;noquote@</span>
        </formerror>
</td>
</tr>
<tr>
<td>Anno reversale</td>
<td valign=top>
  <formwidget id="anno_reversale">        
    <formerror  id="anno_reversale"><br>
      <span class="errori">@formerror.anno_reversale;noquote@</span>
    </formerror>
</td>
</tr>
    
</if>

<else>
<tr>
<td>Numero ordine</td>
<td valign=top><formwidget id="num_ordine"> 
        <formerror  id="num_ordine"><br>
        <span class="errori">@formerror.num_ordine;noquote@</span>
        </formerror>
</td>
</tr>
</else>

<tr><td colspan=2 align=center><formwidget id="submit"></td></tr>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

