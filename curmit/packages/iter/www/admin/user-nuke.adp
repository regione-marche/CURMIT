<master src="../master">
<property name="title">Eliminazione utente</property>
<property name="context_bar">@context_bar@</property>

<p>

Sei sicuro di voler eliminare l'account di @first_names@ @last_name@?

</p>

<p>

Ultimo accesso: <b><if @last_visit@ eq "">nessuno</if><else>@pretty_last_visit@</else></b><br>
N. oggetti creati: <b>@n_objects@</b>

</p>

<formtemplate id="confirm_delete"></formtemplate>
