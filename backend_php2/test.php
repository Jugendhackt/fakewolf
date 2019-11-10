<?php
use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;

// Make sure composer dependencies have been installed
require __DIR__ . '/vendor/autoload.php';

class Player{
	public $id;
	public $name;



	public function __construct($name, $id){

	}


}

class Room{
    public $id;
	public $phase;//the phase the room is currently in_array
	public $alarm;//the time at which the curret phase is over
    public $players; //array with player IDs (same ids as corresponding clients)

    public function __construct($id) {
        $this->id = $id;
        $this->players = array();
		$this->phase = 0;
    }

    public function addPlayer($name){
        array_push($this->players, $name);
    }
	
    public function getPlayers(){
        return json_encode($this->players);
    }

	public function startRoom(){
		$this->phase = 1;
		$this->alarm = time()+90;
	}
}

class Server implements MessageComponentInterface{
	protected $clients;
	private $clientNames; //Array with  the same index as clients, but an the players name  as value
	private $clientRooms; //Array with the same index as clients, but an roomID as value
    private $rooms;

    public function __construct() {
        $this->rooms = array();
        $this->clients = new \SplObjectStorage;
    }

    public function onOpen(ConnectionInterface $conn) {
        print("lel");
        $this->clients->attach($conn);
    }

    public function onMessage(ConnectionInterface $from, $msg) {
        $data = json_decode($msg);
        switch ($data->action){
            case 'createRoom':
                $id = rand(111111, 999999);
                $this->rooms[$id] = new Room($id);
                $this->rooms[$id]->addPlayer($data->name);

                for($i=0;$i<count($this->clients);$i++){
                    if($this->clients[$i]==$from){
                        $clientNames[$i]=$data->name;
                        $clientRooms[$i]=$id;
                    }
                }

		        $output = json_encode(array(
                    "action"=>"room",
                    "data"=>$id
                ));
                $from->send($output);
                break;
            case 'joinRoom':
                $id = $data->roomID;
                if ($this->rooms[$id] != null){
                    $this->rooms[$id]->addPlayer($data->name);
                    $from->send($this->rooms[$id]->getPlayers());
                }
                else{
                    $from->send("Room does not exist");
		        }
                for($i=0;$i<count($this->clients);$i++){
                    if($this->clients[$i]==$from){
                        $senderID = $i;
                        $clientNames[$i]=$data->name;
                        $clientRooms[$i]=$data->roomID;
                    }
                }
		        foreach($this->rooms[senderID].players as $playerID){
                    $this->clients[$playerID].send("{type:roomUpdate,data{hello, hello}}");
                }
                break;
            case 'sendMessage':
                foreach ($this->clients as $client) {
                    if ($from != $client) {
                        $client->send(json_encode(array(
                            "type"=>"message",
                            "value"=>$data->value
                        )));
                    }
                }
                $from->send("success");
                break;
            case 'playCard':
                for($i=0;$i<count($this->clients);$i++){
                    if($this->clients[$i]==$from){
                        $roomID = $this->clientRooms[$i];
                        $clientID = $i;
                    }
                }
                $player = $this->rooms[$roomID]->players[$clientID];
                $card = array("description" => "Blah", "keywords" => "some key words");
                $player->cards[$data->index] = $card;
                $from->send(json_encode($card));
	    }
    }

    public function onClose(ConnectionInterface $conn) {
        $this->clients->detach($conn);
    }

    public function onError(ConnectionInterface $conn, \Exception $e) {
        $conn->close();
    }
}

// Run the server application through the WebSocket protocol on port 8080
$app = new Ratchet\App('78.47.150.51', 6789, '78.47.150.51');
$app->route('/', new Server, array('*'));
$app->run();