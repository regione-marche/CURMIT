<master>
<br>
<formtemplate id="@form_name;noquote@">
  <formwidget   id="token_code">
  <formwidget id="id_utente">
  <formwidget id="codice_fiscale_uten">

  <table border=0 align="center" width="100%" >
  <tr>
    <td align="left">
      <h1>Se sei registrato con più ditte scegli la ditta con cui operare:</h1>
    </td>
  </tr>
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td>
      <table class="table_s" align=center border=0>
        <tr>
          <th align=center width=5%></th>
          <th align=center width=25%>Codice Iter</th>
          <th align=left nowrap> Denominazione</th>
        </tr>
        <!-- genero la tabella -->
        <multiple name=utenti>
          <tr>
            <td valign=top align=center>@utenti.radio_butt;noquote@</td>
            <td valign=top align=center>@utenti.cod_manutentore;noquote@</td>
            <td valign=top align=left>@utenti.denominazione;noquote@</td>
          </tr>
        </multiple>
      </table>
    </td>
  </tr>
  <tr><td align=center>&nbsp;</td></tr>
  <tr><td align=center>@mex_error;noquote@</td></tr>
  <tr><td align=center>&nbsp;</td></tr>
  <tr>
    <td align=center>
       <formwidget id="submit">
    </td>
  </tr>
</table>
</formtemplate>
