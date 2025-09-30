extends Control


func _ready() -> void:
	var file
	file = FileAccess.open("user://level_1.dat", FileAccess.WRITE)
	file.close()
	file = FileAccess.open("user://level_2.dat", FileAccess.WRITE)
	file.close()
	file = FileAccess.open("user://level_3.dat", FileAccess.WRITE)
	file.close()
	file = FileAccess.open("user://level_4.dat", FileAccess.WRITE)
	file.close()
	file = FileAccess.open("user://level_5.dat", FileAccess.WRITE)
	file.close()

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/01/firstLevel.tscn")
