extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var team = "neutral"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_spawn_location(entity_type):
	if entity_type == "player":
		pass
	elif entity_type == "enemy":
		pass
	elif entity_type == "teammate":
		pass
	else:
		pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
