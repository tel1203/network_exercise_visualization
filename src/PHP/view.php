<html>
<head>
	<title>test</title>
</head>
<body>

<table border=1>
<tr>
	<th>Link</th>
	<th>Device</th>
	<th>HWaddr</th>
	<th>inet addr</th>
	<th>Bcast</th>
	<th>Mask</th>
	<th>memory free</th>
	<th>cpu id</th>
	<th>datetime</th>
</tr>

<?php	
	$dbServer = "127.0.0.1";
	$dbUser   = "root";
	$dbPass   = "";
	$dbName   = "rpidb";

	$flag = TRUE;
	if(!$link = mysql_connect($dbServer, $dbUser, $dbPass)){
	   $flag = FALSE;
	}elseif(!mysql_select_db($dbName, $link)){
	   $flag = FALSE;
	}

	if($flag == TRUE){
	   $sql = "select t1.Link, t1.device, t1.HWaddr, t1.inet_addr, t1.Bcast, t1.Mask, t1.memory_free, t1.cpu_id, t1.dt from rpitbl as t1 inner join (select HWaddr, max(dt) as dt from rpitbl group by HWaddr) as t2 on t2.HWaddr=t1.HWaddr and t2.dt=t1.dt;";
	   $query = mysql_query($sql, $link);
	   while($row = mysql_fetch_object($query)){
	      echo "<tr>";
	      echo "<td>" . $row->Link . "</td>";
	      echo "<td>" . $row->device . "</td>";
	      echo "<td><a href='viewOne.php?HWaddr=" . $row->HWaddr . "'>" . $row->HWaddr . "</a></td>";
	      echo "<td>" . $row->inet_addr . "</td>";
	      echo "<td>" . $row->Bcast . "</td>";
	      echo "<td>" . $row->Mask . "</td>";
	      echo "<td>" . $row->memory_free . "</td>";
	      echo "<td>" . $row->cpu_id . "</td>";
	      echo "<td>" . $row->dt . "</td>";
	      echo "</tr>";
	   }
	   
	}else{
	   echo "<p>データーベースエラー";
	}
?>
</table>
</body>
</html>
