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
		
		buttons.connect("reset_button", _on_reset_buttons)
	
	play()
	

func _process(_delta):
	if rounds == current_round:
		number_buttons += 1
		rounds = 0
	

func play():
	rounds += 1
	
	# The limit buttons are only 10 so we intended to make a condition if the player 
	# reach 10 buttons incrementation we will set the number only at 10
	if number_buttons == 10:
		number_buttons = 10
	
	var children = $Control/UserInteractions/MarginContainer/GridContainer.get_children()
	
	selected_indicies = get_random_indices(number_buttons, children.size())
	
	for i in range(children.size()):
		var child = children[i]
			
		if i in selected_indicies:
			child.set_animation_state("on")
			child.on_clicked("on", false)
			
			child.connect("button_pressed", _on_value_ready.bind(children, child.get_index()))
		else:
			child.set_animation_state("off")
			child.on_clicked("off", false)
			child.connect("button_pressed", _on_value_ready.bind(children, child.get_index()))
			
func gameover():
	# instead of transfering to different scene that cause a lot of effort to retain the progress
	# create a game over modal with animation instead and do the twicks to retain the progress
	print("gameover")
	

func _on_reset_buttons(value: bool):
	if pressed_count == int(selected_indicies.size()):
		pressed_count = 0
		if index.size() == selected_indicies.size():
			#disconnect children from previous connection
			disconnect_children(selected_indicies)
			#reset arrays
			index.clear()
			selected_indicies.clear()
			play()
	else:
		print("gameover")
	
	
	
# FIXED: BUG WHEN THE BUTTON IS CLICKED AGAIN IT WILL CAUSED A BUG AND THE INDICIES WILL INCREMENT OR SOMETHING 
# MUST BE CHECK IF THE CLICKED BUTTON IS ALREADY CLICKED AND DO NOT ADD UP AGAIN IN ARRAY

# Disconnect Previous Connection
func disconnect_children(indicies: Array):
	var children = $Control/UserInteractions/MarginContainer/GridContainer.get_children()
	for i in range(children.size()):
		var child = children[i]
		child.disconnect("button_pressed", Callable(self, "_on_value_ready"))
		
# Setting Values to Variables in each click
func _on_value_ready(value: int, children: Array, child_index: int):
	array_children = children
	if child_index in selected_indicies:
		print(child_index)
		if child_index not in index:
			pressed_count += value
			index.append(child_index)
	else:
		print(child_index)
		gameover()

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
