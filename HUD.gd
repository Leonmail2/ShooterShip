extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
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
	$Reticle.position.x = int(get_viewport().size.x / 2)
	$Reticle.position.y = int(get_viewport().size.y / 2)
