<html>
<head>
	<title>insert</title>
</head>
<body>
<h3>insert</h3>

<table border=1>
<tr>
    <th>Hostname</th>
	<th>Device0</th>
	<th>Link0</th>
	<th>HWaddr0</th>
	<th>inet addr0</th>
	<th>Bcast0</th>
	<th>Mask0</th>
	<th>Rx0</th>
	<th>Tx0</th>
	<th>Device1</th>
	<th>Link1</th>
	<th>HWaddr1</th>
	<th>inet addr1</th>
	<th>Bcast1</th>
	<th>Mask1</th>
	<th>Rx1</th>
	<th>Tx1</th>
	<th>Route</th>
	<th>memory free</th>
	<th>cpu id</th>
</tr>
<tr>
	<td><?=	$_POST["Hostname"] ?></td>
	<td><?=	$_POST["Device0"] ?></td>
	<td><?=	$_POST["link0"] ?></td>
	<td><?=	$_POST["HWaddr0"] ?></td>
	<td><?=	$_POST["inet_addr0"] ?></td>
	<td><?=	$_POST["Bcast0"] ?></td>
	<td><?=	$_POST["Mask0"] ?></td>
	<td><?=	$_POST["Rx0"] ?></td>
	<td><?=	$_POST["Tx0"] ?></td>
	<td><?=	$_POST["Device1"] ?></td>
	<td><?=	$_POST["link1"] ?></td>
	<td><?=	$_POST["HWaddr1"] ?></td>
	<td><?=	$_POST["inet_addr1"] ?></td>
	<td><?=	$_POST["Bcast1"] ?></td>
	<td><?=	$_POST["Mask1"] ?></td>
	<td><?=	$_POST["Rx1"] ?></td>
	<td><?=	$_POST["Tx1"] ?></td>
	<td><?=	$_POST["Route"] ?></td>
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
	
		$Link0      = 0;
	    $inet_addr0 = "";
	    $Bcast0     = "";
	    $Mask0      = "";
	    $Link1      = 0;
	    $inet_addr1 = "";
	    $Bcast1     = "";
	    $Mask1      = "";
	    $Route      = "";
		
		$sql = "select t1.Hostname, t1.device0, t1.Link0, t1.HWaddr0, t1.inet_addr0, t1.Bcast0, t1.Mask0, t1.rx0, t1.tx0, t1.device1, t1.Link1, t1.HWaddr1, t1.inet_addr1, t1.Bcast1, t1.Mask1, t1.rx1, t1.tx1, t1.Route, t1.memory_free, t1.cpu_id, t1.dt from rpitbl as t1 inner join (select Hostname, max(dt) as dt from rpitbl group by Hostname) as t2 on t2.Hostname=t1.Hostname and t2.dt=t1.dt where t1.Hostname = '" . $_POST["Hostname"] . "';";
		$query = mysql_query($sql, $link);
		while($row = mysql_fetch_object($query)){
	      $Link0      = $row->Link0;
	      $inet_addr0 = $row->inet_addr0;
	      $Bcast0     = $row->Bcast0;
	      $Mask0      = $row->Mask0;
	      $Link1      = $row->Link1;
	      $inet_addr1 = $row->inet_addr1;
	      $Bcast1     = $row->Bcast1;
	      $Mask1      = $row->Mask1;
	      $Route      = $row->Route;
	   }
	   
	   $flg = FALSE;
	   if($Link0      != $_POST["link0"])		{ $flg = TRUE; }
	   if($inet_addr0 != $_POST["inet_addr0"])	{ $flg = TRUE; }
	   if($Bcast0     != $_POST["Bcast0"])		{ $flg = TRUE; }
	   if($Mask0      != $_POST["Mask0"])		{ $flg = TRUE; }
	   if($Link1      != $_POST["link1"])		{ $flg = TRUE; }
	   if($inet_addr1 != $_POST["inet_addr1"])	{ $flg = TRUE; }
	   if($Bcast1     != $_POST["Bcast1"])		{ $flg = TRUE; }
	   if($Mask1      != $_POST["Mask1"])		{ $flg = TRUE; }
	   if($Route      != $_POST["Route"])		{ $flg = TRUE; }
	   

	   if($flg == TRUE){
			$sql = sprintf("insert into rpitbl (Hostname, device0, Link0, HWaddr0, inet_addr0, Bcast0, Mask0, Rx0, Tx0, device1, Link1, HWaddr1, inet_addr1, Bcast1, Mask1, Rx1, Tx1, Route, memory_free, cpu_id) values ('%s', '%s', %d, '%s', '%s', '%s', '%s', %d, %d, '%s', %d, '%s', '%s', '%s', '%s', %d, %d, '%s', %d, %d);",
			  $_POST["Hostname"],
			  $_POST["Device0"],
			  $_POST["link0"],
			  $_POST["HWaddr0"],
			  $_POST["inet_addr0"],
			  $_POST["Bcast0"],
			  $_POST["Mask0"],
			  $_POST["Rx0"],
			  $_POST["Tx0"],
			  $_POST["Device1"],
			  $_POST["link1"],
			  $_POST["HWaddr1"],
			  $_POST["inet_addr1"],
			  $_POST["Bcast1"],
			  $_POST["Mask1"],
			  $_POST["Rx1"],
			  $_POST["Tx1"],
			  $_POST["Route"],		  
			  $_POST["memory_free"],
			  $_POST["cpu_id"]
			);
			$query = mysql_query($sql, $link);
		}
	}else{
	   echo "<p>データーベースエラー";
	}
?>
</body>
</html>
