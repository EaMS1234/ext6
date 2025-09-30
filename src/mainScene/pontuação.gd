extends Label

var pontuação = 100000
var pontosDecrementar = 0
var pontuaçãoVerdadeira = 100000

func _process(delta: float) -> void:
	text = str(pontuação)
	decrementar()
	

func removerPontos(pontos):
	pontosDecrementar += int(pontos)
	pontuaçãoVerdadeira -= int(pontos)
	
func decrementar():
	if pontosDecrementar > 100000:
		pontosDecrementar-= int(pontosDecrementar/10)
		pontuação -= int(pontosDecrementar/10)
	elif pontosDecrementar > 10000:
		pontosDecrementar-= int(1000 * 5.0)
		pontuação -= int(1000 * 5.0)
	elif pontosDecrementar > 1000:
		pontosDecrementar-= int(100 * 5.0)
		pontuação -= int(100 * 5.0)
	elif pontosDecrementar > 100:
		pontosDecrementar-= int(10 * 5.0)
		pontuação -= int(10 * 5.0)
	elif pontosDecrementar > 0:
		pontosDecrementar-= 1
		pontuação -= 1
func adicionarPontos(pontos):
	pontuação += pontos
