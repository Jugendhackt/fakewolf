<?php
$roomID = $_GET["roomID"];
$messages = array();
$res = $pdo->query("SELECT * FROM messages WHERE `roomID` = $roomID");
foreach ($res as $item){
    array_push($messages, array("sessionID"=>$item["sessionID"],"value"=>$item["value"],"time"=>time()));
}
echo json_encode($messages);
die();
?>