<div class='Page'>
  <div class='portlet-wrapper'>
    <div class='portlet-header'>
      <div class='portlet-title-no-controls'>@name@</div>
    </div>
    <div class="portlet">
<small>
    <ol>
      <multiple name=faq_items>
        <if @faq_items.rownum@ le @n_faq_items@>
          <li><a href="/faq/one-question?entry_id=@faq_items.entry_id@" onClick="toggleLinkContentFold('faq_@faq_items.entry_id@');return false;">@faq_items.question@</a><br><br>
              <div id="faq_@faq_items.entry_id@" style="display:none;">
                  @faq_items.answer@
              </div>
	  </li>
        </if>
      </multiple>
      </ol>
</small>
    </div>
  </div>
</div>
