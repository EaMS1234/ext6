extends Node

const GRID_WIDTH = 10
const GRID_HEIGHT = 10

var grid = []

var ObstacleScene = preload("res://scenes/obstacleScene.tscn")
var playerScene = preload("res://scenes/playerScene.tscn")
var winningCellScene = preload("res://scenes/winningCell.tscn")

var player = null
func _ready():
	for x in range(GRID_WIDTH):
		var col = []
		for y in range(GRID_HEIGHT):
			col.append(null)
		grid.append(col)
		
	var obstacle_positions = [
		Vector2(2, 2),
		Vector2(3, 4),
		Vector2(5, 1),
		Vector2(7, 7),
	]

	for pos in obstacle_positions:
		spawn_obstacle(pos)
	
	spawn_winningCell(Vector2(1, 1))
	spawn_winningCell(Vector2(1, 5))
	player = spawn_player(Vector2(0, 0))
	
func spawn_obstacle(pos: Vector2):
	var obstacle = ObstacleScene.instantiate()
	grid[pos.x][pos.y] = obstacle
	add_child(obstacle)
	obstacle.setup(pos, self)

func spawn_player(pos: Vector2):
	player = playerScene.instantiate()
	grid[pos.x][pos.y] = player
	add_child(player)
	player.setup(pos, self, $Control)
	player.updatePlayerPosition.connect(updatePlayerPosition)
	return player

func spawn_winningCell(pos: Vector2):
	var winningCell = winningCellScene.instantiate()
	grid[pos.x][pos.y] = winningCell
	add_child(winningCell)
	winningCell.setup(pos, self)


func is_cell_valid(pos: Vector2) -> bool:
	if pos.x < 0 or pos.x >= GRID_WIDTH or pos.y < 0 or pos.y >= GRID_HEIGHT:
		return false
	return true

func set_cell(pos: Vector2, obj):
	if pos.x < 0 or pos.x >= GRID_WIDTH or pos.y < 0 or pos.y >= GRID_HEIGHT:
		return
	grid[pos.x][pos.y] = obj

func clear_cell(pos: Vector2):
	if pos.x < 0 or pos.x >= GRID_WIDTH or pos.y < 0 or pos.y >= GRID_HEIGHT:
		return
	grid[pos.x][pos.y] = null
	
func cell_type_at(pos: Vector2):
	return grid[pos.x][pos.y]
	
func is_cell_empty(pos: Vector2):
	return grid[pos.x][pos.y] == null
	
#Métodos responsáveis por dar update na grid
func updatePlayerPosition(old_pos, new_position):
	print("Grid recebeu: Player foi para ", new_position)
	grid[old_pos.x][old_pos.y] = null
	if (!is_cell_empty(new_position)):
		print(grid[new_position.x][new_position.y].name)
		if grid[new_position.x][new_position.y].name == "winningCell":
			print("VENCEU")
	player.setup(new_position, self, $Control)
	
		
	
