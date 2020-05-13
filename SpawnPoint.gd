extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var team = "neutral"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_spawn_location(entity_team):
	if entity_team == team:
		return check_points()
	else:
		return team

func check_points():
	if $Area1.get_overlapping_areas() == null:
		return $Area1/Position1.get_global_transform().get_translation()
	elif $Area2.get_overlapping_areas() == null:
		return $Area2/Position2.get_global_transform().get_translation()
	elif $Area3.get_overlapping_areas() == null:
		return $Area3/Position3.get_global_transform().get_translation()
	else:
		return null
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
