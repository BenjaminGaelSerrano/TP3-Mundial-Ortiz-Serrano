extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()#swconder al empezar el juego



func _input(event: InputEvent) -> void:

	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		activar_pausa()
		
func activar_pausa() -> void:
	# Invertir el estado para poder pausar y despausars
	get_tree().paused = !get_tree().paused
	

	if get_tree().paused:
		show()
	else:
		hide()


func _on_button_2_pressed() -> void:
	get_tree().paused = false 
	get_tree().reload_current_scene()


func _on_button_pressed() -> void:
	activar_pausa()
