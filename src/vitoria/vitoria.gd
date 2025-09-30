extends Node2D

@export var pontos = 69420

func _draw() -> void:
	$Label.text = "PONTOS: " + str(pontos)
