extends CharacterBody2D

class_name JugadorBase
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
@export var vidas: int=5
@export var velocidad: float=150.0
@export var daño: int=10
@onready var animacion=$AnimatedSprite2D
var ultima_dir="abajo"


func _physics_process(delta: float) -> void:
	var direccion = Input.get_vector("izquierda", "derecha", "arriba", "abajo")
	if direccion == Vector2.ZERO:
		velocity = Vector2.ZERO
		actualizar_animacion("parado")
	else:
		if abs(direccion.x) > abs(direccion.y):
			if direccion.x > 0:
				ultima_dir = "derecha"
			else:
				ultima_dir = "izquierda"
		else:
			if direccion.y > 0:
				ultima_dir = "abajo"
			else:
				ultima_dir = "arriba"
		velocity = direccion * velocidad
		actualizar_animacion("caminar")
	move_and_slide()




func actualizar_animacion(estado: String) -> void:
	animacion.play(estado+"_"+ultima_dir)#truquito para ahorrar ifs en esta func pero guarda con los nombrees en el animated sprite 
