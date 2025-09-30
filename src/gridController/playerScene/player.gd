extends Node2D

var type = "player"
var grid_controller
var grid_pos = Vector2()
signal updatePlayerPosition(oldPosition, newPosition)

func setup(pos: Vector2, gridController, gameControl):
	grid_controller = gridController
	grid_pos = pos
	grid_controller.set_cell(grid_pos, self)
	position = (grid_pos * 16)
	position.x += 8
	position.y += 8
	gameControl.mover.connect(move)
	
func move(dir):
	var old_pos = grid_pos
	#Direita
	if dir == "r":
		scale.x = 1
		if grid_controller.is_cell_valid(Vector2(grid_pos.x+1, grid_pos.y)):
			grid_pos.x+=1
	elif dir == "d":
		if grid_controller.is_cell_valid(Vector2(grid_pos.x, grid_pos.y+1)):
			grid_pos.y+=1
	elif dir == "l":
		scale.x = -1
		if grid_controller.is_cell_valid(Vector2(grid_pos.x-1, grid_pos.y)):
			grid_pos.x-=1
	elif dir == "u":
		if grid_controller.is_cell_valid(Vector2(grid_pos.x, grid_pos.y-1)):
			grid_pos.y-=1
	emit_signal("updatePlayerPosition", old_pos, grid_pos)
