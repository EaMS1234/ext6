extends Node2D

@export var pontos = 69420

func _draw() -> void:
	$Label.text = "PONTOS: " + str(pontos)

func _on_reiniciar_pressed() -> void:
	get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)

func _on_proximo_pressed() -> void:
	match get_tree().current_scene.scene_file_path:
		"res://levels/01/firstLevel.tscn":
			get_tree().change_scene_to_file("res://levels/02/secoundLevel.tscn")
		
		"res://levels/02/secondLevel.tscn":
			get_tree().change_scene_to_file("res://levels/03/thirdLevel.tscn")
		
		"res://levels/03/thirdLevel.tscn":
			get_tree().change_scene_to_file("res://levels/04/fourthLevel.tscn")
			
		"res://levels/04/fourthLevel.tscn":
			get_tree().change_scene_to_file("res://levels/05/fifthLevel.tscn")
		
		_:
			_on_reiniciar_pressed()

func _on_sair_pressed() -> void:
	pass
