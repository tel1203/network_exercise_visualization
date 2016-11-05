<html>
<head>
	<title>test</title>
</head>
<body>

<p><a href='view.php'>top</a></p>

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
	   $sql = "select * from rpitbl where HWaddr = '" . $_GET["HWaddr"] . "' order by dt desc";
	   $query = mysql_query($sql, $link);
	   while($row = mysql_fetch_object($query)){
	      echo "<tr>";
	      echo "<td>" . $row->Link . "</td>";
	      echo "<td>" . $row->device . "</td>";
	      echo "<td>" . $row->HWaddr . "</td>";
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
