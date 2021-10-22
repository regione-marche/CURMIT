<master   src="../master">
  <property name="title">@page_title;noquote@</property>
  <property name="context_bar">@context_bar;noquote@</property>
  <property name="riga_vuota">f</property>

  <table width=100% cellspacing=0 class=func-menu>
    <tr>
      <td width="25%" nowrap class=func-menu>
	<a href=coimbman-aimp-list?@link_list;noquote@ class=func-menu>Ritorna</a>
      </td>
      <td class=func-menu>&nbsp;</td>
    </tr>
  </table>

  <center>
    <formtemplate id="@form_name;noquote@">
      <formwidget   id="caller">
	<formwidget   id="nome_funz">
	  <formwidget   id="f_nome">
	    <formwidget   id="nome_funz_caller">
	      <formwidget   id="destinazione">
		<formwidget   id="compatta_list">
		  
		  <!-- Inizio della form colorata -->
		  <%=[iter_form_iniz]%>
		  <tr>
		    <td align=center><b>Confermi la bonifica dei seguenti manutentori:</b></td>
		  </tr>
		  <tr><td align=center>&nbsp;</td></tr>
		  <tr><td align=center>@manu_da_compattare;noquote@</td></tr>
		  <tr><td>&nbsp;</td></tr>
		  <tr><td align=center><b>con il manutentore di destinazione</b></td></tr>
		  <tr><td>&nbsp;</td></tr>
		  <tr><td align=center>@manu_destinazione;noquote@</td></tr>
		  <tr><td>&nbsp;</td></tr>
		  <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
		  <!-- Fine della form colorata -->
		  <%=[iter_form_fine]%>
		  
    </formtemplate>
    <p>
  </center>
  
