extends Control

signal executar()
signal mover(dir)


# Assets a serem carregados na memória
var bloco_comando = load("res://scenes/bloco_comando.tscn")


# Número de blocos de código por linha
@export var max_blocos_linha = 5

# Posição do próximo comando no visor da lista
var linha = 0
var coluna = 0

# Lista de comandos a serem executados em ordem
var comandos = []

# O modo do mouse define se o jogador está segurando um bloco ou não.
var modo = false

# Adiciona um bloco temporário à cena e define o modo do mouse. Blocos
# temporários são "fantasmas" que são arrastados pelo mouse.
func add_elemento(acao):
	if not modo:
		# Adiciona um bloco temporário
		var bloco_temp = StaticBody2D.new()
		bloco_temp.add_to_group("bloco_temporario")
		bloco_temp.add_child(Sprite2D.new())
		self.add_child(bloco_temp)
		
		# Escolhe a sprite do bloco
		bloco_temp.get_child(0).texture = load("res://assets/sprites/arrow.png")
		match acao:
			"l":
				bloco_temp.get_child(0).flip_h = true
				
			"u":
				bloco_temp.rotation_degrees = 270
			
			"d":
				bloco_temp.rotation_degrees = 90
		
		# Define o tipo do bloco
		bloco_temp.set_meta("tipo", acao)
		
		modo = true

# Remove um comando da lista
func rm_elemento():
	if get_tree().get_node_count_in_group("bloco_comando") != 0:
		get_tree().get_nodes_in_group("bloco_comando")[-1].queue_free()
		
		if coluna == 0 and linha >= 1:
			coluna = 4
			linha -= 1
		
		elif coluna >= 1:
			coluna -= 1
	
	comandos.pop_back()


# Função principal
func _process(_delta: float) -> void:
	if modo:
		# Posiciona o ícone do bloco em baixo do mouse
		var mouse = get_viewport().get_mouse_position()
		for bloco in get_tree().get_nodes_in_group("bloco_temporario"):
			bloco.position = mouse
		
		# Se o mouse for solto
		if Input.is_action_just_released("mouse_release"):
			if modo and mouse_dentro:
				
				comandos.append(get_tree().get_nodes_in_group("bloco_temporario")[0].get_meta("tipo"))
				
				var bloco = bloco_comando.instantiate()
				$InputList.add_child(bloco)
				bloco.tipo = comandos[-1]
				
				bloco.position.x = 8 + coluna * 64
				bloco.position.y = 8 + linha * 64
				
				if coluna == max_blocos_linha - 1:
					linha += 1
					coluna = 0
				
				else:
					coluna += 1
				
				print("linha: ", linha)
				print("coluna: ", coluna)
			
			get_tree().call_group("bloco_temporario", "queue_free")
			modo = false


# Os métodos abaixo invocam a criação do bloco quando o botão é acionado
func _on_cima_button_down() -> void:
	add_elemento("u")

func _on_esquerda_button_down() -> void:
	add_elemento("l")

func _on_direita_button_down() -> void:
	add_elemento("r")

func _on_baixo_button_down() -> void:
	add_elemento("d")


# Funcionalidade dos botões "remover" e "executar"
func _on_executar_pressed() -> void:
	executar.emit()
	
	for cmd in comandos:
		mover.emit(cmd)
		# print(cmd)

func _on_remover_pressed() -> void:
	rm_elemento()


# Os métodos e atributos abaixo verificam se o mouse está na área correta
var mouse_dentro = false

func _on_input_list_mouse_entered() -> void:
	mouse_dentro = true

func _on_input_list_mouse_exited() -> void:
	mouse_dentro = false
