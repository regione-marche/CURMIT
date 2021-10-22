<master>

  <property name="title">Metrica: @origin1@ vs @origin2@</property>

<h1>@origin1@ vs @origin2@</h1>

<blockquote>

<ul>
  <li><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=/sql">sql</a>
    <ul>
      <li><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=/sql/postgresql">postgresql</a>
        <ul>
          <li><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=/sql/postgresql/connettori">connettori</a></li>
          <li><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=/sql/postgresql/triggers">triggers</a></li>
        </ul>
      </li>
    </ul>
  </li>
  <li><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=/tcl">tcl</a>
        <ul>
          <li><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=/tcl/batch">batch</a></li>
        </ul>
  </li>
  <li><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=/www">www</a>
    <ul>
      <li><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=/www/palm">palm</a></li>
      <li><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=/www/regione">regione</a></li>
      <li><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=/www/src">src</a></li>
      <li><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=/www/srcpers">srcpers</a>
        <ul>
          <li><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=/www/srcpers/standard">standard</a></li>
	</ul>
      </li>
      <li><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=/www/tabgen">tabgen</a></li>
      <li><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=/www/utenti">utenti</a></li>
    </ul>
  </li>
</ul>

<table cellpadding="3" cellspacing="3">
  <tr>
    <td valign="top">
<h2>Tipo confronto: @compare_type@</h2>

<if @dirpath@ nil>
  Clicca una specifica cartella per avviare un confronto fra i vari file.<p>
<table cellspacing="3" border="1">

  <tr>
    <th>Tipo<br>file</th>
    <th>Totale<br>@origin1@</th>
    <th>Totale<br>@origin2@</th>
  </tr>

  <multiple name="stat">

  <tr>
    <td align="right">@stat.file_type@</td>
    <td align="right">
      <a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=@dirpath@&present_only_p=1&ftype=@stat.file_type@"
      title="Lista file presenti solo sulla versione base">@stat.tot1@</a>
    </td>
    <td align="right">
      <a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=@dirpath@&absent_only_p=1&ftype=@stat.file_type@"
      title="Lista file assenti dalla versione base">@stat.tot2@</a>
    </td>
  </tr>

  </multiple>

</table>

</if>
<else>
Ritorna al <a href="metrics?origin1=@origin1@&origin2=@origin2@">riepilogo iniziale</a><p>

<table cellspacing="3" border="1">

  <tr>
    <th>Tipo<br>file</th>
    <th>Totale<br>@origin1@</th>
    <th>Totale<br>@origin2@</th>
    <th>Con nome<br>identico</th>
    <th>Con nome<br>e size<br>identici</th>
    <th>Con nome<br>identico<br>size diversa</th>
  </tr>

  <multiple name="stat">

  <tr>
    <td align="right">@stat.file_type@</td>
    <td align="right">
      <a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=@dirpath@&present_only_p=1&ftype=@stat.file_type@"
      title="Lista file presenti solo sulla versione base">@stat.tot1@</a>
    </td>
    <td align="right">
      <a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=@dirpath@&absent_only_p=1&ftype=@stat.file_type@"
      title="Lista file assenti dalla versione base">@stat.tot2@</a>
    </td>
    <td align="right">@stat.inter_name@</td>
    <td align="right"><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=@dirpath@&compare_all_p=1&ftype=@stat.file_type@"
      title="Lista file con nome e size identici, ma differente contenuto">@stat.inter_name_size@</a>
    </td>
    <td align="right"><a href="metrics?origin1=@origin1@&origin2=@origin2@&dirpath=@dirpath@&diff_size_p=1&ftype=@stat.file_type@"
      title="Lista file con stesso nome, ma differente size">@stat.inter_name_diff_size@</a>
    </td>
  </tr>

  </multiple>

</table>
</else>

    </td>

    <td valign="top">

      <if @present_only_p@ true>
        <h2>File presenti solo sulla versione base</h2>
        <ul>
	<multiple name="presents">
          <li>@presents.fname@</li>
	</multiple>
	</ul>
      </if>

      <if @absent_only_p@ true>
        <h2>File assenti dalla versione base</h2>
        <ul>
	<multiple name="absents">
          <li>@absents.fname@</li>
	</multiple>
	</ul>
      </if> 

      <if @diff_size_p@ true>
        <h2>File con stesso nome e size differente</h2>
        <ul>
	<multiple name="diff_size_files">
          <li><a
	  href="diff?one=/var/lib/aolserver/@origin1@/packages/iter@dirpath@/@diff_size_files.fname@&two=/var/lib/aolserver/@origin2@<if @origin2@ not in "iter01" "iter02">/packages/iter</if>@dirpath@/@diff_size_files.fname@">@diff_size_files.fname@</a></li>
	</multiple>
	</ul>
      </if>

      <if @compare_all_p@ true>
        <h2>File con nome e size uguali, ma diverso contenuto</h2>
        <ul>
	<multiple name="differents">
          <li><a href="diff?one=/var/lib/aolserver/@origin1@/packages/iter@dirpath@/@differents.fn@&two=/var/lib/aolserver/@origin2@<if @origin2@ not in "iter01" "iter02">/packages/iter</if>@dirpath@/@differents.fn@">@differents.fn@</a></li>
	</multiple>
	</ul>
      </if>

    </td>
  </tr>
</table>

</blockquote>

