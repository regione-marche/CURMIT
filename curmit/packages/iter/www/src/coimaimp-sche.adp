<!--
    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    rom02 24/05/2018  Aggiunta dicitura in testa alla pagina 'Data scadenza dichiarazione' 
    rom02 	      se i contributi son stati pagati regolarmente.

    rom01  05/03/2018 Modificato Stampa Scheda Imp. con Stampa riepilogativa Impianto
    	
    sim02  26/10/2016 Aggiunto dicitura in testa alla pagina se i contributi son stati pagati regolarmente

    sim01  10/09/2014 Aggiunto link al file Libretto-compilabile.pdf con commento sottostante
-->

<master   src="../master">
  <property name="title">@page_title;noquote@</property>
  <property name="context_bar">@context_bar;noquote@</property>
  <property name="riga_vuota">f</property>

  <center>

    <if @flag_no_links@ ne T>
      @link_tab;noquote@
    </if>

    @dett_tab;noquote@

    <table width=100%>
      <tr>
	<td width=25% nowrap class=func-menu>
          <a href="#" onclick="javascript:window.open('@file_pdf_url;noquote@', 'stampa', 'scrollbars=yes, resizable=yes')">Stampa riepilogativa Impianto</a>
	</td>
        <td width=25% nowrap class=func-menu>
          <a href="#" onclick="javascript:window.open('@file_pdf_url3;noquote@', 'libretto', 'scrollbars=yes, resizable=yes')">Stampa Libretto</a>
	</td>

     <!-- 19/04/2013
	@stampa_e;noquote@
	<if @cod_comb@ eq @cod_tele@ >
	  <td width=25% nowrap class=func-menu>
            <a href="#" onclick="javascript:window.open('@file_pdf_url2;noquote@', 'stampa', 'scrollbars=yes, resizable=yes')">Stampa allegato E3</a>
      	  </td>
	</if>
	<if @cod_comb@ eq @cod_pomp@ >
	  <td width=25% nowrap class=func-menu>
            <a href="#" onclick="javascript:window.open('@file_pdf_url2;noquote@', 'stampa', 'scrollbars=yes, resizable=yes')">Stampa allegato E4</a>
      	  </td>
	</if>
     -->
     <if @numero_gend@ gt 0>
        <td width=25% nowrap class=func-menu><!-- 19/04/2013 -->
	   <a href="#" onclick="javascript:window.open('@url_coimaimp_sch_allega_ed_esponi;noquote@', 'stampa', 'scrollbars=yes, resizable=yes')">@titolo;noquote@</a><!-- 19/04/2013 -->
	</td><!-- 19/04/2013 -->
     </if>

        <td width=25% nowrap class=func-menu><!-- sim01 -->
           <a href="#" onclick="javascript:window.open('@file_libretto_pdf;noquote@', 'libretto-compilabile', 'scrollbars=yes, resizable=yes')">Stampa Libretto compilabile <if @coimtgen.regione@ ne "MARCHE">*</if></a><!-- sim01 -->
        </td><!-- sim01 -->

        <td width=50%>&nbsp;</td>
    </tr>
<if @coimtgen.regione@ ne "MARCHE">
    <tr><!-- sim01 -->
       <td colspan=4><!-- sim01 -->
	<i>* Puoi compilare il pdf, salvarlo sul tuo PC e allegarlo con la funzione Documenti.</i><!-- sim01 -->
       </td><!-- sim01 -->
    </tr><!-- sim01 -->
</if>
    <if @msg_contributi@ ne ""><!-- sim02 if e suo contenuto -->
      <td colspan=4>
       <font color=red>@msg_contributi@</font>
      </td>
      <tr> <!-- rom02 aggiunto tr e contenuto -->
      <td colspan=4>
       <font color=red>@msg_data_dich@</font>
      </td>
      </tr>
    </if>

</table>

    <!--<button onclick="javascript:window.open('@file_pdf_url;noquote@', 'stampa', 'scrollbars=yes, resizable=yes')">Stampa</button>-->
    <br><br>
    @stampa;noquote@

  </center>
