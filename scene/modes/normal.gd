extends Node2D

var selected_indicies : Array = []
var index : Array = []
var array_children : Array = []

var pressed_count : int = 0
var rounds : int = 0
var current_round : int = 5
@export var number_buttons : int = 3

var is_reset : bool = false

func _ready():
	# must connect to the left and right reset button everytime its clicked
	var resetButton = $Control/UserInteractions/MarginContainer/HBoxContainer.get_children()
	
	for i in range(resetButton.size()):
		var buttons = resetButton[i]
		
		buttons.connect("reset_button", _on_reset_buttons.bind(resetButton))
	
	#connect("pressed", Callable(self, "_on_reset_button"))
	play()
	

func _process(_delta):
	if is_reset == true:
		if rounds == current_round:
			print("next round")
			rounds = 0
		else:
			if index.size() == selected_indicies.size():
				#disconnect children from previous connection
				disconnect_children(array_children)
				#reset arrays
				index =  []
				selected_indicies = []
				play()
	

func play():
	rounds += 1
	
	var children = $Control/UserInteractions/MarginContainer/GridContainer.get_children()
	
	selected_indicies = get_random_indices(3, children.size())
	
	for i in range(children.size()):
		var child = children[i]
			
		if i in selected_indicies:
			child.set_animation_state("on")
			child.on_clicked("on", false)
			#change signal name to proper name
			child.connect("button_pressed", _on_value_ready.bind(children))
			#child.pressed.connect(
				#func () -> void:
					#child.on_pressed("on", false)
					#index.append(i)
					#if index.size() == selected_indicies.size():
						#finished(children)
						#index.clear()
			#)
		else:
			child.set_animation_state("off")
			#child.pressed.connect(
				#func () -> void:
					#child.on_pressed("off", false)
			#)
			
func gameover():
	print("gameover")

func _on_reset_buttons(value: bool, children: Array):
	if pressed_count == index.size():
		print(pressed_count)
		print(value)
		print("reset button")
	else:
		print("gameover")
	
	

# Disconnect Previous Connection
func disconnect_children(children: Array):
	for i in range(children.size()):
		var child = children[i]
		child.disconnect("button_pressed", Callable(self, "_on_value_ready"))
		
# Setting Values to Variables in each click
func _on_value_ready(value: int, children: Array):
	array_children = children
	pressed_count += value
	index.append(value)

func get_random_indices(count: int, max_value: int) -> Array:
	var indices = []
	indices.clear()
	while indices.size() < count:
		var rand_index = randi() % max_value
		if rand_index not in indices:
			indices.append(rand_index)
	return indices

# Old Process
#func finished(children: Array):
	#
	#if index.size() == selected_indicies.size():
		##disconnect children from previous connection
		#disconnect_children(children)
		##reset arrays
		#index =  []
		#selected_indicies = []
		#play()
		#
		#
