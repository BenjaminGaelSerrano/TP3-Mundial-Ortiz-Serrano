extends Area2D
const velocidad=200
var direccion = Vector2.ZERO

func _physics_process(delta: float) -> void:
	position = velocidad*direccion*delta
func ImpactoJugador(body: Node2D) -> void:
	## hay que terminar primero el jugador que lo esta haciendo Santii
	queue_free()
	if body is TileMap:
		queue_free()
		
