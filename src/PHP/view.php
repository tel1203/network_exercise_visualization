<html>
<head>
	<title>view</title>
	<script type="text/javascript" language="javascript">
	<!--
	setTimeout("location.reload()", 3000);
	// -->
	</script>
</head>
<body>

<p><a href='delete.php'>データリセット</a></p>

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
	   $sql = "select t1.Hostname, t1.device0, t1.Link0, t1.HWaddr0, t1.inet_addr0, t1.Bcast0, t1.Mask0, t1.rx0, t1.tx0, t1.device1, t1.Link1, t1.HWaddr1, t1.inet_addr1, t1.Bcast1, t1.Mask1, t1.rx1, t1.tx1, t1.Route, t1.memory_free, t1.cpu_id, t1.dt from rpitbl as t1 inner join (select Hostname, max(dt) as dt from rpitbl group by Hostname) as t2 on t2.Hostname=t1.Hostname and t2.dt=t1.dt order by t1.Hostname asc;";
	   $query = mysql_query($sql, $link);
	   while($row = mysql_fetch_object($query)){
	      echo "<tr>";
	      echo "<td rowspan=2><a href='viewOne.php?Hostname=" . $row->Hostname . "'>" . $row->Hostname . "</a></td>";
	      echo "<td>" . $row->device0 . "</td>";
	      echo "<td>" . $row->Link0 . "</td>";
	      echo "<td>" . $row->inet_addr0 . "</td>";
	      echo "<td>" . $row->Bcast0 . "</td>";
	      echo "<td>" . $row->Mask0 . "</td>";
	      echo "<td>" . $row->rx0 . "</td>";
	      echo "<td>" . $row->tx0 . "</td>";
	      echo "<td rowspan=2><pre>" . $row->Route . "</pre></td>";
	      echo "<td rowspan=2>" . $row->dt . "</td>";
	      echo "</tr>";
	      echo "</tr>";
	      echo "<td>" . $row->device1 . "</td>";
	      echo "<td>" . $row->Link1 . "</td>";
	      echo "<td>" . $row->inet_addr1 . "</td>";
	      echo "<td>" . $row->Bcast1 . "</td>";
	      echo "<td>" . $row->Mask1 . "</td>";
	      echo "<td>" . $row->rx1 . "</td>";
	      echo "<td>" . $row->tx1 . "</td>";
	      
	      echo "</tr>";
	   }
	   
	}else{
	   echo "<p>データーベースエラー";
	}
?>
</table>
</body>
</html>
