extends Node

const GRID_WIDTH = 10
const GRID_HEIGHT = 10

var grid = []

var ObstacleScene = preload("res://scenes/obstacleScene.tscn")
var playerScene = preload("res://scenes/playerScene.tscn")

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

	spawn_player(Vector2(0, 0))
	
func spawn_obstacle(pos: Vector2):
	var obstacle = ObstacleScene.instantiate()
	grid[pos.x][pos.y] = obstacle
	add_child(obstacle)
	obstacle.setup(pos, self)

func spawn_player(pos: Vector2):
	var player = playerScene.instantiate()
	grid[pos.x][pos.y] = player
	add_child(player)
	player.setup(pos, self)

func is_cell_free(pos: Vector2) -> bool:
	if pos.x < 0 or pos.x >= GRID_WIDTH or pos.y < 0 or pos.y >= GRID_HEIGHT:
		return false
	return grid[pos.x][pos.y] == null

func set_cell(pos: Vector2, obj):
	if pos.x < 0 or pos.x >= GRID_WIDTH or pos.y < 0 or pos.y >= GRID_HEIGHT:
		return
	grid[pos.x][pos.y] = obj

func clear_cell(pos: Vector2):
	if pos.x < 0 or pos.x >= GRID_WIDTH or pos.y < 0 or pos.y >= GRID_HEIGHT:
		return
	grid[pos.x][pos.y] = null
