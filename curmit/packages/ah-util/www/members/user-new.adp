<master src="/packages/iter/www/master">
  <property name="context_bar">@context;noquote@</property>
  <property name="title">@page_title;noquote@</property>
  <property name="focus">register.first_names</property>

<include src="../../lib/user-new"
    self_register_p="0" 
    email="@email@" 
    return_url="." 
    rel_group_id="@group_id@" />
