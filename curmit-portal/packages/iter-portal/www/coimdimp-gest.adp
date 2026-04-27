<master   src="../master">
<property name="title">Conferma</property>
<property name="context_bar">@context_bar;noquote@</property>

<center>
<formtemplate id="@form_name;noquote@">

@link_tab;noquote@
@dett_tab;noquote@

<!-- Inizio della form colorata -->
<%=[iter_form_iniz]%>

<if @flag_conf@ eq S>
<tr><td colspan=2>Hai inserito tutti i generatori?</td></tr>
<tr>
    <td align=center>
       <input type="button"
    onclick="javascript:location.href=('coimdimp-f-gest?@link;noquote@')"
    value ="Si">
    </td>
    <td align=center>
       <input type="button"
    onclick="javascript:location.href=('coimgend-list?@link2;noquote@')"
    value ="No">
    </td>
</tr>

</if>

<!-- Fine della form colorata -->
<%=[iter_form_fine]%>

</formtemplate>
<p>
</center>

