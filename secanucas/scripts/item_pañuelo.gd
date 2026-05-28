extends Area2D

@export var pañuelo_que_contiene: PackedScene 

func _ready() -> void:
	#chiche
	var tween=create_tween().set_loops()
	tween.tween_property(self, "position:y", position.y - 5, 1.0).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position:y", position.y + 5, 1.0).set_trans(Tween.TRANS_SINE)

func _on_body_entered(body: Node2D) -> void:
	if body is JugadorBase:
		if pañuelo_que_contiene:
			body.equipar_pañuelo(pañuelo_que_contiene)
			queue_free()
		else:
			print("santi solari(error)")
