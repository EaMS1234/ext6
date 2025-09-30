extends Node

const GRID_WIDTH = 10
const GRID_HEIGHT = 10

var original_grid = []
var backup_grid = null

@export var obstacle_positions : Array[Vector2]
@export var fishhook_positions : Array[Vector2]
@export var init_player_pos : Vector2
@export var win_cell_pos : Vector2

var obstacle_scene = preload("res://gridController/obstacleScene/obstacleScene.tscn")
var player_scene = preload("res://gridController/playerScene/playerScene.tscn")
var winning_Cell_Scene = preload("res://gridController/winningCell/winningCell.tscn")
var fishhook_Scene = preload("res://gridController/fishhookScene/fishhookScene.tscn")
var vitoria = preload("res://vitoria/vitoria.tscn")
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

	for pos in obstacle_positions:
		spawn_obstacle(pos)
		
	for pos in fishhook_positions:
		spawn_fishhook(pos)

	spawn_winningCell(win_cell_pos)
	player = spawn_player(init_player_pos)
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

func spawn_fishhook(pos: Vector2):
	var fishhook = fishhook_Scene.instantiate()
	original_grid[pos.x][pos.y] = fishhook
	add_child(fishhook)
	fishhook.setup(pos, self)


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
			
			var instancia = vitoria.instantiate()
			
			$Control.fila = []
			
			get_parent().add_child(instancia)
			
		elif original_grid[new_position.x][new_position.y].type == "obstacle":
			#Perder pontos e voltar posição
			new_position = old_pos
	player.setup(new_position, self, $Control)
	
func on_executar():
	backup_grid = original_grid
	
func on_finalizar():
	#contalizar pontuação e reiniciar posições (não está funcionando ainda)
	original_grid = backup_grid
	
	if get_tree().get_node_count_in_group("tela_vitoria") == 0:
		updatePlayerPosition(player.grid_pos, Vector2(0, 0))
	
