<?php
$content = json_decode(file_get_contents('php://input'));
$sessionID = $content->sessionID;
$value = $content->value;
$roomID = $content->roomID;


$pdo->query("INSERT INTO messages (roomID, sessionID, value) VALUES ($roomID,$sessionID,'$value')");
?>