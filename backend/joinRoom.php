<?php
$content = json_decode(file_get_contents('php://input'));
$roomID = $content->roomID;
$sessionID = session_id();

$pdo->query("UPDATE sessions SET `roomID` = '$roomID' WHERE `sessionID` = '$sessionID'");
?>