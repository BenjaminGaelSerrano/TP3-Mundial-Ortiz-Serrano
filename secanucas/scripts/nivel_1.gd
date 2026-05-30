extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.jugador_seleccionado==null:
		Global.jugador_seleccionado=preload("res://Scenes/fideo.tscn")#para cuando corremos con el f6 laa esena actuañ
	var nuevo_jugador=Global.jugador_seleccionado.instantiate()
	nuevo_jugador.global_position=Vector2(85, 102)
	add_child(nuevo_jugador)
	print("secanucas pronto")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
