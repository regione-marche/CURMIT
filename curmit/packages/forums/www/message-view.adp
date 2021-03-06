<master>
  <property name="doc(title)">@page_title;noquote@</property>
  <property name="context">@context;noquote@</property>
  <property name="displayed_object_id">@message_id@</property>

<h1>@page_title;noquote@</h1>

  <if @searchbox_p@ true>
    <include src="/packages/forums/lib/search/search-form" forum_id="@message.forum_id@">
  </if>

  <ul class="action-links">
    <li><a href="@thread_url@" title="#forums.Back_to_thread_label#">#forums.Back_to_thread_label#</a></li>
  </ul>

  <p>@notification_chunk;noquote@</p>

  <include src="/packages/forums/lib/message/thread-chunk"
    &message="message"
    &forum="forum"
    &permissions="permissions">

    <if @reply_url@ not nil>
      <if @forum.presentation_type@ eq "flat">
        <a href="@reply_url@" title="#forums.Post_a_Reply#"><b>#forums.Post_a_Reply#</b></a>
      </if>
      <else>
        <a href="@reply_url@" title="#forums.Reply_to_first_post_on_page_label#"><b>#forums.Reply_to_first_post_on_page_label#</b></a>
      </else>
    </if>

    <ul class="action-links">
      <li><a href="@thread_url@" title="#forums.Back_to_thread_label#">#forums.Back_to_thread_label#</a></li>
    </ul>
