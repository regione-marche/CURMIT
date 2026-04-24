<include src=@scope_fs_url@ folder_id=@folder_id@ root_folder_id=@root_folder_id@ viewing_user_id=@user_id@ n_past_days=@n_past_days@ fs_url="@url@">
<p>@notification_chunk;noquote@</p>
<if @webdav_url@ not nil>
      <p>#file-storage.Folder_available_via_WebDAV_at#</p>
</if>
