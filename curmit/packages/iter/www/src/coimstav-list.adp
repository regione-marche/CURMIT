<master   src="../master">
  <property name="title">@page_title;noquote@</property>
  <property name="context_bar">@context_bar;noquote@</property>


  <if @caller@ eq "index">
    <table width="100%" cellspacing=0 class=func-menu>
      <tr>
	<td width="25%" nowrap class=func-menu>
          <a href="coimstav-filter?@link_filter;noquote@" class=func-menu>Ritorna</a>
	</td>
	<td width="50%" nowrap class=func-menu>
          Campagna: <b>@desc_camp;noquote@</b>
	</td>
	<td width="25%" nowrap class=func-menu>&nbsp;
          <a href="coimstav-layout?@link_anteprima;noquote@" class=func-menu>Anteprima Stampa</a>
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
          <input type=hidden name=f_data            value=@f_data;noquote@>
	  <input type=hidden name=f_tipo_data       value=@f_tipo_data;noquote@>
	  <input type=hidden name=f_cod_impianto    value=@f_cod_impianto;noquote@>
	  <input type=hidden name=f_cod_tecn        value=@f_cod_tecn;noquote@>
	  <input type=hidden name=f_cod_enve        value=@f_cod_enve;noquote@>
	  <input type=hidden name=f_anno_inst_da    value=@f_anno_inst_da;noquote@>
	  <input type=hidden name=f_anno_inst_a     value=@f_anno_inst_a;noquote@>
	  <input type=hidden name=f_cod_esito       value=@f_cod_esito;noquote@>
	  <input type=hidden name=f_cod_comune      value=@f_cod_comune;noquote@>
	  <input type=hidden name=f_cod_via         value=@f_cod_via;noquote@>
	  <input type=hidden name=f_tipo_estrazione value=@f_tipo_estrazione;noquote@>
	  <input type=hidden name=f_cod_comb        value=@f_cod_comb;noquote@>
	  <input type=hidden name=cod_inco          value=@cod_inco;noquote@>
          <input type=hidden name=flag_inco         value=@flag_inco;noquote@>
          <input type=hidden name=extra_par         value=@extra_par;noquote@>
	  <input type=hidden name=cod_impianto      value=@cod_impianto;noquote@>
	  <input type=hidden name=url_list_aimp     value=@url_list_aimp;noquote@>
          <input type=hidden name=url_aimp          value=@url_aimp;noquote@>
          <input type=hidden name=f_num_max         value=@f_num_max;noquote@>
          <input type=hidden name=id_stampa         value=@id_stampa;noquote@>
          <input type=hidden name=flag_avviso       value=@flag_avviso;noquote@>
          <input type=hidden name=flag_scaduto      value=@flag_scaduto;noquote@>
          <input type=hidden name=f_da_data_verifica value=@f_da_data_verifica;noquote@>
          <input type=hidden name=f_a_data_verifica value=@f_a_data_verifica;noquote@>
          <input type=hidden name=flag_tipo_impianto value=@flag_tipo_impianto;noquote@>
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
          <input type=submit value="Conferma creazione avvisi" name=b_conferma>
	</td>
      </tr>
    </table>

    <table border=0>
      <tr>
	<td>@table_result;noquote@</td>
      </tr>

    </table>

    <p>
      <input type=submit value="Conferma creazione avvisi" name=b_conferma>
    </form>

  </center>

