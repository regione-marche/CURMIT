<master>

<!--mat01 sostituiti i tag b con strong -->

<h1>Forniture</h1>

<h2>Distributore: @object_description@</h2>

<p>
<a href=tracciato_distributori.xlsx>Scarica tracciato standard</a><br>
<a href=tracciato_distributori.xml download="tracciato_distributori">Scarica tracciato con xml</a>
<if @check_marche@ > <!--mat01 aggiunto if e contenuto -->
<br><a href=CURMIT-Distributori-Manuale-funzionale.pdf >Scarica manuale funzionale in pdf </a>
</if>
<br><br>
<big>
<strong>ATTENZIONE:</strong><br>
<strong>Ogni file CSV non deve contenere più di 1000 record per evitare problemi di rallentamento del sistema.</strong><br>
Una volta caricata la fornitura va confermata obbligatoriamente mediante l'apposito link.<br>
Se esistono errori nella fornitura bisogna correggere il file e ricaricarlo.<br>
La fornitura errata va poi eliminata tenendo solo quella confermata.
@msg_di_prova;noquote@
</big>
</p>
<table cellpadding="3" cellspacing="3">

  <tr>

    <td class="list-list-pane" valign="top">

      <listtemplate name="attachments"></listtemplate>

    </td>

  </tr>

</table>




