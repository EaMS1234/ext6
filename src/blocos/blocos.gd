extends Control

signal executar()
signal mover(dir)
signal finalizar()


# Assets a serem carregados na memória
var bloco_comando = load("res://blocos/bloco_comando/bloco_comando.tscn")

var sobre_bloco = null

# Número de blocos de código por linha
@export var max_blocos_linha = 6

# Tempo de espera entre o envio dos sinais de movimentação (milisegundos)
@export var delay = 250

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
		bloco_temp.get_child(0).texture = load("res://blocos/arrow.png")
		match acao:
			"r":
				pass
			
			"l":
				bloco_temp.get_child(0).flip_h = true
				
			"u":
				bloco_temp.rotation_degrees = 270
			
			"d":
				bloco_temp.rotation_degrees = 90
			
			"end":
				bloco_temp.get_child(0).texture = load("res://blocos/end.png")
			
			_:
				bloco_temp.get_child(0).texture = load("res://blocos/loop.png")
				
				var num = Label.new()
				bloco_temp.add_child(num)
				num.position.x -= 24
				num.position.y -= 24
				num.text = acao
		
		# Define o tipo do bloco
		bloco_temp.set_meta("tipo", acao)
		
		modo = true

# Remove um comando da lista
func rm_elemento(pos_fila):
	if get_tree().get_node_count_in_group("bloco_comando") > 0:
		if pos_fila < 0:
			pos_fila = get_tree().get_node_count_in_group("bloco_comando")
		
		# Atualiza a posição dos blocos restantes
		for cmd in get_tree().get_nodes_in_group("bloco_comando"):
			if cmd.pos_fila == pos_fila:
				cmd.queue_free()
			
			if cmd.pos_fila > pos_fila:
				cmd.pos_fila -= 1
				
				posicionar_elemento(cmd)

# Posiciona um bloco de comando na visualização
func posicionar_elemento(bloco):
	var coluna = (bloco.pos_fila - 1) % 5
	var linha = (bloco.pos_fila - 1) / 5
	
	bloco.position.x = 8 + coluna * 32
	bloco.position.y = 8 + linha * 32

func reposicionar_elemento(bloco):
	for cmd in get_tree().get_nodes_in_group("bloco_comando"):
		if cmd.pos_fila >= bloco.pos_fila:
			cmd.pos_fila += 1
			posicionar_elemento(cmd)


# Função principal
func _process(_delta: float) -> void:
	if modo and get_tree().get_node_count_in_group("input_loop") == 0:
		# Posiciona o ícone do bloco em baixo do mouse
		var mouse = get_viewport().get_mouse_position()
		for bloco in get_tree().get_nodes_in_group("bloco_temporario"):
			bloco.position = mouse
		
		# Se o mouse for solto
		if Input.is_action_just_released("mouse_click"):
			if modo and mouse_dentro:
				var bloco = bloco_comando.instantiate()
				$InputList.add_child(bloco)
				bloco.clicado.connect(_on_clicado)
				bloco.entrar.connect(_on_comando_entrar)
				bloco.sair.connect(_on_comando_sair)
				bloco.tipo = get_tree().get_nodes_in_group("bloco_temporario")[0].get_meta("tipo")
				bloco.pos_fila = get_tree().get_node_count_in_group("bloco_comando")
				
				posicionar_elemento(bloco)
			
			elif modo and sobre_bloco != null:
				var pos = sobre_bloco.pos_fila
				
				reposicionar_elemento(sobre_bloco)
				
				var bloco = bloco_comando.instantiate()
				$InputList.add_child(bloco)
				bloco.clicado.connect(_on_clicado)
				bloco.entrar.connect(_on_comando_entrar)
				bloco.sair.connect(_on_comando_sair)
				bloco.tipo = get_tree().get_nodes_in_group("bloco_temporario")[0].get_meta("tipo")
				bloco.pos_fila = pos
				
				posicionar_elemento(bloco)
			
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

func _on_loop_button_down() -> void:
	add_elemento("5")

func _on_end_button_down() -> void:
	add_elemento("end")


# Funcionalidade dos botões "remover" e "executar"
func _on_executar_pressed() -> void:
	executar.emit()
	
	var lista = get_tree().get_nodes_in_group("bloco_comando")
	lista.sort_custom(func(a, b): return a.pos_fila < b.pos_fila)
	
	# Fila de ações a serem emitidas
	var fila = []
	
	var stack_pos = []  # Marca a posição inicial de um loop
	var stack_qtd = []  # Marca a quantidade de repetições do loop
	
	var i = 0
	while i < len(lista):
		print("Passo ", i)
		
		var cmd = lista[i]
		
		# Início de loop
		if not cmd.tipo in ["u", "d", "l", "r", "end"]:
			stack_pos.push_front(i)
			stack_qtd.push_front(int(cmd.tipo) - 1)
		
		# Retorna ao início do loop
		elif cmd.tipo == "end" and not stack_qtd.is_empty():
			if stack_qtd.front() > 0:
				i = stack_pos.front()
				stack_qtd.push_front(stack_qtd.pop_front() - 1)
			
			# Fim do looping
			else:
				stack_qtd.pop_front()
				stack_pos.pop_front()
		
		# Adiciona as ações à fila
		else:
			print(cmd.tipo)
			fila.append(cmd.tipo)
			
		i += 1
	
	# Emite cada ação da fila com um delay
	while not fila.is_empty():
		mover.emit(fila.front())
		fila.pop_front()
		await get_tree().create_timer(delay / 1000.0).timeout
	
	finalizar.emit()

func _on_remover_pressed() -> void:
	rm_elemento(-1)


# Os métodos e atributos abaixo verificam se o mouse está na área correta
var mouse_dentro = false

func _on_input_list_mouse_entered() -> void:
	mouse_dentro = true

func _on_input_list_mouse_exited() -> void:
	mouse_dentro = false


# Espera pela seleção de um bloco de comando
func _on_clicado(caminho) -> void:
	if not modo:
		var bloco = get_node(caminho)
		add_elemento(bloco.tipo)
		rm_elemento(bloco.pos_fila)


# Verifica se o mouse está sobre um bloco de comando.
func _on_comando_entrar(path) -> void:
	sobre_bloco = get_node(path)

func _on_comando_sair() -> void:
	sobre_bloco = null
