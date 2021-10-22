<master src="/packages/iter/www/master">
  <property name="title">#acs-subsite.Permissions_for_name#</property>
  <property name="context_bar">@context;noquote@</property>

  <h3>Permessi ereditati</h3>
  <if @inherited:rowcount@ gt 0>
    <ul>
      <multiple name="inherited">
        <li>@inherited.grantee_name@, @inherited.privilege@</li>
      </multiple>
    </ul>
  </if>
  <else>
    <p><em>#acs-subsite.none#</em></p>
  </else>
  <h3>#acs-subsite.Direct_Permissions#</h3>
  <if @acl:rowcount@ gt 0>
    <form method="get" action="revoke">
      @export_form_vars;noquote@
      <multiple name="acl">
        <if @mainsite_p@ true and @acl.grantee_id@ eq "-1">@acl.grantee_name@, @acl.privilege@ <b>#acs-subsite.perm_cannot_be_removed#</b><br /></if>
        <else>
          <input type="checkbox" name="revoke_list" value="@acl.grantee_id@ @acl.privilege@" 
            id="check_@acl.grantee_id@_@acl.privilege@">
            <label for="check_@acl.grantee_id@_@acl.privilege@">@acl.grantee_name@, @acl.privilege@</label><br />
        </else>
      </multiple>
    </blockquote>
  </if>
  <else>
    <p><em>#acs-subsite.none#</em></p>
  </else>
  <if @acl:rowcount@ gt 0>
    <input type=submit value="#acs-subsite.Revoke_Checked#">
    </form>
  </if>
  @controls;noquote@
