<?php
$headers = getallheaders();
$name = $headers["name"];
$difficulty = $headers["difficulty"];
$sessionID = $headers["sessionID"];

$pdo->query("INSERT INTO rooms (difficulty,name) VALUES (0,$name)");
die($name);
?>