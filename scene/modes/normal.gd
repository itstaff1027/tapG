extends Node2D

var buttons = []
var button_instance: PackedScene = load("res://scene/touch_screen_button.tscn")

func _ready():
	
	for i in range(10):
		add_child(button_instance.instantiate())
		buttons.append(button_instance)
		
	var selected_indicies = get_random_indices(3, buttons.size())
	
	var container = $Control/UserInteractions/MarginContainer/GridContainer
	var children = container.get_children()
	
	for i in range(children.size()):
		var child = children[i]
			
		if i in selected_indicies:
			child.set_animation_state("on")
			child.pressed.connect(
				func ():
					child.on_pressed("on", false)
			)
		else:
			child.set_animation_state("off")
			child.pressed.connect(
				func ():
					child.on_pressed("off", false)
			)
		
			
func get_random_indices(count: int, max_value: int) -> Array:
	var indices = []
	while indices.size() < count:
		var rand_index = randi() % max_value
		if rand_index not in indices:
			indices.append(rand_index)
	return indices

