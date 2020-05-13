extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var port = 3452
export var max_connections = 6
var players = []
var network

class player:
	var id = 0
	var username = ""
	var position = Vector3()
	var tilt = 0
	var rotate = 0
	
	func _init(id):
		self.id = id
	func set_id(id):
		self.id = id
	func get_id():
		return self.id
	func set_username(username):
		self.username = username
	func get_username():
		return self.username

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init_server(ip):
	network = NetworkedMultiplayerENet.new()
	network.create_server(port,max_connections)
	get_tree().set_network_peer(network)
	
	network.connect("peer_connected",self,"_peer_connected")
	network.connect("peer_disconnected",self,"_peer_disconnected")

func _peer_connected(id):
	players.append(player.new(id))

func _peer_disconnected(id):
	for item in players:
		if item.id == id:
			players.remove(item)

remote func sync_info(username):
	var id = get_tree().get_rpc_sender_id()
	for item in players:
		if item.id == id:
			players.item.set_username(username)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
