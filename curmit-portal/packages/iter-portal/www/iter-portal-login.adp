<property name="focus">@focus;noquote@</property>

<div id="register-login">
<formtemplate id="login"></formtemplate>

<!-- but01 <if @forgotten_pwd_url@ not nil> </if>-->
<!--but01  <if @email_forgotten_password_p@ true> </if> -->
<!--but01  <a href="@forgotten_pwd_url@">#acs-subsite.Forgot_your_password#</a> -->
<!--but01  <br>-->
 <!--but01  </if> -->
<!--but01 </if> -->
<if @self_registration@ true>

<if @register_url@ not nil>
  <!-- commentato per evitare registrazione incompleta-->
  <!-- <a href="@register_url@">#acs-subsite.Register#</a> -->
</if>

</if>
</div>
