extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var max_connections = 6
export var minimum_players = 1
var players = []
var network

class player:
	var id = 0
	var username = ""
	var position = Vector3()
	var tilt = 0
	var rotate = 0
	var team
	
	func _init(id):
		self.id = id

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

func init_server(ip,port):
	network = NetworkedMultiplayerENet.new()
	network.create_server(port,max_connections)
	get_tree().set_network_peer(network)
	
	network.connect("peer_connected",self,"_peer_connected")
	network.connect("peer_disconnected",self,"_peer_disconnected")

func _peer_connected(id):
	players.append(player.new(id))
	for item in players:
		rpc_id(item.id,"update_player_list",players)
	print(get_parent().get_node("UI").display_text(str(players)))

func _peer_disconnected(id):
	for item in players:
		if item.id == id:
			players.remove(item)
	for item in players:
		get_parent().get_node("Client").rpc_id(item.id,"update_player_list",players)

remote func sync_info(username):
	var id = get_tree().get_rpc_sender_id()
	for item in players:
		if item.id == id:
			players.item.set_username(username)

func start_game(level):
	if players.size() > minimum_players:
		players.shuffle()
		for i in range(0,players.size()):
			if i < players.size()/2:
				players[i].team = "blue"
			else:
				players[i].team = "red"
		for item in players:
			get_parent().get_node("Client").rpc_id(item.id,"update_player_list",players)
			get_parent().get_node("Client").rpc_id(item.id,"start_game",level)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	start_game("Ramps")
