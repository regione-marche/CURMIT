<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>


<if @caller@ eq "index">
    <table width="100%" cellspacing=0 class=func-menu>
    <tr>
       <td width="25%" nowrap class=func-menu>
           <a href="coimstcu-filter?@link_filter;noquote@" class=func-menu>Ritorna</a>
       </td>
    </tr>
    </table>
</if>

@js_function;noquote@
<!-- barra con il cerca, link di aggiungi e righe per pagina -->
@list_head;noquote@

<center>
<table width=100% border=0 cellpadding=0 cellspacing=0>
   <tr>
      <td align=center>
         <form method=post action="coimstpm-prnt-da-app" name=@form_name;noquote@>
         <input type=hidden name=nome_funz         value=stpm-da-app>
	 <input type=hidden name=nome_funz_caller  value=@nome_funz_caller;noquote@> 
	 <input type=hidden name=f_stato           value=@f_stato;noquote@>
	 <input type=hidden name=f_comune          value=@f_comune;noquote@>
	 <input type=hidden name=f_escludi         value=@f_escludi;noquote@>
	 <input type=hidden name=f_da_impianto     value=@f_da_impianto;noquote@>
	 <input type=hidden name=f_a_impianto      value=@f_a_impianto;noquote@>
	 <input type=hidden name=id_stampa         value=@id_stampa;noquote@>
         <input type=hidden name=extra_par         value=@extra_par;noquote@>
      </td>
   </tr>
   <tr>
      <td align=center>
         &nbsp;
      </td>
    </tr>
   <tr>
      <td align=center>
         <input type=submit value="Conferma creazione comunicazioni" name=b_conferma>
      </td>
    </tr>
</table>

<table border=0>
<tr>
    <td>@table_result;noquote@</td>
</tr>

</table>

<p>
<input type=submit value="Conferma creazione comunicazioni" name=b_conferma>
</form>

</center>

