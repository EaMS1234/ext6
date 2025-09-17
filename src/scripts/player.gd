extends Node2D
var grid_controller
var grid_pos = Vector2()
signal updatePlayerPosition(oldPosition, newPosition)

func setup(pos: Vector2, controller):
	grid_controller = controller
	grid_pos = pos
	grid_controller.set_cell(grid_pos, self)
	position = grid_pos * 16


func move(dir):
	var old_pos = grid_pos
	#Direita
	if dir == 0:
		grid_pos.x+=1
	elif dir == 1:
		grid_pos.y+=1
	elif dir == 2:
		grid_pos.x-=1
	elif dir == 3:
		grid_pos.y-=1
	emit_signal("updatePlayerPosition", old_pos, grid_pos)
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_right"):
		move(0)
	elif Input.is_action_just_pressed("ui_down"):
		move(1)
	elif Input.is_action_just_pressed("ui_left"):
		move(2)
	elif Input.is_action_just_pressed("ui_up"):
		move(3)
	
