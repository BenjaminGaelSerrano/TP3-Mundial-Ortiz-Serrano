extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/jugar.pressed.connect(_on_jugar_pressed)

func _on_jugar_pressed() -> void:
	# Transición directa a la pantalla de selección que vamos a personalizar
	get_tree().change_scene_to_file("res://Scenes/menu_seleccion.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
