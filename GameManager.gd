extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var players = []
onready var username = get_parent().username
var client

func _ready():
	pass

func load_level(level_name):
	var level
	if level_name == "Ramps":
		level = preload("res://Ramps(gamelevel).tscn")
	if level_name == "Ramps":
		level = preload("res://Ramps(gamelevel).tscn")
	if level_name == "Ramps":
		level = preload("res://Ramps(gamelevel).tscn")
	add_child(level.instance())

# Called when the node enters the scene tree for the first time.

func connect_to_server(ip,port):
	client = NetworkedMultiplayerENet.new()
	client.create_client(ip,port)
	get_tree().set_network_peer(client)
	rpc_id(1,"sync_info",get_parent().username)

func update_self_movement(location,tilt,rotate):
	pass

remote func update_player_movement(name,location,tilt,rotate):
	pass

func update_player_health(name,modifier):
	pass

remote func update_self_health(modifier):
	pass

func _process(delta):
	pass

remote func start_game(level):
	load_level(level)
	$playerShip.movement_enabled = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_player_dead():
	$Level/spa
