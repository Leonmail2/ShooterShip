extends KinematicBody
signal dead

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var position = Vector3(0,0,0)
var direction = 0
var tilt = 0

var alive = 1

var weapon_cooldown = true
var last_side = "left"
export var damage = -50

var team = "red"
export var player_name = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$playerCamera.current = true
	var node
	if team == "red":
		node = preload("res://assets/ShipRed.tscn")
		$gunship/mesh.add_child(node.instance())
	if team == "blue":
		node = preload("res://assets/ShipBlue.tscn")
		$gunship/mesh.add_child(node.instance())
		
func fire_weapon():
	if last_side == "left":
		last_side = "right"
		$gunship/GunRightParticles.emitting = true
	else:
		last_side = "left"
		$gunship/GunLeftParticles.emitting = true
	$gunship/GunCast.force_raycast_update()
	var collision = $gunship/GunCast.get_collider()
	if $gunship/GunCast.is_colliding() == true:
		print(collision.get_parent())
		if collision.get_parent() is KinematicBody:
			if team != collision.get_parent().team:
				collision.get_parent().hit(player_name)

func roll_camera(degrees):
	$gunship.rotation = Vector3(0,0,deg2rad(clamp(degrees,-22,22)))

func death(killer_name):
	#update server
	$gunship.hide()
	$FlameParticles.emitting = true
	$SmokeParticles.emitting = true
	alive = 0
	direction = Vector3(0,0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	roll_camera(tilt)

func _physics_process(delta):
	pass #interpolation stuff here.



