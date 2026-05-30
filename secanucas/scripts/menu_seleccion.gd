extends Control

var fideo_escena=preload("res://Scenes/fideo.tscn")
var paredes_escena=preload("res://Scenes/Paredes.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BotonFideo.pressed.connect(_on_fideo_selected)
	$BotonParedes.pressed.connect(_on_paredes_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
func _on_fideo_selected() -> void:
	Global.jugador_seleccionado = fideo_escena
	arrancar_nivel()

func _on_paredes_selected() -> void:
	Global.jugador_seleccionado = paredes_escena
	arrancar_nivel()

func arrancar_nivel() -> void:
	get_tree().change_scene_to_file("res://Scenes/nivel_1.tscn")
