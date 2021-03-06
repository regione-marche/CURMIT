<master>
<property name="context">@context;noquote@</property>
<property name="doc(title)">@title;noquote@</property>

<h1>@title;noquote@</h1>
<include src="/packages/faq/lib/faq-add-edit" &="faq_id" mode="display">

<if @faq_q_and_as:rowcount@ eq 0>
 <i>#faq.lt_no_questions#</i><p></p>
</if>

<else>
 <ol>
  <multiple name=faq_q_and_as>
   <li>
    @faq_q_and_as.question;noquote@ 
    (  
     <a href="q-and-a-add-edit?entry_id=@faq_q_and_as.entry_id@&faq_id=@faq_id@" title="Edit Question">#faq.edit#</a> |
     <a href="one-question?entry_id=@faq_q_and_as.entry_id@" title="Preview Question">#faq.preview#</a> |
     <a href="q_and_a-delete?entry_id=@faq_q_and_as.entry_id@" onclick="return confirm('#faq.lt_Are_you_sure_you_want_1#');" title="Delete Question">#faq.delete#</a> |

     <if @faq_q_and_as.sort_key@ ne @highest_sort_key_in_list@>
       <a href="q-and-a-add-edit?prev_entry_id=@faq_q_and_as.entry_id@&faq_id=@faq_id@" title="Insert new question after this one">#faq.insert_after#</a> |
       <a href="swap?faq_id=@faq_id@&entry_id=@faq_q_and_as.entry_id@" title="Swap question with next one">#faq.swap_with_next#</a>
     </if>
     <else>
       <a href="q-and-a-add-edit?prev_entry_id=@faq_q_and_as.entry_id@&faq_id=@faq_id@" title="Insert new question after this one">#faq.insert_after#</a>
     </else>
    )
   </li>
  </multiple>
 </ol>
</else>

<ul class="action-links">
  <li><a href="q-and-a-add-edit?faq_id=@faq_id@">#faq.Create_New_QA#</a></li>
  <li><a href=".">#faq.View_All_FAQs#</a></li>
</ul>
