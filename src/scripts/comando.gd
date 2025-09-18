extends StaticBody2D

signal clicado(path)

@export var tipo = "r"

var dentro

func _draw() -> void:
	match tipo:
		"l":
			$Seta.flip_h = true
		
		"u":
			$Seta.rotation_degrees = 270
		
		"d":
			$Seta.rotation_degrees = 90
			


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("mouse_click") and dentro:
		clicado.emit(get_path())


func _on_color_rect_mouse_entered() -> void:
	dentro = true
	$BG.color = Color(1.0, 1.0, 1.0, 0.125)

func _on_color_rect_mouse_exited() -> void:
	dentro = false
	$BG.color = Color(1.0, 1.0, 1.0, 0.0)
