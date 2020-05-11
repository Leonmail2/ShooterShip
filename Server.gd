extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var port = 3452
export var max_connections = 4
var players = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init_server(ip):
	var network = NetworkedMultiplayerENet.new()
	network.create_server(port,max_connections)
	get_tree().set_network_peer(network)
	
	network.connect("peer_connected",self,"_peer_connected")
	network.connect("peer_disconnected",self,"_peer_disconnected")

func _peer_connected(id):
	pass

func _peer_disconnected(id):
	pass

remote func sync_input(player_name):
	if player_name in players:
		pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
