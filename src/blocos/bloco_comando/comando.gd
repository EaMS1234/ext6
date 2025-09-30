extends StaticBody2D

signal clicado(path)

signal entrar(path)
signal sair()

@export var tipo = "r"
@export var pos_fila = 0

@export var associado = null

var dentro = false

var mouse_mov = false

var seletor = load("res://blocos/seletor_loop/seletor_loop.tscn")

func _draw() -> void:
	match tipo:
		"r":
			pass
		
		"l":
			$Seta.flip_h = true
		
		"u":
			$Seta.rotation_degrees = 270
		
		"d":
			$Seta.rotation_degrees = 90
			
		"end":
			$Seta.texture = load("res://blocos/end.png")
		
		_:
			$Seta.texture = load("res://blocos/loop.png")
			var texto = Label.new()
			self.add_child(texto)
			texto.add_to_group("label_loop")
			# texto.position.y -= 0
			# texto.position.x -= 0
			texto.scale *= 1
			texto.text = tipo
			


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_mov = true
	
	else:
		mouse_mov = false

func _process(_delta: float) -> void:
	var count = get_tree().get_node_count_in_group("input_loop")
	
	if Input.is_action_pressed("mouse_click") and dentro and mouse_mov and count == 0:
		clicado.emit(get_path())
	
	elif tipo.is_valid_int() and Input.is_action_just_released("mouse_click") and dentro and not mouse_mov:
		var sel = seletor.instantiate()
		sel.val_atual = int(tipo)
		self.add_child(sel)
		sel.z_index = 55
		sel.position.x -= 24
		sel.novo_valor.connect(alterar_tipo)

func alterar_tipo(val):
	tipo = str(val)
	
	for n in get_children():
		if n is Label:
			n.text = tipo
	
func _on_color_rect_mouse_entered() -> void:
	dentro = true
	entrar.emit(get_path())
	
	if associado != null:
		associado.get_child(0).color = Color(1.0, 1.0, 1.0, 0.125)
		
	$BG.color = Color(1.0, 1.0, 1.0, 0.125)

func _on_color_rect_mouse_exited() -> void:
	dentro = false
	sair.emit()
	
	if associado != null:
		associado.get_child(0).color = Color(1.0, 1.0, 1.0, 0.125)

	$BG.color = Color(1.0, 1.0, 1.0, 0.0)
