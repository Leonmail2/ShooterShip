extends KinematicBody
signal dead

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var max_speed = 8000
export var strafe_speed = 100
export var max_accel = 6000
export var max_decel = 7000
export var mouse_sensitivity = 0.3
export var gravity = -40
var mouse_movement = Vector2(0,0)
var direction = Vector3(0,0,0)
var velocity = Vector3(0,0,0)
var tilt = 0
var speed = 0
var strafe = 0

var health = 400
var alive = 1
var precent_multiplier = 100/400

var weapon_cooldown = true
var last_side = "left"
export var damage = -50

var team = "red"
export var player_name = "Enemy"
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

func _on_CooldownTimer_timeout():
	weapon_cooldown = true

func hit(player):
	add_health(damage)
	if health == 0:
		death(player)

func add_health(new):
	health += new
	#update server

func roll_camera(degrees):
	$gunship.rotation = Vector3(0,0,deg2rad(clamp(degrees,-22,22)))

func death(killer_name):
	#update server
	$gunship.hide()
	$FlameParticles.emitting = true
	$SmokeParticles.emitting = true
	velocity = Vector3(0,0,0)
	alive = 0
	speed = 0
	direction = Vector3(0,0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	roll_camera(tilt)

func _physics_process(delta):
	direction = Vector3(0,0,0)
	
	var basis = $playerCamera.get_global_transform().basis
	var hold = speed
	if alive == 1:
		#speed = client_data
		
		#direction = client data
		#tilt = client data
		#velocity.y = client data
		# if the fire fire_weapon()
		speed = clamp(speed,-max_speed,max_speed)
		direction += basis.z * speed * delta
		if speed == hold:
			if speed <= 300 and speed >= -300:
				speed = 0
			if speed > 0 and speed != 0:
				speed -= max_accel * delta
			elif speed < 0 and speed != 0:
				speed += max_accel * delta
		velocity += gravity * delta * basis.y * alive
		velocity.x = direction.x
		velocity.z = direction.z
		velocity = move_and_slide(velocity,Vector3(0,1,0))



