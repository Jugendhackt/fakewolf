<?php
$content = json_decode(file_get_contents('php://input'));
$name = $content->name;
$difficulty = $content->difficulty;
$sessionID = $content->sessionID;

$pdo->query("INSERT INTO rooms (difficulty,name) VALUES (0,'$name')");
die($name);
?>