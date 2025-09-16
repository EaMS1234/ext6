extends Control

signal executar()
signal mover(dir)

var comandos = []

func add_elemento(acao):
	comandos.append(acao)
	atualizar_label()

func rm_elemento():
	comandos.pop_back()
	atualizar_label()

func atualizar_label():
	$Label.text = ""
	for cmd in comandos:
		$Label.text += (cmd + "\n")

func _on_executar_pressed() -> void:
	executar.emit()
	
	for cmd in comandos:
		mover.emit(cmd)
		# print(cmd)

func _on_remover_pressed() -> void:
	rm_elemento()

func _on_cima_pressed() -> void:
	add_elemento("u")

func _on_baixo_pressed() -> void:
	add_elemento("d")

func _on_esquerda_pressed() -> void:
	add_elemento("l")

func _on_direita_pressed() -> void:
	add_elemento("r")
