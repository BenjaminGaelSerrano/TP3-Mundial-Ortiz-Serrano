extends Area2D
@export var velocidad: float=400.0
@export var distancia_maxima: float=200.0
@export var multiplicador: float= 1.0
@export var usos_maximos: int= 5
var danioJugador: float= 0.0
@export var tiempo_secado: float= 2.0
var daño_jugador: int= 0
var direction: Vector2= Vector2.ZERO
var distancia_recorrida: float= 0.0
var jugador_origen
func _ready() -> void:
	pass
func _process(delta: float) -> void:	
	var paso= direction * velocidad * delta
	position+=paso 
	rotation=direction.angle()
	distancia_recorrida+=paso.length()
	if distancia_recorrida>=distancia_maxima:
		queue_free()
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("recibir_daño"):
		var danio_final = int(daño_jugador * multiplicador)
		body.recibir_daño(danio_final)
		
	
	if body is TileMapLayer or body.has_method("recibir_daño"):
		queue_free()

func calcularDanio():
	if daño_jugador != 0:
		return float(daño_jugador) * multiplicador
	return danioJugador * multiplicador
func _on_area_entered(area: Area2D) -> void:
	if area.name == "HitboxArea":
		var enemigo = area.get_parent()
		if enemigo.has_method("recibir_daño"):
			enemigo.recibir_daño(calcularDanio())
			if jugador_origen != null and jugador_origen.has_method("mojar_panuelo"):
				jugador_origen.mojar_panuelo()
			queue_free()
