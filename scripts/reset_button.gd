extends TouchScreenButton

signal reset_button(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", _on_pressed.bind(true))

#func button_pressed(value: bool):
	#connect("pressed", _on_pressed.bind(value))
	
func _on_pressed(value: bool):
	emit_signal("reset_button", value)
