<master   src="../master">
<property name="title">@page_title;noquote@</property>
<property name="context_bar">@context_bar;noquote@</property>

<if @caller@ eq index>
     <table width="25%" cellspacing=0 class=func-menu>
     <tr>
        <td width="25%" nowrap class=func-menu>
            <a href="coimaimp-gest?@link_gest;noquote@" class=func-menu>Ritorna</a>
        </td>
     </tr>
     </table>
</if>

<br><br>
<center>
<!-- genero la tabella -->
@table_result;noquote@

</center>

