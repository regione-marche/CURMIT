<master src="/www/blank-master">
<if @doc@ defined><property name="&doc">doc</property></if>
<if @body@ defined><property name="&body">body</property></if>
<if @head@ not nil><property name="head">@head;noquote@</property></if>
<if @focus@ not nil><property name="focus">@focus;noquote@</property></if>
<property name="skip_link">@skip_link;noquote@</property>

<div id="wrapper">
    <div id="system-name">
      <if @system_url@ not nil><a href="@system_url@">@system_name@</a></if>
      <else>@system_name@</else>
    </div>
  <div id="header">
    <div class="block-marker">Begin header</div>
    <div id="header-navigation">
      <ul class="compact">
        <li>
          <if @untrusted_user_id@ ne 0>#acs-subsite.Welcome_user#</if>
          <else>#acs-subsite.Not_logged_in#</else> | 
        </li>
        <if @pvt_home_url@ not nil>
          <li><a href="/user/password-update?return_url=/iter/main" title="#acs-subsite.Change_pass_email_por#">Cambia password</a> |</li>
        </if>
	
        <li>
	  <if @untrusted_user_id@ ne 0><a href="/iter/accessibility" title="Accessibilità">Accessibilità</a></if>
	</li>
        <if @login_url@ not nil>
          <li><a href="@login_url@" title="#acs-subsite.Log_in_to_system#">#acs-subsite.Log_In#</a></li>
        </if>
        <if @logout_url@ not nil>
          <li><a href="@logout_url@" title="#acs-subsite.Logout_from_system#">#acs-subsite.Logout#</a></li>
        </if>
      </ul>
    </div>
    <div id="breadcrumbs">
      <if @context_bar@ not nil>
        @context_bar;noquote@
      </if>
      <else>
        <if @context:rowcount@ not nil>
        <ul class="compact">
          <multiple name="context">
          <if @context.url@ not nil>
            <li><a href="@context.url@">@context.label@</a> @separator@</li>
          </if>
          <else>
            <li>@context.label@</li>
          </else>
          </multiple>
        </ul>
        </if>
      </else>
    </div>
  </div> <!-- /header -->
            
  <if @navigation:rowcount@ not nil>
    <list name="navigation_groups">
      <div id="@navigation_groups:item@-navigation">
        <div class="block-marker">Begin @navigation_groups:item@ navigation</div>
        <ul>
          <multiple name="navigation">
          <if @navigation.group@ eq @navigation_groups:item@>
            <li<if @navigation.id@ not nil> id="@navigation.id@"</if>><a href="@navigation.href@"<if @navigation.target@ not nil> target="@navigation.target;noquote@"</if><if @navigation.class@ not nil> class="@navigation.class;noquote@"</if><if @navigation.title@ not nil> title="@navigation.title;noquote@"</if><if @navigation.lang@ not nil> lang="@navigation.lang;noquote@"</if><if @navigation.accesskey@ not nil> accesskey="@navigation.accesskey;noquote@"</if><if @navigation.tabindex@ not nil> tabindex="@navigation.tabindex;noquote@"</if>>@navigation.label@</a></li>
          </if>
          </multiple>
        </ul>
      </div>
    </list>
  </if>

  <div id="content-wrapper">
    <div class="block-marker">Begin main content</div>
    <div id="inner-wrapper">
        
    <if @user_messages:rowcount@ gt 0>
      <div id="alert-message">
        <multiple name="user_messages">
          <div class="alert">
            <strong>@user_messages.message;noquote@</strong>
          </div>
         </multiple>
       </div>
     </if>

     <if @main_content_p@>
       <div id="main">
         <div id="main-content">
           <div class="main-content-padding">
             <slave />
           </div>
         </div>
       </div>
     </if>
     <else>
       <slave />
     </else>

    </div>
  </div> <!-- /content-wrapper -->

</div> <!-- /wrapper -->

