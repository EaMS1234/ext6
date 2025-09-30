extends Label

var pontuação = 100000
var pontosDecrementar = 0
func _process(delta: float) -> void:
	text = str(pontuação)
	decrementar()

func removerPontos(pontos):
	pontosDecrementar += int(pontos)
	
func decrementar():
	if pontosDecrementar > 100000:
		pontuação -= int(pontosDecrementar/10)
		pontosDecrementar-= int(pontosDecrementar/10)
	elif pontosDecrementar > 10000:
		pontuação -= int(1000 * 5.0)
		pontosDecrementar-= int(1000 * 5.0)
	elif pontosDecrementar > 1000:
		pontuação -= int(100 * 5.0)
		pontosDecrementar-= int(100 * 5.0)
	elif pontosDecrementar > 100:
		pontuação -= int(10 * 5.0)
		pontosDecrementar-= int(10 * 5.0)
	
func adicionarPontos(pontos):
	pontuação += pontos
