extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func new_game(level_name):
	var level
	if level_name == "Ramps":
		level = preload("res://Ramps(gamelevel).tscn")
	if level_name == "Ramps":
		level = preload("res://Ramps(gamelevel).tscn")
	if level_name == "Ramps":
		level = preload("res://Ramps(gamelevel).tscn")
	add_child(level.instance())

func new_player_instance():
	pass

func send_hit(player_name):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game("Ramps")

func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
