<master>
  <property name="context">@context;noquote@</property>
  <property name="title">@page_title;noquote@</property>

<br>
<h1>@page_title@</h1>
<table cellpadding="3" cellspacing="3">

  <tr>

    <td class="list-filter-pane" valign="top" width="200">
      <formtemplate id="filter" style="filter"></formtemplate>
      <listfilters name="maintainers"></listfilters>
    </td>
    <td class="list-list-pane" valign="top">
      <listtemplate name="maintainers"></listtemplate>
    </td>

  </tr>

</table>

