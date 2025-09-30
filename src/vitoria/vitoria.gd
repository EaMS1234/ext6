extends Node2D

@export var pontos = 69420

func _draw() -> void:
	$Label.text = "PONTOS: " + str(pontos)


func _on_reiniciar_pressed() -> void:
	match get_tree().current_scene.scene_file_path:
		"res://levels/01/firstLevel.tscn":
			var file = FileAccess.open("user://level_1.dat", FileAccess.READ_WRITE)
			if file.get_64() < pontos:
				file.store_64(pontos)
			file.close()
		
		"res://levels/02/secoundLevel.tscn":
			var file = FileAccess.open("user://level_2.dat", FileAccess.READ_WRITE)
			if file.get_64() < pontos:
				file.store_64(pontos)
			file.close()
		
		"res://levels/03/thirdLevel.tscn":
			var file = FileAccess.open("user://level_3.dat", FileAccess.READ_WRITE)
			if file.get_64() < pontos:
				file.store_64(pontos)
			file.close()
			
		"res://levels/04/fourthLevel.tscn":
			var file = FileAccess.open("user://level_4.dat", FileAccess.READ_WRITE)
			if file.get_64() < pontos:
				file.store_64(pontos)
			file.close()
		
		_:
			var file = FileAccess.open("user://level_5.dat", FileAccess.READ_WRITE)
			if file.get_64() < pontos:
				file.store_64(pontos)
			file.close()
	
	get_tree().reload_current_scene()

func _on_proximo_pressed() -> void:
	match get_tree().current_scene.scene_file_path:
		"res://levels/01/firstLevel.tscn":
			var file = FileAccess.open("user://level_1.dat", FileAccess.READ_WRITE)
			if file.get_64() < pontos:
				file.store_64(pontos)
			file.close()
			get_tree().change_scene_to_file("res://levels/02/secoundLevel.tscn")
		
		"res://levels/02/secoundLevel.tscn":
			var file = FileAccess.open("user://level_2.dat", FileAccess.READ_WRITE)
			if file.get_64() < pontos:
				file.store_64(pontos)
			file.close()
			get_tree().change_scene_to_file("res://levels/03/thirdLevel.tscn")
		
		"res://levels/03/thirdLevel.tscn":
			var file = FileAccess.open("user://level_3.dat", FileAccess.READ_WRITE)
			if file.get_64() < pontos:
				file.store_64(pontos)
			file.close()
			get_tree().change_scene_to_file("res://levels/04/fourthLevel.tscn")
			
		"res://levels/04/fourthLevel.tscn":
			var file = FileAccess.open("user://level_4.dat", FileAccess.READ_WRITE)
			if file.get_64() < pontos:
				file.store_64(pontos)
			file.close()
			get_tree().change_scene_to_file("res://levels/05/fifthLevel.tscn")
		
		_:
			var file = FileAccess.open("user://level_5.dat", FileAccess.READ_WRITE)
			if file.get_64() < pontos:
				file.store_64(pontos)
			file.close()
			get_tree().change_scene_to_file("res://final/endgame.tscn")

func _on_sair_pressed() -> void:
	pass
