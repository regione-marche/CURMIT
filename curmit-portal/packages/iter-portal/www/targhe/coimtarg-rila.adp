<!DOCTYPE html>
<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context_bar">@context_bar;noquote@</property>
  <property name="riga_vuota">f</property>
<br>  
  <table width="100%" cellspacing=0 class=func-menu>
    <tr>
      <if @funzione@ ne "I" or  @nome_funz@ ne "boll-ins">
	<td width="25%" nowrap class=func-menu>
          <a href="@link_ritorna;noquote@" class=func-menu>Ritorna</a>
	</td>
	
	<if @funzione@ eq "I">
          <td width="75%" nowrap class=func-menu>&nbsp;</td>
	</if>
	<else>
          <td width="25%" nowrap class=@func_v;noquote@>
            <a href="coimtarg-gest?funzione=V&@link_gest;noquote@" class=@func_v;noquote@>Visualizza</a>
          </td>
          <if @flag_attivo@ eq N>
            <td width="25%" nowrap class=@func_m;noquote@>
              <a href="coimtarg-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
            </td>
            <td width="25%" nowrap class=@func_d;noquote@>Cancella</td>
          </if>
          <else>
            <td width="25%" nowrap class=@func_m;noquote@>
              <a href="coimtarg-gest?funzione=M&@link_gest;noquote@" class=@func_m;noquote@>Modifica</a>
            </td>
            <td width="25%" nowrap class=@func_d;noquote@>
              <a href="coimtarg-gest?funzione=D&@link_gest;noquote@" class=@func_d;noquote@>Cancella</a>
            </td>
          </else>
	</else>
      </if>
    </tr>
    <if @funzione@ ne "I">
      <tr>
        <td width="25%" nowrap class=func-menu> 
          <a href="coimtarg-layout?@link_prnt;noquote@" target=stampa class=func-menu>Stampa ricevuta</a>
        </td>
	<td colspan=3 class=func-menu>&nbsp;</td> 
      </tr>
    </if>
  </table>

  <center>
    <formtemplate id="@form_name@">
      <formwidget   id="funzione">
	<formwidget   id="caller">
	  <formwidget   id="nome_funz">
	    <formwidget   id="nome_funz_caller">
	      <formwidget   id="extra_par">
		<formwidget   id="last_order">
		  <formwidget   id="flag_attivo">
		    <formwidget   id="cod_manutentore">
		      <formwidget   id="dummy">
			<br>

			  <table width=100%>
			    <tr>
			      <td valign=top align=right class=form_title>Data consegna</td>
			      <td valign=top><formwidget id="data_consegna">
				  <formerror id="data_consegna"><br>
				    <span class="errori">@formerror.data_consegna;noquote@</span>
				  </formerror>
			      </td>
			      <td valign=top align=right class=form_title>Manutentore</td>
     			      <td valign=top><formwidget id="f_manutentore">
				  <formerror id="f_manutentore"><br>
				    <span class="errori">@formerror.f_manutentore;noquote@</span>
				  </formerror>
			      </td>
			    </tr>
			    <tr>	
			      <td colspan=4>&nbsp;</td>
			    </tr>
			    <tr>
			      <td align=right><b>Numero Targhe</b></td>
			      <td valign=top><formwidget id="num_targhe">
				  <formerror id="num_targhe"><br>
				    <span class="errori">@formerror.num_targhe;noquote@</span>
				  </formerror>
			      </td>
			      <td colspan=2>&nbsp;</td>
			    </tr>
<!-- sim: per le targhe questi campi non servono. Derivano dai bollini
			    <tr>
			      <td valign=top align=right class=form_title>Data scadenza</td>
			      <td valign=top><formwidget id="data_scadenza">
				  <formerror  id="data_scadenza"><br>
				    <span class="errori">@formerror.data_scadenza;noquote@</span>
				  </formerror>
			      </td>
			      <td valign=top align=right class=form_title>Note</td>
			      <td valign=top colspan=3><formwidget id="note">
				  <formerror  id="note"><br>
				    <span class="errori">@formerror.note;noquote@</span>
				  </formerror>
			      </td>
			    </tr>
-->
			    <if @funzione@ ne "V">
			      <tr><td colspan=4>&nbsp;</td></tr>
			      <tr><td colspan=4 align=center><formwidget id="submit"></td></tr>
			    </if>
			  </table>
			  
    </formtemplate>
    <p>
  </center>

