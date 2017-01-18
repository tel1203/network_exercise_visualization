<html>
<head>
	<title>データリセット</title>
</head>
<body>

<p><a href='view.php'>top</a></p>

<p>データを削除しました。</p>

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
	   $sql = "delete from rpitbl;";
	   $query = mysql_query($sql, $link);
	}else{
	   echo "<p>データーベースエラー";
	}
?>
</table>
</body>
</html>
