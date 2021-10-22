<master src="/packages/iter/www/master">
<property name="title">@title@</property>
<property name="context_bar">@context@</property>


<formtemplate id="grant">
<formwidget id="object_id">
<formwidget id="application_url">

<table>
  <tr valign="top">
    <td>Assegna il permesso: </td>

    <td>&nbsp;</td>

    <td>
      <formwidget id="privilege">
    </td>

    <td>&nbsp;</td>

    <td>a:</td>

    <td>&nbsp;</td>

    <td>
      <formwidget id="party_id"></formwidget>
      <if @formerror.party_id@ not nil>
      <br><formerror id="party_id"></formerror>
      </if>
    </td>

    <td>&nbsp;</td>

    <td>
      <input type="submit" value="OK">
    </td>

  </tr>

</table>

</formtemplate>

<p>

<p>

<i>Note:</i>
<br>
<i>Pur essendo possibile assegnare permessi a singoli utenti, si raccomanda di usare le Unità Organizzative per evidenti motivi di economia.</i>
<br>
<i>Per avviare la ricerca di un utente o di una Unità Organizzativa, digitare il suo nome o parte di esso e premere OK.</i>



