extends Label

var pontuacaoPerdida = 0
func _ready():
	self.text = str(pontuacaoPerdida)
	

func _process(delta: float) -> void:
	self.text = str(int(pontuacaoPerdida))
	self.position.y -= 0.5
	self.position.x += 0.5
	self.scale.x -= 0.01
	self.scale.y -= 0.01
	if scale.x < 0.45:
		queue_free()
