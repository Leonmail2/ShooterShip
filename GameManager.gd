extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var players = get_parent().players
var client

func new_game(level_name):
	var level
	if level_name == "Ramps":
		level = preload("res://Ramps(gamelevel).tscn")
	if level_name == "Ramps":
		level = preload("res://Ramps(gamelevel).tscn")
	if level_name == "Ramps":
		level = preload("res://Ramps(gamelevel).tscn")
	add_child(level.instance())

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game("Ramps")

func connect_to_server(ip,port = 3452):
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_player_dead():
	$Level/spa
