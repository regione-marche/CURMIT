<table> <tr valign="top"> 
<td style="width:50%">

<ul>
<li><a href="/user/password-update">#acs-subsite.Change_my_Password#</a></li>
<li><a href="/tosap/preferences?user_id=@user_id@&return_url=/tosap">Imposta preferenze</a></li>
</ul>

<div class="portlet-wrapper">
        <div class="portlet">
  	<include src="user-info" />
  	<if @account_status@ eq "closed">
    	#acs-subsite.Account_closed_workspace_msg#
  	</if>
</div>
</div>

</td></tr>
</table>
