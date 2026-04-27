<!--
    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    mat01  02/09/2025 Tolto il tag font e sostituito con span. Tolto il tag center e sostuito
    mat01             con un div. Sostituito il tag <b> con il tag <strong>
    mat01             Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)

    nic01  13/11/2018 Commentato link "Modulistica da compilare" che non sembra piu' dovuto.
    
    rom03 30/10/2018  Aggiunto link "Modulistica da compilare"

    rom02 24/05/2018  Aggiunta dicitura in testa alla pagina 'Data scadenza dichiarazione' 
    rom02 	      se i contributi son stati pagati regolarmente.

    rom01  05/03/2018 Modificato Stampa Scheda Imp. con Stampa riepilogativa Impianto
    	
    sim02  26/10/2016 Aggiunto dicitura in testa alla pagina se i contributi son stati pagati regolarmente

    innes  16/09/2014 Innesto da iter-dev a iter-portal-dev (modificato link al master, etc...)

    sim01  10/09/2014 Aggiunto link al file Libretto-compilabile.pdf con commento sottostante
-->

<master> <!--innes -->
  <property name="title">@page_title;noquote@</property>
  <property name="context_bar">@context_bar;noquote@</property>
  <property name="riga_vuota">f</property>

<table width=100% style="padding-top: 20px;">
      <tr>
	<td width=100% nowrap>
         <strong>  E' possibile stampare un riepilogo delle principali informazioni dell'impianto, 
         <br> stampare il libretto o la prima pagina del libretto stesso. 
         <br> Scaricare un libretto standard senza informazioni da completare. 
	 </strong>
	 </td>
        </tr>
</table>

<!--mat01  <center>-->
<div align=center><!--mat01-->
  <!--innes Tolto link_tab e dett_tab -->
   <br><!--innes -->
    <table width=100%>
      <tr>
	<td nowrap class=func-menu>
          <a href="#" onclick="javascript:window.open('@file_pdf_url;noquote@', 'stampa', 'scrollbars=yes, resizable=yes')" class="button">Stampa riepilogativa Impianto</a>
	</td>
        <td nowrap class=func-menu>
          <a href="#" onclick="javascript:window.open('@file_pdf_url3;noquote@', 'libretto', 'scrollbars=yes, resizable=yes')" class="button">Stampa Libretto</a>
	</td>

     <!-- 19/04/2013
	@stampa_e;noquote@
	<if @cod_comb@ eq @cod_tele@ >
	  <td width=25% nowrap class=func-menu>
            <a href="#" onclick="javascript:window.open('@file_pdf_url2;noquote@', 'stampa', 'scrollbars=yes, resizable=yes')" class="button">Stampa allegato E3</a>
      	  </td>
	</if>
	<if @cod_comb@ eq @cod_pomp@ >
	  <td width=25% nowrap class=func-menu>
            <a href="#" onclick="javascript:window.open('@file_pdf_url2;noquote@', 'stampa', 'scrollbars=yes, resizable=yes')" class="button">Stampa allegato E4</a>
      	  </td>
	</if>
     -->
     <!-- innes Rimosso url_coimaimp_allega_ed_esponi e rimesso il link diretto al pdf -->
     <if @numero_gend@ gt 0>
        <td nowrap class=func-menu><!-- 19/04/2013 -->
	   <a href="#" onclick="javascript:window.open('@url_file_pdf;noquote@', 'stampa', 'scrollbars=yes, resizable=yes')" class="button">@titolo;noquote@</a><!-- 19/04/2013 -->
	</td><!-- 19/04/2013 -->
     </if>

	<!-- innes:tolto solo l'asterisco perche' non c'e' piu' il commento -->
        <td nowrap class=func-menu><!-- sim01 -->
           <a href="#" onclick="javascript:window.open('@file_libretto_pdf;noquote@', 'libretto-compilabile', 'scrollbars=yes, resizable=yes')" class="button">Stampa Libretto compilabile</a><!-- sim01 -->
        </td><!-- sim01 -->
	<!-- rom02 -->
    </tr>
    <tr>
	<td nowrap class=func-menu>
	<a href="/iter-portal/coimdimp-list?@link_list_rcee@" class="button">Visualizzazione RCEE e moduli regionali</a>
        </td>
	<td nowrap class=func-menu>
        <a href="/iter-portal/coimcimp-list?@link_list_cimp@" class="button">Visualizzazione Rapporti di ispezione</a>
        </td>
        <td nowrap class=func-menu>
	  <a href="/iter-portal/documenti-list?@link_list_rcee@" class="button">Visualizza documenti</a>
	</td>
	<td nowrap class=func-menu>
          <!--nic01 <a href="/iter-portal/citizen-documents?@link_list_aimp@">Modulistica da compilare</a><!--rom03-->
	</td>
    </tr>

    <if @msg_contributi@ ne ""><!-- sim02 if e suo contenuto -->
      <td colspan=4>
       <!--mat01 sostituito font con span -->
       <span style="color:red">@msg_contributi@</span>
       </td>
      <tr> <!-- rom02 aggiunto tr e contenuto -->
      <td colspan=4>
       <!--mat01 sostituito font con span -->
       <span style="color:red">@msg_data_dich@</span>
       </td>
      </tr>
    </if>

    <!-- innes tolto commento riguardante la possibilita' di allegare il PDF -->
</table>

    <!--<button onclick="javascript:window.open('@file_pdf_url;noquote@', 'stampa', 'scrollbars=yes, resizable=yes')">Stampa</button>-->
    <br>
    @stampa;noquote@

  <!--mat01 </center>-->
</div><!--mat01-->