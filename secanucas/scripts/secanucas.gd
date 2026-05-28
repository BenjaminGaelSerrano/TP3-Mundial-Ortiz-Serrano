extends CharacterBody2D
class_name JugadorBase
@export var escenapañuelo:PackedScene
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
var secando: bool=false
var usos_maximos_p_equipado: int=0
var tiempo_secado_p_equipado: float=0.0
var usos_actuales: int=0

func _ready() -> void:
	add_to_group("jugadores")
	if escenapañuelo:
		equipar_pañuelo(escenapañuelo)
	
func equipar_pañuelo(nueva_escena: PackedScene) -> void:
	escenapañuelo = nueva_escena
	var pañueloaux = escenapañuelo.instantiate()
	usos_maximos_p_equipado = pañueloaux.usos_maximos
	tiempo_secado_p_equipado = pañueloaux.tiempo_secado
	pañueloaux.queue_free()
	usos_actuales = usos_maximos_p_equipado
func _physics_process(delta: float) -> void:
	if atacando or secando:
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
	if event.is_action_pressed("atacar") and not atacando and not secando:
		if usos_actuales>0:
			
			atacar()
		else:
			print("paaaañuelo empapado de trnspiraacion del chiqui secaaaalo")
	if event.is_action_pressed("secar"):
		if  not secando and not atacando:
			secar_pañuelo()

func atacar() -> void:
	atacando=true
	velocity=Vector2.ZERO
	animacion.play("atacar_"+ultima_dir)
	var pañueloactual=escenapañuelo.instantiate()
	pañueloactual.global_position=global_position
	pañueloactual.daño_jugador = daño
	pañueloactual.danioJugador = float(daño)
	pañueloactual.jugador_origen=self
	if ultima_dir == "arriba":
		pañueloactual.direction=Vector2(0, -1)
	elif ultima_dir == "abajo":
		pañueloactual.direction=Vector2(0, 1)
	elif ultima_dir == "izquierda":
		pañueloactual.direction=Vector2(-1, 0)
	elif ultima_dir == "derecha":
		pañueloactual.direction=Vector2(1, 0)
	get_parent().add_child(pañueloactual)
	await animacion.animation_finished
	atacando = false

func mojar_panuelo() -> void:
	usos_actuales-=1
	if usos_actuales<=0:
		print("se mojo el pañuelo, se lleno de lagrimas mde gente que le duele qatar, estaa locuraaa!!")
func actualizar_animacion(estado: String) -> void:
	animacion.play(estado+"_"+ultima_dir)#truquito para ahorrar ifs en esta func pero guarda con los nombrees en el animated sprite 

func secar_pañuelo() -> void:
	secando=true
	velocity=Vector2.ZERO
	animacion.play("secar")
	await get_tree().create_timer(tiempo_secado_p_equipado).timeout
	usos_actuales = usos_maximos_p_equipado
	secando=false
	print("el chiqui te espera secanucas")
