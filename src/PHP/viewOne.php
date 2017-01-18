<html>
<head>
	<title>ViewOne</title>
	<script type="text/javascript" language="javascript">
	<!--
	setTimeout("location.reload()", 3000);
	// -->
	</script>
</head>
<body>

<p><a href='view.php'>top</a></p>

<table border=1>
<tr>
    <th>キット名</th>
	<th>デバイス</th>
	<th>リンクアップ</th>
	<th>IPアドレス</th>
	<th>ブロードキャストアドレス</th>
	<th>サブネットマスク</th>
	<th>受信パケット数</th>
	<th>送信パケット数</th>
	<th>ルーティングテーブル</th>
	<th>時刻</th>
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
	   $sql = "select * from rpitbl where Hostname = '" . $_GET["Hostname"] . "' order by dt desc";
	   $query = mysql_query($sql, $link);
	   while($row = mysql_fetch_object($query)){
	      echo "<tr>";
	      echo "<td rowspan=2>" . $row->Hostname . "</td>";
	      echo "<td>" . $row->device0 . "</td>";
	      echo "<td>" . $row->Link0 . "</td>";
	      echo "<td>" . $row->inet_addr0 . "</td>";
	      echo "<td>" . $row->Bcast0 . "</td>";
	      echo "<td>" . $row->Mask0 . "</td>";
	      echo "<td>" . $row->Rx0 . "</td>";
	      echo "<td>" . $row->Tx0 . "</td>";
	      echo "<td rowspan=2><pre>" . $row->Route . "</pre></td>";
	      echo "<td rowspan=2>" . $row->dt . "</td>";
	      echo "</tr>";
	      echo "</tr>";
	      echo "<td>" . $row->device1 . "</td>";
	      echo "<td>" . $row->Link1 . "</td>";
	      echo "<td>" . $row->inet_addr1 . "</td>";
	      echo "<td>" . $row->Bcast1 . "</td>";
	      echo "<td>" . $row->Mask1 . "</td>";
	      echo "<td>" . $row->Rx1 . "</td>";
	      echo "<td>" . $row->Tx1 . "</td>";
	      echo "</tr>";
	   }
	   
	}else{
	   echo "<p>データーベースエラー";
	}
?>
</table>
</body>
</html>
