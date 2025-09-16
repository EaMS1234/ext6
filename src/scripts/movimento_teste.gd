extends Node2D

var x_inicio
var y_inicio

func _ready() -> void:
	x_inicio = $CharacterBody2D.position.x
	y_inicio = $CharacterBody2D.position.y

func _on_control_mover(dir: Variant) -> void:
	var novo = Sprite2D.new()
	novo.add_to_group("setas")
	self.add_child(novo)
	novo.position = $CharacterBody2D.position
	novo.texture = load("res://assets/sprites/arrow.png")
	
	match dir:
		"l":
			$CharacterBody2D.move_local_x(50)
		
		"r":
			novo.flip_h = true
			$CharacterBody2D.move_local_x(-50)
		
		"d":
			novo.rotation_degrees = 90
			$CharacterBody2D.move_local_y(50)
		
		"u":
			novo.rotation_degrees = 270
			$CharacterBody2D.move_local_y(-50)

func _on_control_executar() -> void:
	get_tree().call_group("setas", "queue_free")
	$CharacterBody2D.position.x = x_inicio
	$CharacterBody2D.position.y = y_inicio
