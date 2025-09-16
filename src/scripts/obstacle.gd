extends Node2D

var grid_controller
var grid_pos: Vector2

func setup(pos: Vector2, controller):
	grid_controller = controller
	grid_pos = pos
	grid_controller.set_cell(grid_pos, self)
	position = grid_pos * 16
