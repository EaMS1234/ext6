extends Node2D

var pontos = 0

func _ready() -> void:
	var l1 = FileAccess.open("user://level_1.dat", FileAccess.READ)
	var l2 = FileAccess.open("user://level_2.dat", FileAccess.READ)
	var l3 = FileAccess.open("user://level_3.dat", FileAccess.READ)
	var l4 = FileAccess.open("user://level_4.dat", FileAccess.READ)
	var l5 = FileAccess.open("user://level_5.dat", FileAccess.READ)

	pontos += l1.get_64()
	pontos += l2.get_64()
	pontos += l3.get_64()
	pontos += l4.get_64()
	pontos += l5.get_64()
	
	$Pontos.text = str(pontos)
