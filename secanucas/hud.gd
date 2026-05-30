extends CanvasLayer

@onready var contenedor=$HBoxContainer


func actualizar_vidas(vidas_actuales: int) -> void:
	var corazones=contenedor.get_children()
	for i in range(corazones.size()):
		if i<vidas_actuales:
			corazones[i].show()
		else:
			corazones[i].hide()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
