<if @scoped_p@ eq 1>
<include src=@scope_fs_url@ folder_id=@folder_id@ root_folder_id=@folder_id@ viewing_user_id=@user_id@ n_past_days=@n_past_days@ fs_url="@url@" page_num="@page_num@">
</if>

<else>

<if @write_p@ true>
	<div class="list-button-bar-top">
		<a href="@url@folder-create?parent_id=@folder_id@" class="button" title="#file-storage-includelet.create_new_folder#">#file-storage-includelet.create_new_folder#</a>
		<a href="@url@file-add?folder_id=@folder_id@" class="button" title="#file-storage-includelet.upload_file#">#file-storage-includelet.upload_file#</a>
		<a href="@url@simple-add?folder_id=@folder_id@" class="button" title="#file-storage-includelet.create_url#">#file-storage-includelet.create_url#</a>
	</div>

</if>
  <listtemplate name="folders"></listtemplate>
</else>

<p>@notification_chunk;noquote@</p>

<if @webdav_url@ not nil>
      <p>#file-storage.Folder_available_via_WebDAV_at#</p>
</if>

