<?php
use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;

// Make sure composer dependencies have been installed
require __DIR__ . '/vendor/autoload.php';


class Room{
    public $id;
	public $phase//the phase the room is currently in_array
	public $alarm//the time at which the curret phase is over
    private $players;

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
		$this->phase = 1
		$this.alarm = time()+90
	}
	
	public function (){}
}

class Server implements MessageComponentInterface{
    protected $clients;
    private $rooms;

    public function __construct() {
        $this->rooms = array();
        $this->clients = new \SplObjectStorage;
    }

    public function onOpen(ConnectionInterface $conn) {
        $this->clients->attach($conn);
    }

    public function onMessage(ConnectionInterface $from, $msg) {
        $data = json_decode($msg);
        switch ($data->action){
            case 'createRoom':
                $id = rand(111111, 999999);
                $this->rooms[$id] = new Room($id);
                $this->rooms[$id]->addPlayer($data->name);
                $output = json_encode(array(
                    "type"=>"room",
                    "roomID"=>$id
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
            case 'getCards':
                $from->send(json_encode(array(
                    "action"=>"cards",
                    "data"=>array(

                    )
                )));
				
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
$app = new Ratchet\App('localhost', 8080);
$app->route('/', new Server, array('*'));
$app->run();