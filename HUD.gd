<<<<<<< HEAD
extends Node2D
=======
extends Spatial
>>>>>>> 59f11d5... initial commit


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
<<<<<<< HEAD
	hide()
=======
	pass # Replace with function body.
>>>>>>> 59f11d5... initial commit
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
<<<<<<< HEAD
	$Reticle.position.x = int(get_viewport().size.x / 2)
	$Reticle.position.y = int(get_viewport().size.y / 2)
=======
	$Reticle.rotation += deg2rad(90 * delta)
>>>>>>> 59f11d5... initial commit
