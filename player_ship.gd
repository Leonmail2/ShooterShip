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
var health_regen_rate = 1.5 #in secondss
var precent_multiplier = 100/400
export var max_health = 400

var weapon_cooldown = true
var last_side = "left"
export var damage = -50

var team = "red"
export var player_name = "Leonmail"
# Called when the node enters the scene tree for the first time.
func _ready():
	$playerCamera.current = true
	var node
	if team == "red":
		node = preload("res://assets/ShipRedInterior.tscn")
		$gunship/mesh.add_child(node.instance())
	if team == "blue":
		node = preload("res://assets/ShipBlueInterior.tscn")
		$gunship/mesh.add_child(node.instance())
		
func fire_weapon():
	if weapon_cooldown == true:
		weapon_cooldown = false
		$CooldownTimer.start(0.3)
		print("fire!")
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
					var name = collision.get_parent().name
					get_parent().send_hit(name)

func _on_CooldownTimer_timeout():
	weapon_cooldown = true

func hit(player):
	add_health(damage)
	if health == 0:
		death(player)

func add_health(new):
	health += new
	health = clamp(health,0,max_health)
	var health_precent = precent_multiplier * health
	$HUD.update_health(health_precent)

func roll_camera(degrees):
	$gunship.rotation = Vector3(0,0,deg2rad(clamp(degrees,-22,22)))

func speed_effects():
	$playerCamera.fov = 60 + abs(speed/800)

func death(killer_name):
	$gunship.hide()
	$FlameParticles.emitting = true
	$SmokeParticles.emitting = true
	$deathCamera.current = true
	velocity = Vector3(0,0,0)
	alive = 0
	speed = 0
	direction = Vector3(0,0,0)
	$HUD.killed_by(killer_name)
	

func _input(event):
	if event is InputEventMouseMotion:
		self.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		tilt += -event.relative.x * 0.065

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	roll_camera(tilt)
	speed_effects()
	if tilt == 0:
		pass
	else:
		if tilt > 0:
			tilt -= 0.1 * abs(tilt/2)
		elif tilt < 0:
			tilt += 0.1 * abs(tilt/2)

func _physics_process(delta):
	direction = Vector3(0,0,0)
	
	var basis = $playerCamera.get_global_transform().basis
	var hold = speed
	if alive == 1:
		if Input.is_action_pressed("ui_up"):
			speed -= max_accel * delta
		if Input.is_action_pressed("ui_down"):
			speed += max_accel * delta
		if Input.is_action_pressed("ui_left"):
			direction += -basis.x * strafe_speed
			tilt += 5
		if Input.is_action_pressed("ui_right"):
			direction += basis.x * strafe_speed
			tilt -= 5
		if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
			velocity.y += 20
		if Input.is_mouse_button_pressed(1):
			fire_weapon()
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



