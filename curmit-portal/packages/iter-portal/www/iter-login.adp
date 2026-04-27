<html>
  <body>

    <form name="login" action="http://@url@/iter/">
      <input type="hidden" name="form:mode" value="edit" />
      <input type="hidden" name="form:id" value="login" />
      <input type="hidden" name="utn_cde" value="@iter_code@" />
      <input type="hidden" name="utn_psw" value="@password@" />
    </form>

    <script language="JavaScript">
       window.document.login.submit();
    </script>

  </body>
</html>
