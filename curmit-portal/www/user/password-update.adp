<master>
  <property name="doc(title)">#acs-subsite.Update_Password#</property>
  <property name="context">@context;noquote@</property>
  <property name="focus">@focus;noquote@</property>

<if @message@ not nil>
  <div class="general-message">@message@</div>
</if>
<br><br>
<formtemplate id="update"></formtemplate>
<br><br>
<div class="general-message">
  Si ricorda che la password deve rispettare i seguenti criteri di complessit&agrave;:
  <ul>
    <li>deve essere lunga almeno 10 caratteri,</li>
    <li>deve soddisfare almeno 3 dei seguenti requisiti:
      <ul>
	<li>contenere almeno una lettera maiuscola,</li>
	<li>contenere almeno una lettera minuscola,</li>
	<li>contenere almeno un numero,</li>
	<li>contenere almeno un segno di interpunzione o simbolo, spazio compreso (es.: %!=).</li>
      </ul>
    </li>
  </ul>
</div>
