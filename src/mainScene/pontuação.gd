extends Label

var pontuação = 100000
var pontosDecrementar = 0
func _process(delta: float) -> void:
	text = str(pontuação)
	decrementar()

func removerPontos(pontos):
	pontosDecrementar += pontos
	
func decrementar():
	if pontosDecrementar > 10000:
		pontuação -= int(1000 * 3.0)
		pontosDecrementar-= int(1000 * 3.0)
	elif pontosDecrementar > 1000:
		pontuação -= int(100 * 3.0)
		pontosDecrementar-= int(100 * 3.0)
	elif pontosDecrementar > 100:
		pontuação -= int(10 * 3.0)
		pontosDecrementar-= int(10 * 3.0)
	
func adicionarPontos(pontos):
	pontuação += pontos
