extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var username = "Leonmail"
export var server_ip = "127.0.0.1"
export var server_port = 5745

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_UI_start_server():
	$Server.init_server(server_ip,server_port)
	

func _on_UI_join_server(ip,port):
	$Client.connect_to_server(ip,port)

func connect_to_self_server():
	pass
