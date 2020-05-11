extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func update_enemy_score(new_score):
	pass
	
func update_player_score(new_score):
	pass

func update_health(new_percent):
	$HealthBar.text = str(new_percent) + "%"

func update_time(new_time):
	var time_str = str("")
	time_str += floor(new_time / 60)

func killed_by(killer):
	$KillLabel.text = "Fragged by " + str(killer)
	$Reticle.hide()
	$HealthBar.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Reticle.rotation += deg2rad(90 * delta)
