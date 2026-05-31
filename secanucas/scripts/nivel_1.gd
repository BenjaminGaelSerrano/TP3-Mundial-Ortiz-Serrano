extends Node2D
var escena_caja_item=preload("res://Scenes/item_pañuelo2.tscn")
var escena_panuelo_premium = preload("res://Scenes/pañuelopro.tscn")
func _ready() -> void:
	var nuevo_jugador=Global.jugador_seleccionado.instantiate()
	nuevo_jugador.global_position=Vector2(85, 102)
	add_child(nuevo_jugador)
	print("secanucas pronto")
	nuevo_jugador.vida_cambiada.connect($HUD.actualizar_vidas)
	$HUD.actualizar_vidas(nuevo_jugador.vidas)
	$Timerpanuelo.timeout.connect(_on_timer_panuelo_timeout)
func _on_timer_panuelo_timeout() -> void:
	var nuevo_item = escena_caja_item.instantiate()
	nuevo_item.pañuelo_que_contiene=escena_panuelo_premium
	nuevo_item.global_position = $Spawn.global_position 
	add_child(nuevo_item)
