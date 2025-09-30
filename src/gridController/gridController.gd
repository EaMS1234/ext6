extends Node

const GRID_WIDTH = 10
const GRID_HEIGHT = 10

var original_grid = []
var backup_grid = null
var venceu = false

@export var obstacle_positions : Array[Vector2]
@export var fishhook_positions : Array[Vector2]
@export var init_player_pos : Vector2
@export var win_cell_pos : Vector2
@export var minInstructions : int

var obstacle_scene = preload("res://gridController/obstacleScene/obstacleScene.tscn")
var player_scene = preload("res://gridController/playerScene/playerScene.tscn")
var winning_Cell_Scene = preload("res://gridController/winningCell/winningCell.tscn")
var fishhook_Scene = preload("res://gridController/fishhookScene/fishhookScene.tscn")
var vitoria = preload("res://vitoria/vitoria.tscn")
var _pontuacaoPerdida = preload("res://mainScene/pontuacaoPerdida.tscn")
var player = null
var playerOriginalPos = Vector2(0, 0)

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
		mostrar_pontuacao_perdida(pos.x * 16, pos.y * 16, 1000)	
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
	#print("Grid recebeu: Player foi para ", new_position)
	original_grid[old_pos.x][old_pos.y] = null
	if (!is_cell_empty(new_position)):
		print(original_grid[new_position.x][new_position.y].name)
		if original_grid[new_position.x][new_position.y].type == "winningCell":
			venceu = true
		elif original_grid[new_position.x][new_position.y].type == "obstacle":
			#Perder pontos e voltar posição
			new_position = old_pos
			mostrar_pontuacao_perdida(new_position.x * 16, new_position.y * 16, 1000)	
		elif original_grid[new_position.x][new_position.y].type == "fishhook":
			#Perder pontos e voltar posição
			mostrar_pontuacao_perdida(new_position.x * 16, new_position.y * 16, 2000)
			new_position = playerOriginalPos
			
			$Control.fila = []

	player.setup(new_position, self, $Control)
	
func mostrar_pontuacao_perdida(x, y, pontos):
	$LabelPontuacao.removerPontos(pontos)
	var pontuacao_perdida = _pontuacaoPerdida.instantiate()
	pontuacao_perdida.get_child(0).pontuacaoPerdida = pontos
	pontuacao_perdida.position.x = x
	pontuacao_perdida.position.y = y
	pontuacao_perdida.scale = Vector2(0.5, 0.5)
	add_child(pontuacao_perdida)

func on_executar(instrucoes_usadas):
	backup_grid = original_grid
	playerOriginalPos = player.grid_pos
	
	
func on_finalizar(instrucoes_usadas):
	original_grid = backup_grid
	var dec = pow(5, (instrucoes_usadas - minInstructions))
	if dec <= 1:
		dec = 0
	else:
		mostrar_pontuacao_perdida(20, 200, dec)
		
	if venceu == false:
		updatePlayerPosition(player.grid_pos, playerOriginalPos)
		mostrar_pontuacao_perdida(0, 0, 10000)	
	else:
		var instancia = vitoria.instantiate()
		$Control.fila = []
		get_parent().add_child(instancia)
		instancia.pontos = $LabelPontuacao.pontuaçãoVerdadeira
