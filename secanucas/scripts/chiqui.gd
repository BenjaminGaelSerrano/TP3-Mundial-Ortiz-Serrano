extends CharacterBody2D
enum estado {CAMINAR,QUIETO,PERSEGUIR}
var estadoTapia= estado.CAMINAR
const velocidad=180
const vidaMax=300
var vidaActual=300
var direccion= Vector2.RIGHT
var timer
var colorVigilanciaNormal=Color(0, 0.5, 1, 0.4)
var colorVigilanciaAlerta=Color(1, 0, 0, 0.4)
var jugador : Node2D
var choripanCooldown=0.0
const Choripan=preload("res://Scenes/chori.tscn")
@onready var animacion= $Animacion
@onready var detectorIzquierda= $DetectorDeObstaculosIzquierda
@onready var detectorCentro= $DetectorDeObstaculosFrente
@onready var detectorDerecha= $DetectorDeObstaculosDerecha
@onready var poligono= $VigilanciaArea/FormaVigilancia
@onready var barraVida= $BarraVida
@onready var nuca= $HitboxArea/Hitbox
func _ready() -> void:
	timer=randf_range(3.5, 12.0)
	poligono.color= colorVigilanciaNormal
	barraVida.max_value=vidaMax
	barraVida.value=vidaActual
func _physics_process(delta: float) -> void:
	poligono.rotation = direccion.angle()-PI/2
	nuca.position=-direccion * 16
	if(estadoTapia==estado.CAMINAR):
		esquivarParedes()
		velocity= direccion*velocidad
		move_and_slide()
		animacionCaminar()
		timer-=delta
		if timer<=0.0:
			estadoTapia=estado.QUIETO
			timer=2.0
			direccion=-direccion
	elif estadoTapia==estado.QUIETO :
		velocity=Vector2.ZERO
		animacionQuieto()
		timer-=delta
		if timer<=0:
			estadoTapia=estado.CAMINAR
			timer=randf_range(3.5, 12.0)
	elif estadoTapia == estado.PERSEGUIR:
		if jugador!= null:
			direccion=(jugador.global_position - global_position).normalized()
			velocity= direccion * (velocidad*1.5)
			move_and_slide()
			animacionCaminar()
			choripanCooldown-=delta
			if choripanCooldown<=0:
				tirarChori()
				choripanCooldown= 1.0		
func tirarChori():
	var chori = Choripan.instantiate()
	chori.global_position = global_position 
	chori.direccion = direccion 
	get_parent().add_child(chori)
	if direccion == Vector2.UP :
		animacion.play("AtacarAtras")
	elif direccion == Vector2.DOWN :
		animacion.play("AtacarAdelante")
	elif direccion == Vector2.RIGHT :
		animacion.play("AtacarDerecha")
	elif direccion == Vector2.LEFT :
		animacion.play("AtacarIzquierda")
func morir():
	animacion.play("Muerte")
	await animacion.animation_finished
	queue_free()	
func animacionCaminar():
	if direccion == Vector2.UP :
		animacion.play("CaminarAtras")
	elif direccion == Vector2.DOWN :
		animacion.play("CaminarAdelante")
	elif direccion == Vector2.RIGHT :
		animacion.play("CaminarDerecha")
	elif direccion == Vector2.LEFT :
		animacion.play("CaminarIzquierda")
func animacionQuieto():
	if direccion == Vector2.UP :
		animacion.play("DadoVueltaParado")
	elif direccion == Vector2.DOWN :
		animacion.play("NormalParado")
	elif direccion == Vector2.RIGHT :
		animacion.play("DerechaParado")
	elif direccion == Vector2.LEFT :
		animacion.play("IzquierdaParado")						
func esquivarParedes():
	var largoRayCast=25
	detectorCentro.target_position = direccion*largoRayCast
	detectorIzquierda.target_position= Vector2(direccion.y, -direccion.x).sign()*largoRayCast
	detectorDerecha.target_position= Vector2(-direccion.y, direccion.x).sign()*largoRayCast
	detectorCentro.force_raycast_update()
	detectorIzquierda.force_raycast_update()
	detectorDerecha.force_raycast_update()
	if detectorCentro.is_colliding():
		if not detectorDerecha.is_colliding():
			direccion = Vector2(-direccion.y, direccion.x).sign()								
		elif not detectorIzquierda.is_colliding():
			direccion = Vector2(direccion.y, -direccion.x).sign()
		else :
			direccion=-direccion.sign()	
func _on_vigilancia_area_body_entered(body: Node2D) -> void:
	if body.name == "Jugador": 
		poligono.color = colorVigilanciaAlerta
		estadoTapia=estado.PERSEGUIR
		jugador=body
func _on_vigilancia_area_body_exited(body: Node2D) -> void:
	if body.name == "Jugador":
		poligono.color = colorVigilanciaNormal
		estadoTapia=estado.PERSEGUIR
		jugador=null
func recinirdanioSecado(danio: float) -> void:
	if nuca.is_in_group("pañuelos"):
		vidaActual=vidaActual-danio
		barraVida.value = vidaActual
		if vidaActual<=0:
			morir()
		
