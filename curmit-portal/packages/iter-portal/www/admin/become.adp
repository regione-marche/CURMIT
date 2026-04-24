<master>
  <property name="title">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>

<h2>@page_title;noquote@</h2>
<table cellpadding="3" cellspacing="3">
<!--mat01 aggiunto scope a tutti i th-->
  <tr>
    <th align="left" scope="col">Email</th>
    <th scope="col">Tipo utente</th>
    <th scope="col">&nbsp;</th>
  </tr>

  <multiple name="users">
  <tr>
    <td>@users.name@</td>
    <td>@users.type@</td>
    <td><a href="become-2?user_id=@users.user_id@">diventa questo utente</a></td>
  </tr>
  </multiple>

</table>



