<?php
$content = json_decode(file_get_contents('php://input'));
$name = $content->name;
$sessionID = session_id();

$pdo->query("INSERT INTO sessions (sessionID ,name) VALUES ('$sessionID', '$name')");
die($sessionID);
?>