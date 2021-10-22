
#xowiki-includelet.manage-pages# <a href='@base_url@'>#xowiki-includelet.community-wiki#</a>
<if @package_id@ eq "">
  <small>No community specified</small>
</if>
<else>
<ul>
<multiple name="content">
  <li>
    @content.pretty_name@<small> <a class="button" href="@base_url@xowiki-includelet/admin/layout-element-remove?element_id=@content.element_id@&referer=@referer@">#xowiki-includelet.remove-includelet#</a></small>
  </li>
</multiple>
</ul>
@form;noquote@
</else>
