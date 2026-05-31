extends CanvasLayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS 
	hide()
	
func activar_game_ganado() -> void:
	show()
	get_tree().paused = true
	
func _on_button_2_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
