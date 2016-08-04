<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8" />
   <title>ifconfig view</title>
</head>
<body>
<h3>ifconfig view test</h3>

<?php
try{
   $db = new PDO('mysql:host=localhost;dbname=rpidb;charset=utf8', 'rpiusr', 'rpipass');
   print('データベース接続');
   $db = NULL;
}catch(PDOException $e){
   die('エラーメッセージ:' . &e->getMessage());
}
?>

</body>
</html>