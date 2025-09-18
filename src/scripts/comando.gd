extends StaticBody2D

signal clicado(path)

signal entrar(path)
signal sair()

@export var tipo = "r"
@export var pos_fila = 0

@export var associado = null

var dentro

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
			$Seta.texture = load("res://assets/sprites/end.png")
		
		_:
			$Seta.texture = load("res://assets/sprites/loop.png")
			var texto = Label.new()
			self.add_child(texto)
			texto.position.y -= 0
			texto.position.x -= 0
			texto.scale *= 0.5
			texto.text = tipo
			


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("mouse_click") and dentro:
		clicado.emit(get_path())


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
