extends Node2D
var escena_caja_item=preload("res://Scenes/item_pañuelo2.tscn")
var escena_panuelo_premium = preload("res://Scenes/pañuelopro.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.jugador_seleccionado==null:
		Global.jugador_seleccionado=preload("res://Scenes/fideo.tscn")#para cuando corremos con el f6 laa esena actuañ
	var nuevo_jugador=Global.jugador_seleccionado.instantiate()
	nuevo_jugador.global_position=Vector2(85, 102)
	add_child(nuevo_jugador)
	print("secanucas pronto")
	nuevo_jugador.vida_cambiada.connect($HUD.actualizar_vidas)
	$HUD.actualizar_vidas(nuevo_jugador.vidas)
	$Timerpanuelo.timeout.connect(_on_timer_panuelo_timeout)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_panuelo_timeout() -> void:
	var nuevo_item = escena_caja_item.instantiate()
	nuevo_item.pañuelo_que_contiene=escena_panuelo_premium
	nuevo_item.global_position = $Spawn.global_position 
	add_child(nuevo_item)
