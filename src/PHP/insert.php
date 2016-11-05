<html>
<head>
	<title>test</title>
</head>
<body>
<h3>insert</h3>

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
</tr>
<tr>
	<td><?=	$_POST["link"] ?></td>
	<td><?=	$_POST["Device"] ?></td>
	<td><?=	$_POST["HWaddr"] ?></td>
	<td><?=	$_POST["inet_addr"] ?></td>
	<td><?=	$_POST["Bcast"] ?></td>
	<td><?=	$_POST["Mask"] ?></td>
	<td><?=	$_POST["memory_free"] ?></td>
	<td><?=	$_POST["cpu_id"] ?></td>
</tr>
</table>
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
		$sql = sprintf("insert into rpitbl (Link, device, HWaddr, inet_addr, Bcast, Mask, memory_free, cpu_id) values (%d, '%s', '%s', '%s', '%s', '%s', %d, %d);",
		  $_POST["link"],
		  $_POST["Device"],
		  $_POST["HWaddr"],
		  $_POST["inet_addr"],
		  $_POST["Bcast"],
		  $_POST["Mask"],
		  $_POST["memory_free"],
		  $_POST["cpu_id"]
		);
		echo $sql;
		$query = mysql_query($sql, $link);
	}else{
	   echo "<p>データーベースエラー";
	}
?>
</body>
</html>
