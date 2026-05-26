extends CharacterBody2D
class_name JugadorBase
const pañuelo= preload("res://Scenes/pañuelo_1.tscn")
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

signal vida_cambiada(nueva_vida: int)
@export var vida_maxima: int=5
@onready var vidas: int=vida_maxima
@export var velocidad: float=150.0
@export var daño: int=10
@onready var animacion=$AnimatedSprite2D
var ultima_dir="abajo"
var atacando: bool=false
func _ready() -> void:
	add_to_group("jugadores")
func _physics_process(delta: float) -> void:
	if atacando:
		move_and_slide()
		return
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
func recibir_daño(dañorecibido: int) -> void:
	vidas-=dañorecibido
	vida_cambiada.emit(vidas)
	if vidas<=0:
		#por ahora no hay escena de muerte
		#get_tree().change_scene_to_file("res://escenas/muerte.tscn")
		queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("atacar") and not atacando:
		atacar()

func atacar() -> void:
	atacando=true
	velocity=Vector2.ZERO
	animacion.play("atacar_"+ultima_dir)
	var proyectil=pañuelo.instantiate()
	proyectil.global_position=global_position
	proyectil.danioJugador=float(daño)
	if ultima_dir == "arriba":
		proyectil.direction=Vector2(0, -1)
	elif ultima_dir == "abajo":
		proyectil.direction=Vector2(0, 1)
	elif ultima_dir == "izquierda":
		proyectil.direction=Vector2(-1, 0)
	elif ultima_dir == "derecha":
		proyectil.direction=Vector2(1, 0)
	get_parent().add_child(proyectil)
	await animacion.animation_finished
	atacando = false
func actualizar_animacion(estado: String) -> void:
	animacion.play(estado+"_"+ultima_dir)#truquito para ahorrar ifs en esta func pero guarda con los nombrees en el animated sprite 
