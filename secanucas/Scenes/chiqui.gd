extends CharacterBody2D
enum estado {CAMINAR,QUIETO}
var estadoTapia= estado.CAMINAR
const velocidad=80
var direccion= Vector2.RIGHT
var timer=8.0
@onready var animacion= $Animacion
@onready var detectorIzquierda= $DetectorDeObstaculosIzquierda
@onready var detectorCentro= $DetectorDeObstaculosFrente
@onready var detectorDerecha= $DetectorDeObstaculosDerecha
func _physics_process(delta: float) -> void:
	if(estadoTapia==estado.CAMINAR):
		esquivarParedes()
		velocity= direccion*velocidad
		move_and_slide()
		animacionCaminar()
		timer-=delta
		if timer<=0.0:
			estadoTapia=estado.QUIETO
			timer=3.0
			direccion= -direccion
	elif estadoTapia==estado.QUIETO :
		velocity=Vector2.ZERO
		animacionQuieto() 
		timer-=delta
		if timer<=0:
			estadoTapia=estado.CAMINAR
			timer=8.0
			moverseAlAzar()
func moverseAlAzar():
	var movimientos= [Vector2.RIGHT,Vector2.DOWN,Vector2.LEFT,Vector2.UP]
	direccion = movimientos.pick_random()			
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
	detectorCentro.target_position = direccion*40
	detectorIzquierda.target_position= direccion.rotated(deg_to_rad(-90))*40
	detectorDerecha.target_position= direccion.rotated(deg_to_rad(90))*40
	detectorCentro.force_raycast_update()
	detectorIzquierda.force_raycast_update()
	detectorDerecha.force_raycast_update()
	if detectorCentro.is_colliding():
		direccion = direccion.rotated(deg_to_rad(90)).round()
	elif detectorIzquierda.is_colliding():
		direccion = direccion.rotated(deg_to_rad(90)).round()								
	elif detectorDerecha.is_colliding():
		direccion = direccion.rotated(deg_to_rad(-90)).round()
