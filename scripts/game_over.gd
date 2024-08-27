extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	$".".visible = false
	
# REMAINING: A WAY TO TRIGGER THE PAUSE FUNCTION TO MAKE IT AS GAME OVER 
# RESUME: WILL BE THE ADS
# ON RESTART: RESTART THE GAME
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	$".".visible = true
	get_tree().paused = true 
	$AnimationPlayer.play("blur")
	


func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()


func _on_ads_pressed():
	resume()
