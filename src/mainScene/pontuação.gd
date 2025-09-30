extends Label

var pontuação = 100000
func _process(delta: float) -> void:
	text = str(pontuação)

func removerPontos(pontos):
	pontuação -= pontos
	
func adicionarPontos(pontos):
	pontuação += pontos
