extends Area2D
const velocidad=350
var direccion = Vector2.ZERO
var danio=10
func _physics_process(delta: float) -> void:
	position += velocidad*direccion*delta
func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		queue_free()
	elif body.has_method("recibir_daño"):
		body.recibir_daño(danio)
		queue_free()
