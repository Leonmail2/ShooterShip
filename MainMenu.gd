extends Control
signal start_server
signal join_server

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func open_UI():
	show()

func close_UI():
	hide()

func close_title_screen():
	$titleScreen.hide()
	
func open_title_screen():
	$titleScreen.show()

func display_text(text):
	$textScreen.show()
	$textScreen/CenterContainer/Label.text = str(text)

func hide_display_text():
	$textScreen.hide()

func _on_CreateServer_button_up():
	emit_signal("start_server")

func _on_JoinGame_button_up():
	emit_signal("join_server")
