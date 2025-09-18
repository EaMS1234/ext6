extends StaticBody2D

@export var tipo = "r"

func _draw() -> void:
	match tipo:
		"l":
			$Seta.flip_h = true
		
		"u":
			$Seta.rotation_degrees = 270
		
		"d":
			$Seta.rotation_degrees = 90
			


func _on_color_rect_mouse_entered() -> void:
	pass # Replace with function body.


func _on_color_rect_mouse_exited() -> void:
	pass # Replace with function body.
