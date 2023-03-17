extends Node2D

onready var player = $YSort/Player
onready var resetTimer = $ResetTimer

# if esc is pressed, exit the game
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_Player_tree_exited():
	resetTimer.start()

func _on_ResetTimer_timeout():
	get_tree().reload_current_scene()
