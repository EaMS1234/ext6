extends Node2D

var moveSpeed = 30
var size = 0
var opacity = 100
func _process(delta: float) -> void:
	moveSpeed = 30 - (scale.x * 10)
	position.y -= moveSpeed * delta
	if position.y < 20:
		despawn()

func despawn():
	modulate.a -= 0.005
	if modulate.a <= 0:
		queue_free()
