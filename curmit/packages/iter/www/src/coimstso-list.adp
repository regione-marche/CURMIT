<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>


<if @caller@ eq "index">
    <table width="100%" cellspacing=0 class=func-menu>
    <tr>
       <td width="25%" nowrap class=func-menu>
           <a href="coimstso-filter?@link_filter;noquote@" class=func-menu>Ritorna</a>
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
      <if @flag_avvisi@ eq S>
         <form method=post action="coimstpm-prnt-da-app" name=@form_name;noquote@>
         <input type=hidden name=nome_funz         value=stpm-da-app>
      </if>
      <else>
         <form method=post action="coimstav-layout" name=@form_name;noquote@>
         <input type=hidden name=nome_funz         value=@nome_funz;noquote@>
      </else>
	 <input type=hidden name=nome_funz_caller  value=@nome_funz_caller;noquote@> 
         <input type=hidden name=f_id_caus         value=@f_id_caus;noquote@>
	 <input type=hidden name=f_importo         value=@f_importo;noquote@>
	 <input type=hidden name=f_contatore       value=@f_contatore;noquote@>
	 <input type=hidden name=f_data_scadenza   value=@f_data_scadenza;noquote@>
	 <input type=hidden name=f_cod_comune      value=@f_cod_comune;noquote@>
	 <input type=hidden name=id_stampa         value=@id_stampa;noquote@>
         <input type=hidden name=extra_par         value=@extra_par;noquote@>
      </td>
   </tr>
   <tr>
      <td align=center>
         &nbsp;
      </td>
    </tr>
   <if @flag_avvisi@ ne S>
   <tr>
      <td align=center>
         N. Protocollo <input type=text name=id_protocollo size=25 maxlength=25>
         Data Protocollo<input type=text name=protocollo_dt size=10 maxlength=10>
      </td>
    </tr>
   <tr>
      <td align=center>
         &nbsp;
      </td>
    </tr>
   </if>
   <tr>
      <td align=center>
         <input type=submit value="Conferma creazione solleciti" name=b_conferma>
      </td>
    </tr>
</table>

<table border=0>
<tr>
    <td>@table_result;noquote@</td>
</tr>

</table>

<p>
<input type=submit value="Conferma creazione solleciti" name=b_conferma>
</form>

</center>

