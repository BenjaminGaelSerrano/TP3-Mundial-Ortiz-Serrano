extends Area2D
@export var velocidad: float=400.0
@export var distancia_maxima: float=200.0
@export var multiplicador: float= 1.0
@export var usos_maximos: int= 10
var danioJugador: float= 0.0
@export var tiempo_secado: float= 2.0
var direction: Vector2= Vector2.ZERO
var distancia_recorrida: float= 0.0
func _process(delta: float) -> void:	
	var paso= direction * velocidad * delta
	position += paso 
	rotation=direction.angle()
	distancia_recorrida += paso.length()
	if distancia_recorrida >= distancia_maxima:
		queue_free()
func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		queue_free()
func calcularDanio():
	return danioJugador * multiplicador
func _on_area_entered(area: Area2D) -> void:
	if area.name == "HitboxArea": 
		var enemigo = area.get_parent()
		if enemigo.has_method("recibirdanioSecado"):
			enemigo.recibirdanioSecado(calcularDanio())
			queue_free()
