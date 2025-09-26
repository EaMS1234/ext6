extends Node

const GRID_WIDTH = 10
const GRID_HEIGHT = 10

var original_grid = []
var backup_grid = null

var obstacle_scene = preload("res://gridController/obstacleScene/obstacleScene.tscn")
var player_scene = preload("res://gridController/playerScene/playerScene.tscn")
var winning_Cell_Scene = preload("res://scenes/winningCell.tscn")
var player = null

func _ready():
	var control = $Control  
	control.connect("executar", on_executar)
	control.connect("finalizar", on_finalizar)
	generateLevel()
	
func generateLevel():
	for x in range(GRID_WIDTH):
		var col = []
		for y in range(GRID_HEIGHT):
			col.append(null)
		original_grid.append(col)
	
	var obstacle_positions = [
		Vector2(2, 0),
		Vector2(2, 1),
		Vector2(2, 2),
		Vector2(2, 3),
		Vector2(2, 4),
		Vector2(2, 5),
		Vector2(2, 6),
		Vector2(2, 7),
		Vector2(5, 3),
		Vector2(5, 4),
		Vector2(5, 5),
		Vector2(5, 6),
		Vector2(5, 7),
		Vector2(5, 8),
		Vector2(5, 9),
		Vector2(6, 3),
		Vector2(7, 3),
	]
	for pos in obstacle_positions:
		spawn_obstacle(pos)
	
	spawn_winningCell(Vector2(7, 5))
	player = spawn_player(Vector2(0, 0))
func spawn_obstacle(pos: Vector2):
	var obstacle = obstacle_scene.instantiate()
	original_grid[pos.x][pos.y] = obstacle
	add_child(obstacle)
	obstacle.setup(pos, self)

func spawn_player(pos: Vector2):
	player = player_scene.instantiate()
	original_grid[pos.x][pos.y] = player
	add_child(player)
	player.setup(pos, self, $Control)
	player.updatePlayerPosition.connect(updatePlayerPosition)
	return player

func spawn_winningCell(pos: Vector2):
	var winningCell = winning_Cell_Scene.instantiate()
	original_grid[pos.x][pos.y] = winningCell
	add_child(winningCell)
	winningCell.setup(pos, self)


func is_cell_valid(pos: Vector2) -> bool:
	if pos.x < 0 or pos.x >= GRID_WIDTH or pos.y < 0 or pos.y >= GRID_HEIGHT:
		return false
	return true

func set_cell(pos: Vector2, obj):
	if pos.x < 0 or pos.x >= GRID_WIDTH or pos.y < 0 or pos.y >= GRID_HEIGHT:
		return
	original_grid[pos.x][pos.y] = obj

func clear_cell(pos: Vector2):
	if pos.x < 0 or pos.x >= GRID_WIDTH or pos.y < 0 or pos.y >= GRID_HEIGHT:
		return
	original_grid[pos.x][pos.y] = null
	
func cell_type_at(pos: Vector2):
	return original_grid[pos.x][pos.y]
	
func is_cell_empty(pos: Vector2):
	return original_grid[pos.x][pos.y] == null
	
#Métodos responsáveis por dar update na grid
func updatePlayerPosition(old_pos, new_position):
	print("Grid recebeu: Player foi para ", new_position)
	original_grid[old_pos.x][old_pos.y] = null
	if (!is_cell_empty(new_position)):
		print(original_grid[new_position.x][new_position.y].name)
		if original_grid[new_position.x][new_position.y].type == "winningCell":
			print("VENCEU")
		elif original_grid[new_position.x][new_position.y].type == "obstacle":
			#Perder pontos e voltar posição
			new_position = old_pos
	player.setup(new_position, self, $Control)
	
func on_executar():
	backup_grid = original_grid
	
func on_finalizar():
	#contalizar pontuação e reiniciar posições (não está funcionando ainda)
	original_grid = backup_grid
	updatePlayerPosition(player.grid_pos, Vector2(0, 0))
	
